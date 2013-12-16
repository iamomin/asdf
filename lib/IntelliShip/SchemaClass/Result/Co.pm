use utf8;
package IntelliShip::SchemaClass::Result::Co;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

IntelliShip::SchemaClass::Result::Co

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<co>

=cut

__PACKAGE__->table("co");

=head1 ACCESSORS

=head2 coid

  data_type: 'char'
  is_nullable: 0
  size: 13

=head2 customerid

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 1
  size: 13

=head2 statusid

  data_type: 'integer'
  is_nullable: 1

=head2 ordernumber

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ponumber

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 datecreated

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 datetoship

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 estimatedweight

  data_type: 'double precision'
  is_nullable: 1

=head2 estimatedinsurance

  data_type: 'double precision'
  is_nullable: 1

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 500

=head2 exthsc

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 hazardous

  data_type: 'integer'
  is_nullable: 1

=head2 dateneeded

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 loginid

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 extloginid

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 department

  data_type: 'varchar'
  is_nullable: 1
  size: 500

=head2 workorderid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 unitquantity

  data_type: 'double precision'
  is_nullable: 1

=head2 commodityquantity

  data_type: 'double precision'
  is_nullable: 1

=head2 contactname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 contactphone

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 bookingdate

  data_type: 'date'
  is_nullable: 1

=head2 dimlength

  data_type: 'double precision'
  is_nullable: 1

=head2 dimwidth

  data_type: 'double precision'
  is_nullable: 1

=head2 dimheight

  data_type: 'double precision'
  is_nullable: 1

=head2 stream

  data_type: 'text'
  is_nullable: 1

=head2 custnum

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 extcustnum

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 extcd

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 extcarrier

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 extservice

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 keep

  data_type: 'integer'
  is_nullable: 1

=head2 roadmileage

  data_type: 'integer'
  is_nullable: 1

=head2 dateneededon

  data_type: 'integer'
  is_nullable: 1

=head2 tpacctnumber

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 importfile

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 chargeamount

  data_type: 'double precision'
  is_nullable: 1

=head2 securitytype

  data_type: 'integer'
  is_nullable: 1

=head2 routeflag

  data_type: 'integer'
  is_nullable: 1

=head2 density

  data_type: 'double precision'
  is_nullable: 1

=head2 class

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 shipmentnotification

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 deliverynotification

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 contactid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 addressid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 termsofsale

  data_type: 'integer'
  is_nullable: 1

=head2 dutypaytype

  data_type: 'integer'
  is_nullable: 1

=head2 dutyaccount

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 commodityunits

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 commodityunitvalue

  data_type: 'double precision'
  is_nullable: 1

=head2 destinationcountry

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 commoditycustomsvalue

  data_type: 'double precision'
  is_nullable: 1

=head2 manufacturecountry

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 currencytype

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 partiestotransaction

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 extid

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 custref2

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 custref3

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 mode

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 datereceived

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 daterouted

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 datepacked

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 quantityxweight

  data_type: 'integer'
  is_nullable: 1

=head2 usealtsop

  data_type: 'integer'
  is_nullable: 1

=head2 isinbound

  data_type: 'integer'
  is_nullable: 1

=head2 isdropship

  data_type: 'integer'
  is_nullable: 1

=head2 dropaddressid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 dropcontact

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 dropphone

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 cotypeid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 volume

  data_type: 'real'
  is_nullable: 1

=head2 combine

  data_type: 'integer'
  is_nullable: 1

=head2 freightcharges

  data_type: 'integer'
  is_nullable: 1

=head2 consolidationtype

  data_type: 'integer'
  is_nullable: 1

=head2 combinedcoid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 clientdatecreated

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 bookingnumber

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 transitdays

  data_type: 'integer'
  is_nullable: 1

=head2 contacttitle

  data_type: 'varchar'
  is_nullable: 1
  size: 35

=head2 rtaddressid

  data_type: 'varchar'
  is_nullable: 1
  size: 13

=head2 rtcontact

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 rtphone

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 oaaddressid

  data_type: 'varchar'
  is_nullable: 1
  size: 13

=cut

