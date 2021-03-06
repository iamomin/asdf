package IntelliShip::View::Email;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'templates/email.tt',
);

=head1 NAME

IntelliShip::View::Email - TT View for IntelliShip

=head1 DESCRIPTION

TT View for IntelliShip.

=head1 SEE ALSO

L<IntelliShip>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
