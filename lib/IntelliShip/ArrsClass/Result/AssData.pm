use utf8;
package IntelliShip::ArrsClass::Result::AssData;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

IntelliShip::ArrsClass::Result::AssData

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

=head1 TABLE: C<assdata>

=cut

__PACKAGE__->table("assdata");

=head1 ACCESSORS

=head2 assdataid

  data_type: 'char'
  is_nullable: 0
  size: 13

=head2 ownertypeid

  data_type: 'integer'
  is_nullable: 1

=head2 ownerid

  data_type: 'char'
  is_nullable: 1
  size: 13

=head2 assname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 assdisplay

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 asstypeid

  data_type: 'integer'
  is_nullable: 1

=head2 arcost

  data_type: 'real'
  is_nullable: 1

=head2 arcostmin

  data_type: 'real'
  is_nullable: 1

=head2 arcostperwt

  data_type: 'real'
  is_nullable: 1

=head2 apcost

  data_type: 'real'
  is_nullable: 1

=head2 apcostmin

  data_type: 'real'
  is_nullable: 1

=head2 apcostperwt

  data_type: 'real'
  is_nullable: 1

=head2 arcostperunit

  data_type: 'real'
  is_nullable: 1

=head2 arcostmax

  data_type: 'real'
  is_nullable: 1

=head2 apcostperunit

  data_type: 'real'
  is_nullable: 1

=head2 apcostmax

  data_type: 'real'
  is_nullable: 1

=head2 arcostpercent

  data_type: 'real'
  is_nullable: 1

=head2 apcostpercent

  data_type: 'real'
  is_nullable: 1

=head2 startdate

  data_type: 'date'
  is_nullable: 1

=head2 stopdate

  data_type: 'date'
  is_nullable: 1

=head2 datecreated

  data_type: 'timestamp'
  is_nullable: 1

=head2 datehalocreated

  data_type: 'timestamp'
  is_nullable: 1

=head2 asscode

  data_type: 'varchar'
  is_nullable: 1
  size: 35

=head2 assmarkupamt

  data_type: 'real'
  is_nullable: 1

=head2 assmarkuppercent

  data_type: 'real'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "assdataid",
  { data_type => "char", is_nullable => 0, size => 13 },
  "ownertypeid",
  { data_type => "integer", is_nullable => 1 },
  "ownerid",
  { data_type => "char", is_nullable => 1, size => 13 },
  "assname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "assdisplay",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "asstypeid",
  { data_type => "integer", is_nullable => 1 },
  "arcost",
  { data_type => "real", is_nullable => 1 },
  "arcostmin",
  { data_type => "real", is_nullable => 1 },
  "arcostperwt",
  { data_type => "real", is_nullable => 1 },
  "apcost",
  { data_type => "real", is_nullable => 1 },
  "apcostmin",
  { data_type => "real", is_nullable => 1 },
  "apcostperwt",
  { data_type => "real", is_nullable => 1 },
  "arcostperunit",
  { data_type => "real", is_nullable => 1 },
  "arcostmax",
  { data_type => "real", is_nullable => 1 },
  "apcostperunit",
  { data_type => "real", is_nullable => 1 },
  "apcostmax",
  { data_type => "real", is_nullable => 1 },
  "arcostpercent",
  { data_type => "real", is_nullable => 1 },
  "apcostpercent",
  { data_type => "real", is_nullable => 1 },
  "startdate",
  { data_type => "date", is_nullable => 1 },
  "stopdate",
  { data_type => "date", is_nullable => 1 },
  "datecreated",
  { data_type => "timestamp", is_nullable => 1 },
  "datehalocreated",
  { data_type => "timestamp", is_nullable => 1 },
  "asscode",
  { data_type => "varchar", is_nullable => 1, size => 35 },
  "assmarkupamt",
  { data_type => "real", is_nullable => 1 },
  "assmarkuppercent",
  { data_type => "real", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</assdataid>

=back

=cut

__PACKAGE__->set_primary_key("assdataid");


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-11-20 04:13:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q2G6wY43nFmE+j5HuFMlag


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
