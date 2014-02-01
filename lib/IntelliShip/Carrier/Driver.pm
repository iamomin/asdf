package IntelliShip::Carrier::Driver;

use Moose;
use Data::Dumper;
use IntelliShip::Utils;

BEGIN {

	extends 'IntelliShip::Errors';

	has 'CO' => ( is => 'rw' );
	has 'context' => ( is => 'rw' );
	has 'customer' => ( is => 'rw' );
	has 'DB_ref' => ( is => 'rw' );
	has 'data' => ( is => 'rw' );
	has 'customerservice' => ( is => 'rw' );
	has 'service' => ( is => 'rw' );
	}

sub model
	{
	my $self = shift;
	my $model = shift;

	if ($self->context)
		{
		return $self->context->model($model);
		}
	}

sub myDBI
	{
	my $self = shift;
	$self->DB_ref($self->model->('MyDBI')) unless $self->DB_ref;
	return $self->DB_ref if $self->DB_ref;
	}

sub get_token_id
	{
	my $self = shift;
	return $self->context->controller->get_token_id;
	}

sub process_request
	{
	my $self = shift;
	}

sub TagPrinterString
	{
	my $self = shift;
	#my ($string,$ordernumber) = @_;
	#my $tagged_string = '';
    #
	#my @string_lines = split("\n",$string);
    #
	## Check for order stream, and add it to main stream, if it exists
	#my $CO = new CO($self->{'dbref'}, $self->{'customer'});
	#my ($ID) = $CO->GetCurrentCOID($ordernumber,$self->{'customer'}->GetValueHashRef()->{'customerid'});
	#$CO->Load($ID);
    #
	#my $Stream = $CO->GetValueHashRef()->{'stream'};
	#if ( defined($Stream) && $Stream ne '' )
	#{
	#	push(@string_lines,split(/\~/,$Stream));
	#}
    #
	#$tagged_string .= ".\n";
	#foreach my $line (@string_lines)
	#{
	#	# Need to reverse print direction of local labels
	#	if ( $line eq 'ZT' )
	#	{
	#		$line = 'ZB';
	#	}
    #
	#	if ( $line =~ /Svcs/ || $line =~ /TRCK/ || $line =~ /CLS/ )
	#	{
	#		next;
	#	}	
	#	$tagged_string .= "$line\n";
	#}
    #
	#$tagged_string .= "R0,0\n";
	#$tagged_string .= ".\n\n";
    #
	#return $tagged_string;
	}

