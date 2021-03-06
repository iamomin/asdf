package IntelliShip::Carrier::Driver::UPS::AddressValidate;

use Moose;
use XML::Simple;
use HTTP::Request;
use Data::Dumper;
use LWP::UserAgent;
use IntelliShip::Utils;

BEGIN { extends 'IntelliShip::Carrier::Driver'; }

# PRODUCTION URL
#my $URL = 'https://onlinetools.ups.com/ups.app/xml/XAV';

# TEST URL
my $URL = 'https://wwwcie.ups.com/ups.app/xml/XAV';

my $AccessLicenseNumber = '7CD03B13C7D39706';
my $UserId = 'tsharp212';
my $Password = 'Tony212!@';

sub process_request
	{
	my $self = shift;
	my $lastvalidatedon = $self->destination_address->lastvalidatedon;

	## Return if address is validated in past 6 months
	if ($lastvalidatedon)
		{
		my $days_since_last_validated = IntelliShip::DateUtils->get_delta_days($lastvalidatedon);
		$self->log("days_since_last_validated = " . $days_since_last_validated . "\n");
		return 1 if ($days_since_last_validated <= 180);
		}

	my $XML = "<?xml version=\"1.0\"?>
<AccessRequest xml:lang=\"en-US\">
<AccessLicenseNumber>$AccessLicenseNumber</AccessLicenseNumber>
<UserId>$UserId</UserId>
<Password>$Password</Password>
</AccessRequest>
<?xml version=\"1.0\"?>
<AddressValidationRequest xml:lang=\"en-US\">
<Request>
<TransactionReference>
<CustomerContext /><XpciVersion>1.0001</XpciVersion>
</TransactionReference>
<RequestAction>XAV</RequestAction>
<RequestOption>1</RequestOption>
</Request>
<MaximumListSize>1</MaximumListSize>
<AddressKeyFormat>
<ConsigneeName>" . $self->destination_address->addressname . "</ConsigneeName>
<AddressLine>" . $self->destination_address->address1 . "</AddressLine>
<AddressLine>" . $self->destination_address->address2 . "</AddressLine>
<PoliticalDivision2>" . $self->destination_address->city . "</PoliticalDivision2>
<PoliticalDivision1>" . $self->destination_address->state . "</PoliticalDivision1>
<PostcodePrimaryLow>" . $self->destination_address->zip . "</PostcodePrimaryLow>
<CountryCode>" . $self->destination_address->country . "</CountryCode>
</AddressKeyFormat>
</AddressValidationRequest>";

	my $UA = LWP::UserAgent->new();   
	my $request = HTTP::Request->new(POST => $URL);

	#$self->log("\n\nXML = $XML \n\n");

	$request->content($XML);
	my $response = $UA->request($request);

	my $xml = new XML::Simple;

	my $responseDS = $xml->XMLin($response->content);

	$self->log("responseDS: " . Dumper($responseDS));

	if ($responseDS->{Response}->{ResponseStatusDescription} =~ /Success/i)
		{
		if (exists $responseDS->{ValidAddressIndicator})
			{
			$self->destination_address->lastvalidatedon(IntelliShip::DateUtils->get_timestamp_with_time_zone);
			$self->destination_address->update;
			return $responseDS;
			}
		else
			{
			$self->add_error("The Ship To address provided is invalid, or requires additional information.");
			}
		}
	else
		{
		$self->add_error("Invalid Destination Address - " . $responseDS->{Response}->{Error}->{ErrorDescription});
		return undef;
		}
	}

__PACKAGE__->meta()->make_immutable();

no Moose;

1;

__END__