__PACKAGE__->add_columns(
  "coid",
  { data_type => "char", is_nullable => 0, size => 13 },
  "customerid",
  { data_type => "char", is_foreign_key => 1, is_nullable => 1, size => 13 },
  "statusid",
  { data_type => "integer", is_nullable => 1 },
  "ordernumber",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "ponumber",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "datecreated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "datetoship",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "estimatedweight",
  { data_type => "double precision", is_nullable => 1 },
  "estimatedinsurance",
  { data_type => "double precision", is_nullable => 1 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 500 },
  "exthsc",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "hazardous",
  { data_type => "integer", is_nullable => 1 },
  "dateneeded",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "loginid",
  { data_type => "char", is_nullable => 1, size => 20 },
  "extloginid",
  { data_type => "char", is_nullable => 1, size => 20 },
  "department",
  { data_type => "varchar", is_nullable => 1, size => 500 },
  "workorderid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "unitquantity",
  { data_type => "double precision", is_nullable => 1 },
  "commodityquantity",
  { data_type => "double precision", is_nullable => 1 },
  "contactname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "contactphone",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "bookingdate",
  { data_type => "date", is_nullable => 1 },
  "dimlength",
  { data_type => "double precision", is_nullable => 1 },
  "dimwidth",
  { data_type => "double precision", is_nullable => 1 },
  "dimheight",
  { data_type => "double precision", is_nullable => 1 },
  "stream",
  { data_type => "text", is_nullable => 1 },
  "custnum",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "extcustnum",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "extcd",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "extcarrier",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "extservice",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "keep",
  { data_type => "integer", is_nullable => 1 },
  "roadmileage",
  { data_type => "integer", is_nullable => 1 },
  "dateneededon",
  { data_type => "integer", is_nullable => 1 },
  "tpacctnumber",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "importfile",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "chargeamount",
  { data_type => "double precision", is_nullable => 1 },
  "securitytype",
  { data_type => "integer", is_nullable => 1 },
  "routeflag",
  { data_type => "integer", is_nullable => 1 },
  "density",
  { data_type => "double precision", is_nullable => 1 },
  "class",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "shipmentnotification",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "deliverynotification",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "contactid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "addressid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "termsofsale",
  { data_type => "integer", is_nullable => 1 },
  "dutypaytype",
  { data_type => "integer", is_nullable => 1 },
  "dutyaccount",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "commodityunits",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "commodityunitvalue",
  { data_type => "double precision", is_nullable => 1 },
  "destinationcountry",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "commoditycustomsvalue",
  { data_type => "double precision", is_nullable => 1 },
  "manufacturecountry",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "currencytype",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "partiestotransaction",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "extid",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "custref2",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "custref3",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "mode",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "datereceived",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "daterouted",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "datepacked",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "quantityxweight",
  { data_type => "integer", is_nullable => 1 },
  "usealtsop",
  { data_type => "integer", is_nullable => 1 },
  "isinbound",
  { data_type => "integer", is_nullable => 1 },
  "isdropship",
  { data_type => "integer", is_nullable => 1 },
  "dropaddressid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "dropcontact",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "dropphone",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "cotypeid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "volume",
  { data_type => "real", is_nullable => 1 },
  "combine",
  { data_type => "integer", is_nullable => 1 },
  "freightcharges",
  { data_type => "integer", is_nullable => 1 },
  "consolidationtype",
  { data_type => "integer", is_nullable => 1 },
  "combinedcoid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "clientdatecreated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "bookingnumber",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "transitdays",
  { data_type => "integer", is_nullable => 1 },
  "contacttitle",
  { data_type => "varchar", is_nullable => 1, size => 35 },
  "rtaddressid",
  { data_type => "varchar", is_nullable => 1, size => 13 },
  "rtcontact",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "rtphone",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "oaaddressid",
  { data_type => "varchar", is_nullable => 1, size => 13 },
);

=head1 PRIMARY KEY

=over 4

=item * L</coid>

=back

=cut

__PACKAGE__->set_primary_key("coid");

=head1 RELATIONS

=head2 cotypeid

Type: belongs_to

Related object: L<IntelliShip::SchemaClass::Result::Cotype>

=cut

__PACKAGE__->belongs_to(
  "cotypeid",
  "IntelliShip::SchemaClass::Result::Cotype",
  { cotypeid => "cotypeid" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 customerid

Type: belongs_to

Related object: L<IntelliShip::SchemaClass::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customerid",
  "IntelliShip::SchemaClass::Result::Customer",
  { customerid => "customerid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 products

Type: has_many

Related object: L<IntelliShip::SchemaClass::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "IntelliShip::SchemaClass::Result::Product",
  { "foreign.coid" => "self.coid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 shipmentcoassocs

Type: has_many

Related object: L<IntelliShip::SchemaClass::Result::Shipmentcoassoc>

=cut

__PACKAGE__->has_many(
  "shipmentcoassocs",
  "IntelliShip::SchemaClass::Result::Shipmentcoassoc",
  { "foreign.coid" => "self.coid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 shipmentids

Type: many_to_many

Composing rels: L</shipmentcoassocs> -> shipmentid

=cut

__PACKAGE__->many_to_many("shipmentids", "shipmentcoassocs", "shipmentid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-10-30 19:40:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9gb1XDCzBKUV29zu3sUxdg

sub set_datecreated
	{
	my $self = shift;
	$self->datecreated('now');
	}

__PACKAGE__->belongs_to(
	to_address => 
	"IntelliShip::SchemaClass::Result::Address",
	"addressid"
	);

__PACKAGE__->belongs_to(
	drop_address => 
	"IntelliShip::SchemaClass::Result::Address",
	"dropaddressid"
	);

__PACKAGE__->belongs_to(
	rt_address => 
	"IntelliShip::SchemaClass::Result::Address",
	"rtaddressid"
	);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