sub insert_shipment
	{
	my $self = shift;
	my $shipmentData = shift;

	return unless $shipmentData;

	my $shipmentObj = {
			'department' => $shipmentData->{'department'},
			'coid' => $shipmentData->{'coid'},
			'dateshipped' => $shipmentData->{'dateshipped'},
			'quantityxweight' => $shipmentData->{'quantityxweight'},
			'freightinsurance' => $shipmentData->{'freightinsurance'},
			'hazardous' => $shipmentData->{'hazardous'},
			'deliverynotification' => $shipmentData->{'deliverynotification'},
			'custnum' => $shipmentData->{'custnum'},
			'oacontactphone' => $shipmentData->{'oacontactphone'},
			'securitytype' => $shipmentData->{'securitytype'},
			'description' => $shipmentData->{'description'},
			'shipasname' => $shipmentData->{'shipasname'},
			'density' => $shipmentData->{'density'},
			'destinationcountry' => $shipmentData->{'destinationcountry'},
			'partiestotransaction' => $shipmentData->{'partiestotransaction'},
			'defaultcsid' => $shipmentData->{'defaultcsid'},
			'ponumber' => $shipmentData->{'ponumber'},
			'dimweight' => $shipmentData->{'dimweight'},
			'dimlength' => $shipmentData->{'dimlength'},
			'dimheight' => $shipmentData->{'dimheight'},
			'naftaflag' => $shipmentData->{'naftaflag'},
			'carrier' => $shipmentData->{'carrier'},
			'dimwidth' => $shipmentData->{'dimwidth'},
			'commodityunits' => $shipmentData->{'commodityunits'},
			'manualthirdparty' => $shipmentData->{'manualthirdparty'},
			'contactphone' => $shipmentData->{'contactphone'},
			'customsvalue' => $shipmentData->{'customsvalue'},
			'contactname' => $shipmentData->{'contactname'},
			'customsdescription' => $shipmentData->{'customsdescription'},
			'billingaccount' => $shipmentData->{'billingaccount'},
			'commodityweight' => $shipmentData->{'commodityweight'},
			'dutyaccount' => $shipmentData->{'dutyaccount'},
			'manufacturecountry' => $shipmentData->{'manufacturecountry'},
			'contacttitle' => $shipmentData->{'contacttitle'},
			'shipmentnotification' => $shipmentData->{'shipmentnotification'},
			'originid' => $shipmentData->{'originid'},
			'bookingnumber' => $shipmentData->{'bookingnumber'},
			'custref3' => $shipmentData->{'custref3'},
			'dutypaytype' => $shipmentData->{'dutypaytype'},
			'extid' => $shipmentData->{'extid'},
			'datereceived' => $shipmentData->{'datereceived'},
			'weight' => $shipmentData->{'weight'},
			'shipmentid' => $shipmentData->{'shipmentid'},
			'billingpostalcode' => $shipmentData->{'billingpostalcode'},
			'insurance' => $shipmentData->{'insurance'},
			'currencytype' => $shipmentData->{'currencytype'},
			'service' => $shipmentData->{'service'},
			'isdropship' => $shipmentData->{'isdropship'},
			'ssnein' => $shipmentData->{'ssnein'},
			'harmonizedcode' => $shipmentData->{'harmonizedcode'},
			'tracking1' => $shipmentData->{'tracking1'},
			'isinbound' => $shipmentData->{'isinbound'},
			'oacontactname' => $shipmentData->{'oacontactname'},
			'daterouted' => $shipmentData->{'daterouted'},
			'quantity' => $shipmentData->{'quantity'},
			'commodityquantity' => $shipmentData->{'commodityquantity'},
			'dimunits' => $shipmentData->{'dimunits'},
			'freightcharges' => $shipmentData->{'freightcharges'},
			'termsofsale' => $shipmentData->{'termsofsale'},
			'commoditycustomsvalue' => $shipmentData->{'commoditycustomsvalue'},
			'datepacked' => $shipmentData->{'datepacked'},
			'unitquantity' => $shipmentData->{'unitquantity'},
			'ipaddress' => $shipmentData->{'ipaddress'},
			'commodityunitvalue' => $shipmentData->{'commodityunitvalue'}
		};

	my $orignAddress = {
			addressname	=> $shipmentData->{'customername'},
			address1	=> $shipmentData->{'branchaddress1'},
			address2	=> $shipmentData->{'branchaddress2'},
			city		=> $shipmentData->{'branchaddresscity'},
			state		=> $shipmentData->{'branchaddressstate'},
			zip			=> $shipmentData->{'branchaddresszip'},
			country		=> $shipmentData->{'branchaddresscountry'},
			};

	my @arr1 = $self->model('MyDBI::Address')->search($orignAddress);
	$shipmentObj->{'addressidorigin'} = $arr1[0]->addressid if @arr1;

	my $destinAddress = {
			addressname	=> $shipmentData->{'addressname'},
			address1	=> $shipmentData->{'address1'},
			address2	=> $shipmentData->{'address2'},
			city		=> $shipmentData->{'addresscity'},
			state		=> $shipmentData->{'addressstate'},
			zip			=> $shipmentData->{'addresszip'},
			country		=> $shipmentData->{'addresscountry'},
			};

	my @arr2 = $self->model('MyDBI::Address')->search($destinAddress);
	$shipmentObj->{'addressiddestin'} = $arr2[0]->addressid if @arr2;

	#$self->log('*** shipmentData ***: ' . Dumper $shipmentObj);

	my $Shipment = $self->model('MyDBI::Shipment')->new($shipmentObj);
	$Shipment->insert;

	$self->log('New shipment inserted, ID: ' . $Shipment->shipmentid);

	return $Shipment;
	}

sub log
	{
	my $self = shift;
	my $msg = shift;
	if ($self->context)
		{
		$self->context->log->debug($msg);
		}
	else
		{
		print STDERR "\n" . $msg;
		}
	}

__PACKAGE__->meta()->make_immutable();

no Moose;

1;

__END__