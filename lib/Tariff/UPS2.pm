#!/usr/bin/perl -w

#==========================================================
#   Project:	ARRS
#
#   Filename:	UPS.pm
#
#   Date:		05/15/2014
#
#   Purpose:	Rate against our UPS Ship Manager Server
#
#   Company:	Aloha Technology Pvt Ltd
#
#   Author(s):	Imran Momin
#
#==========================================================


package Tariff::UPS2;

use strict;
use Data::Dumper;
use POSIX qw(ceil);
use ARRS::IDBI;
use ARRS::COMMON;
use ARRS::SERVICE;
use LWP::UserAgent;
use HTTP::Request::Common;
use ARRS::CUSTOMERSERVICE;
use IntelliShip::MyConfig;

my $Debug = 0;
my $config = IntelliShip::MyConfig->get_ARRS_configuration;

sub new
{
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my $self = {};

	$self->{'dbref'} = ARRS::IDBI->connect({
		dbname     => 'arrs',
		dbhost     => 'localhost',
		dbuser     => 'webuser',
		dbpassword => 'Byt#Yu2e',
		autocommit => 1
		});

	bless($self, $class);

	return $self;
}

sub GetAssCode
{
	my $self = shift;
	my ($csid,$serviceid,$name) = @_;
	warn "USPS GetAssCode($csid,$serviceid,$name)";

	my $SQL = "
	 SELECT DISTINCT
		asscode,ownertypeid
	 FROM
		assdata
	 WHERE
		( (ownerid = ? AND ownertypeid = 4) OR (ownerid = ? AND ownertypeid = 3) )
		AND assname = ?
	 ORDER BY ownertypeid desc
	";

	my $STH = $self->{'dbref'}->prepare($SQL) or die "Could not prepare asscode select sql statement";

	$STH->execute($csid,$serviceid,$name) or die "Could not execute asscode select sql statement";

	my ($code,$ownertypeid) = $STH->fetchrow_array();

	$STH->finish();
	warn "USPS GetAssCode returns asscode=$code";
	return $code;
}

sub GetCost
{
	my $self = shift;
	my ($Weight,$DiscountPercent,$Class,$OriginZip,$DestZip,$SCAC,$DateShipped,$Required_Asses,$FileID,$ClientID,$CSID,$ServiceID,$ToCountry,$CustomerID,$DimHeight,$DimWidth,$DimLength,$FromCountry,$FromCity,$FromState,$ToCity,$ToState) = @_;

	my $Benchmark = 0;
	my $S_ = &Benchmark() if $Benchmark;
	warn "UPS2->GetCost()->$Weight,$DiscountPercent,$Class,$OriginZip,$DestZip,$SCAC,$DateShipped,$Required_Asses,$ClientID,$CSID,$ServiceID,$ToCountry";

	my $Cost = -1;
	my $days = 0;
	my $errorcode = 0;

	warn "... UPS2 GetTransit()";
	warn "... CUSTOMERID: $CustomerID";

	my $CS = new ARRS::CUSTOMERSERVICE($self->{'dbref'}, $self->{'contact'});
	$CS->{'object_issuper'} = 1;
	$CS->Load($CSID);

	my $AcctNum = $CS->GetCSValue('webaccount',undef,$CustomerID);
	my $MeterNum = $CS->GetCSValue('meternumber',undef,$CustomerID);

	eval {
	($days,$Cost,$errorcode) = $self->GetTransit($SCAC,$OriginZip,$DestZip,$Weight,$Class,$DateShipped,$Required_Asses,$FileID,$ClientID,$CSID,$ServiceID,$ToCountry,$AcctNum,$MeterNum,$DimHeight,$DimWidth,$DimLength,$FromCountry,$FromCity,$FromState,$ToCity,$ToState);
	};
	warn "Error: " . $@ if $@;
	if ( $days )
		{
		if ( $errorcode )
			{
			warn "ERRORCODE=>$errorcode";
			}
		}
	else
		{
		warn "NO eFreight TRANSIT => SCAC-$SCAC";
		}

	warn "UPS, return cost $Cost transit=$days for $SCAC" if $Benchmark;
	&Benchmark($S_,"USPS: $SCAC - \$$Cost") if $Benchmark;

	return ($Cost,$days);
}

