package WWW::EFA::PlaceFactory;
use Moose;
use WWW::EFA::Place;
=head1 NAME

A Factory for creating L<WWW::EFA::Place> objects.

=head1 SYNOPSIS

  my $factory = WWW::EFA::PlaceFactory->new();


=cut

=head1 METHODS

=head2 place_from_itdOdvPlace

  my $place = $factory->place_from_itdOdvPlace( $itd_odv->findnodes( '/itdOdvPlace' ) );

Expects an XML::LibXML::Element of XML like this:

  
<itdOdvPlace state="identified" method="itp">
<odvPlaceElem omc="9162000" placeID="1" value="9162000:1" span="0" type="remote" mainPlace="1">München</odvPlaceElem>
<odvPlaceInput/>
</itdOdvPlace>

Returns a L<WWW::EFA::Place> object

=cut
sub place_from_itdOdvPlace {
    my $self    = shift;
    my $element = shift;

    printf "Element is a %s\n", ref( $element );
    my $state = $element->getAttribute( 'state' );
    my( $place_elem ) = $element->findnodes( 'odvPlaceElem' );
    
    croak( "No odvPlaceElem found" ) if not $place_elem;

    my $place = WWW::EFA::Place->new(
        id          => $place_elem->getAttribute( 'placeID' ),
        type        => $place_elem->getAttribute( 'type' ),
        name        => $place_elem->textContent,
        state       => $state,
        );
    return $place;
}


1;

=head1 COPYRIGHT

Copyright 2011, Robin Clarke, Munich, Germany

=head1 AUTHOR

Robin Clarke <perl@robinclarke.net>

