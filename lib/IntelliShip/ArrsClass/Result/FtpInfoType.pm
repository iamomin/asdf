use utf8;
package IntelliShip::ArrsClass::Result::FtpInfoType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

IntelliShip::ArrsClass::Result::FtpInfoType

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

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<ftpinfotype>

=cut

__PACKAGE__->table("ftpinfotype");

=head1 ACCESSORS

=head2 ftpinfotypeid

  data_type: 'integer'
  is_nullable: 0

=head2 ftpinfotypename

  data_type: 'varchar'
  is_nullable: 0
  size: 30

=cut

__PACKAGE__->add_columns(
  "ftpinfotypeid",
  { data_type => "integer", is_nullable => 0 },
  "ftpinfotypename",
  { data_type => "varchar", is_nullable => 0, size => 30 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ftpinfotypeid>

=back

=cut

__PACKAGE__->set_primary_key("ftpinfotypeid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-11-20 04:13:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zybnJb3l8K2tgXkCXZzubQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;