my $UPS_ACCT_DETAILS = {
	F5618Y => { USERNAME => 'tsharp212', PASSWORD => 'Tony212!@' },
	AW5282 => { USERNAME => 'SprintAW5282', PASSWORD => '2wsx!QAZ' },
	};

sub GetTransit
{
	my $self = shift;

	my ($scac,$oazip,$dazip,$weight,$class,$dateshipped,$required_asses,$fileid,$clientid,$csid,$serviceid,$tocountry,$acctnum,$meternum,$height,$width,$length,$fromcountry,$fromcity,$fromstate,$tocity,$tostate) = @_;

	if ( !$fileid ) { $fileid = 'test' }

	#warn "UPS2: GetTrasit($scac,$oazip,$dazip,$weight,$class,$dateshipped,$required_asses,$fileid,$clientid,$csid,$serviceid,$tocountry,$acctnum,$meternum)";

	my $STH = $self->{'dbref'}->prepare("SELECT servicename, servicecode FROM service WHERE serviceid = ?") or die "Could not prepare asscode select sql statement";
	$STH->execute($serviceid) or die "Could not execute asscode select sql statement";
	my ($servicename, $servicecode) = $STH->fetchrow_array;
	$STH->finish();

	warn "\nService: " . $servicename . "\nServiceCode:" . $servicecode . "\nAccountNumber: " . $acctnum;

	my $path = "$config->{BASE_PATH}/bin/run";
	my $file = $fileid . ".info";
	my $File = $path . "/" . $file;
	my $Days = 0;
	my $cost = -1;
	my $ErrorCode;

	warn "UPS: FILE=$File";

	## only use 5 digits.  won't rate with zip plus 4
	if ( defined($oazip) && $oazip !~ /^\d{5}$/ )
		{
		$oazip = substr($oazip,0,5);
		}

	if ( defined($dazip) && $dazip !~ /^\d{5}$/ )
		{
		$dazip = substr($dazip,0,5);
		}

	$height = ceil($height);
	$width  = ceil($width);
	$length = ceil($length);
	$weight = ceil($weight);

	my $UserId = $UPS_ACCT_DETAILS->{$acctnum}->{USERNAME};
	my $Password = $UPS_ACCT_DETAILS->{$acctnum}->{PASSWORD};

	my $XML = "<?xml version=\"1.0\"?>
<AccessRequest xml:lang=\"en-US\">
	<AccessLicenseNumber>7CD03B13C7D39706</AccessLicenseNumber>
	<UserId>$UserId</UserId>
	<Password>$Password</Password>
</AccessRequest>
<?xml version=\"1.0\"?>
<RatingServiceSelectionRequest xml:lang=\"en-US\">
	<Request>
	<TransactionReference>
		<CustomerContext>Rating and Service</CustomerContext>
		<XpciVersion>1.0</XpciVersion>
	</TransactionReference>
	<RequestAction>Rate</RequestAction>
	<RequestOption>Rate</RequestOption>
	</Request>
	<PickupType>
		<Code>07</Code>
		<Description>Rate</Description>
	</PickupType>
	<Shipment>
		<Description>Rate Description</Description>
		<Shipper>
			<Name>Tony Sharps</Name>
			<PhoneNumber>1234567890</PhoneNumber>
			<ShipperNumber>$acctnum</ShipperNumber>
			<Address>
				<AddressLine1>Ste 102-302</AddressLine1>
				<City>Memphis</City>
				<StateProvinceCode>TN</StateProvinceCode>
				<PostalCode>38125</PostalCode>
				<CountryCode>US</CountryCode>
			</Address>
		</Shipper>
		<ShipTo>
			<CompanyName>XYZ</CompanyName>
			<PhoneNumber>1234567890</PhoneNumber>
			<Address>
				<AddressLine1>Ste 100</AddressLine1>
				<City>$tocity</City>
				<PostalCode>$dazip</PostalCode>
				<CountryCode>$tocountry</CountryCode>
			</Address>
		</ShipTo>
		<ShipFrom>
			<CompanyName>Engage Technology, LLC</CompanyName>
			<AttentionName></AttentionName>
			<PhoneNumber>1234567890</PhoneNumber>
			<FaxNumber>1234567890</FaxNumber>
			<Address>
				<AddressLine1>Ste 102-302</AddressLine1>
				<City>$fromcity</City>
				<StateProvinceCode>$fromstate</StateProvinceCode>
				<PostalCode>$oazip</PostalCode>
				<CountryCode>$fromcountry</CountryCode>
			</Address>
		</ShipFrom>
		<Service>
			<Code>$servicecode</Code>
		</Service>
		<PaymentInformation>
			<Prepaid>
				<BillShipper>
					<AccountNumber>$acctnum</AccountNumber>
				</BillShipper>
			</Prepaid>
		</PaymentInformation>
		<Package>
			<PackagingType>
				<Code>02</Code>
				<Description>Customer Supplied</Description>
			</PackagingType>
			<Description>Rate</Description>
			<PackageWeight>
				<UnitOfMeasurement>
					<Code>LBS</Code>
				</UnitOfMeasurement>
				<Weight>$weight</Weight>
			</PackageWeight>
		</Package>
		<ShipmentServiceOptions>
			<OnCallAir>
				<Schedule>
					<PickupDay>02</PickupDay>
					<Method>02</Method>
				</Schedule>
			</OnCallAir>
		</ShipmentServiceOptions>
		<RateInformation>
			<NegotiatedRatesIndicator></NegotiatedRatesIndicator>
		</RateInformation>
	</Shipment>
</RatingServiceSelectionRequest>";

	my $ShipmentReturn = $self->ProcessLocalRequest($XML);

	## Check return string for errors;

	if ( $ShipmentReturn->{Response}->{ResponseStatusDescription} =~ /Success/i )
		{
		my $RatedShipment = $ShipmentReturn->{RatedShipment};
		$cost = $RatedShipment->{TotalCharges}->{MonetaryValue};
		$cost = $RatedShipment->{NegotiatedRates}->{NetSummaryCharges}->{GrandTotal}->{MonetaryValue} if $RatedShipment->{NegotiatedRates};
		$Days = $1 if $RatedShipment->{GuaranteedDaysToDelivery} =~ m/(\d+)/;
		warn "######### GuaranteedDaysToDelivery: $Days" ;
		if(!$Days || $Days eq '' || $Days eq '{}')
		{
			my $TransitXml = "<?xml version=\"1.0\" ?>
					<AccessRequest xml:lang='en-US'>
						<AccessLicenseNumber>7CD03B13C7D39706</AccessLicenseNumber>
						<UserId>$UserId</UserId>
						<Password>$Password</Password>
					</AccessRequest>
					<?xml version=\"1.0\" ?>
					<TimeInTransitRequest xml:lang='en-US'>
						<Request>
							<TransactionReference>
								<CustomerContext>TNT_D Origin Country Code</CustomerContext>
								<XpciVersion>1.0002</XpciVersion>
							</TransactionReference>
							<RequestAction>TimeInTransit</RequestAction>
						</Request>
						<TransitFrom>
							<AddressArtifactFormat>
								<PoliticalDivision2>$fromcity</PoliticalDivision2>
								<PoliticalDivision1>$fromstate</PoliticalDivision1>
								<CountryCode>$fromcountry</CountryCode>
								<PostcodePrimaryLow>$oazip</PostcodePrimaryLow>
							</AddressArtifactFormat>
						</TransitFrom>
						<TransitTo>
							<AddressArtifactFormat>
								<PoliticalDivision2>$tocity</PoliticalDivision2>
								<PoliticalDivision1>$tostate</PoliticalDivision1>
								<CountryCode>$tocountry</CountryCode>
								<PostcodePrimaryLow>$dazip</PostcodePrimaryLow>
							</AddressArtifactFormat>
						</TransitTo>
						<ShipmentWeight>
							<UnitOfMeasurement>
								<Code>LBS</Code>
								<Description>Pounds</Description>
							</UnitOfMeasurement>
							<Weight>$weight</Weight>
						</ShipmentWeight>						
						<PickupDate>$dateshipped</PickupDate>
						<DocumentsOnlyIndicator />
					</TimeInTransitRequest>";
			
			#warn "########## TransitXml: $TransitXml";
			
			my $TransitReturn = $self->ProcessTransitRequest($TransitXml);			
			#warn "########### TRANSIT : ". Dumper($TransitReturn); 
			my $ServiceSummary = $TransitReturn->{TransitResponse}->{ServiceSummary};			
			#warn "########### \$ServiceSummary: " . Dumper($ServiceSummary);
			
			foreach my $summary (@$ServiceSummary)
			{
				#warn "############ \$servicename = $servicename";				
				if($summary->{Service}->{Description} eq 'UPS '.$servicename){
					$Days = $summary->{EstimatedArrival}->{BusinessTransitDays};
					warn "########## Estimated Days: $Days";
				}
			}
		}
			
		}
	else
		{
		$ErrorCode = $ShipmentReturn->{Response}->{Error}->{ErrorCode} . " - " . $ShipmentReturn->{Response}->{Error}->{ErrorDescription};
		warn "UPS2 ShipManager Error: " . $ErrorCode;
		}

	warn "UPS2 RETURN DAYS|COST: |$Days|$cost|";
	return ($Days,$cost,$ErrorCode);
}

