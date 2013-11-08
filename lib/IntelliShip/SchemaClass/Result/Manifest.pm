use utf8;
package IntelliShip::SchemaClass::Result::Manifest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

IntelliShip::SchemaClass::Result::Manifest

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

=head1 TABLE: C<manifest>

=cut

__PACKAGE__->table("manifest");

=head1 ACCESSORS

=head2 manifestid

  data_type: 'char'
  is_nullable: 0
  size: 13

=head2 datecreated

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 datecompleted

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 manifestname

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 carrier

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 exported

  data_type: 'integer'
  is_nullable: 1

=head2 shipmentid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 halovoiddate

  data_type: 'timestamp with time zone'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "manifestid",
  { data_type => "char", is_nullable => 0, size => 13 },
  "datecreated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "datecompleted",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "manifestname",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "carrier",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "exported",
  { data_type => "integer", is_nullable => 1 },
  "shipmentid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "halovoiddate",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</manifestid>

=back

=cut

__PACKAGE__->set_primary_key("manifestid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-10-30 19:40:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FpOaFPNGuAOwynwOi4TsKg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
