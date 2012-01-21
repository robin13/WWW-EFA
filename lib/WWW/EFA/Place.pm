package WWW::EFA::Place;
use Moose;
=head1 NAME

WWW::EFA::Place - A Place

=head1 DESCRIPTION

Built from an XML like this:

  
<itdOdvPlace state="identified" method="itp">
<odvPlaceElem omc="9162000" placeID="1" value="9162000:1" span="0" type="remote" mainPlace="1">München</odvPlaceElem>
<odvPlaceInput/>
</itdOdvPlace>

=cut

has 'id'        => ( is => 'ro', isa => 'Int'               );
has 'state'     => ( is => 'ro', isa => 'Str'               );
has 'type'      => ( is => 'ro', isa => 'Str'               );
has 'name'      => ( is => 'ro', isa => 'Str'               );

1;

=head1 NAME


=head1 DESCRIPTION


=head1 METHODS

=over 4


=back

=head1 COPYRIGHT

Copyright 2011, Robin Clarke, Munich, Germany

=head1 AUTHOR

Robin Clarke <perl@robinclarke.net>