sub ProcessLocalRequest
	{
	my $self = shift;
	my $XML_request = shift;

	#warn "\n XML_request: " . $XML_request;

	#my $url = IntelliShip::MyConfig->getDomain eq 'PRODUCTION' ? 'https://onlinetools.ups.com/ups.app/xml/Rate' : 'https://wwwcie.ups.com/ups.app/xml/Rate';
	my $url = 'https://onlinetools.ups.com/ups.app/xml/Rate';

	#Send HTTP Request
	my $browser = LWP::UserAgent->new();
	my $req = HTTP::Request->new(POST => $url);
	$req->content("$XML_request");

	#Get HTTP Response Status
	my $response = $browser->request($req);
	unless ($response)
		{
		warn "USPS: Unable to access UPS site";
		return;
		}

	my $parser = new XML::Simple;
	my $XML_response = $response->content;
	#warn "XML_response: " . $XML_response;
	my $responseDS= $parser->XMLin($XML_response);

	#warn "Response DS: " . Dumper $responseDS;
	return $responseDS;
	}
	
sub ProcessTransitRequest
	{
	my $self = shift;
	my $XML_request = shift;

	#warn "\n XML_request: " . $XML_request;

	my $url = IntelliShip::MyConfig->getDomain eq 'PRODUCTION' ? 'https://onlinetools.ups.com/ups.app/xml/TimeInTransit' : 'https://wwwcie.ups.com/ups.app/xml/TimeInTransit';

	#Send HTTP Request
	my $browser = LWP::UserAgent->new();
	my $req = HTTP::Request->new(POST => $url);
	$req->content("$XML_request");

	#Get HTTP Response Status
	my $response = $browser->request($req);
	unless ($response)
		{
		warn "USPS: Unable to access UPS site";
		return;
		}

	my $parser = new XML::Simple;
	my $XML_response = $response->content;
	#warn "XML_response: " . $XML_response;
	my $responseDS= $parser->XMLin($XML_response);

	#warn "Response DS: " . Dumper $responseDS;
	return $responseDS;
	}


1

__END__
