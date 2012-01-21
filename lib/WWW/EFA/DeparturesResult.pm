package WWW::EFA::DeparturesResult;
use Moose;
use MooseX::Params::Validate;
use Moose::Util::TypeConstraints;
use Carp;

with 'WWW::EFA::Roles::Printable'; # provides to_string

subtype 'ValidDepartureStatus',
      as 'Str',
      where { $_ =~ m/^(OK|INVALID_STATION|SERVICE_DOWN)$/  },
      message { "Invalid departure status" };

=head1 NAME

WWW::EFA::DeparturesResult - Store the results from a departures query

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

# TODO: RCL 2011-08-23 Complete

=head1 PARAMS/ACCESSORS

=cut

has 'status' => (
    is          => 'rw',
    isa         => 'ValidDepartureStatus',
    );

has 'departure_stations' => (
    is          => 'rw',
    isa         => 'HashRef[WWW::EFA::Station]',
    default     => sub{ {} },
    );

has 'departures' => (
    is          => 'rw',
    isa         => 'ArrayRef[WWW::EFA::Departure]',
    default     => sub{ [] },
    );


has 'lines' => (
    is          => 'rw',
    isa         => 'HashRef[WWW::EFA::Line]',
    default     => sub{ {} },
    );

sub add_departure_station {
    my $self = shift;
    my ( $station ) = pos_validated_list(
        \@_,
        { isa => 'WWW::EFA::Station' },
      );
    if( not $station->location->id ){
        # TODO: RCL 2011-11-20 Make a debug output here when logging enabled
        # carp( "Cannot add_departure_station with a location without an id" );
        return;
    }

    # Make sure we don't add the same location twice
    if( not $self->departure_stations->{ $station->location->id } ){
        $self->departure_stations->{ $station->location->id } = $station;
    }
    
    return;
}

sub get_departure_station {
    my $self        = shift;
    my $station_id  = shift;
    return $self->departure_stations->{ $station_id };
}

sub add_line {
    my $self = shift;
    my ( $line ) = pos_validated_list(
        \@_,
        { isa => 'WWW::EFA::Line' },
      );

    # Make sure we don't add the same line twice
    if( not $self->lines->{ $line->id } ){
        $self->lines->{ $line->id } = $line;
    }
    return;
}

sub get_line {
    my $self    = shift;
    my $line_id = shift;
    return $self->lines->{ $line_id };
}

sub add_departure {
    my $self = shift;
    my ( $departure ) = pos_validated_list(
        \@_,
        { isa => 'WWW::EFA::Departure' },
    );

    if( not $self->get_departure_station( $departure->stop_id ) ){
        # TODO: RCL 2011-11-20 Make this a debug message
        # carp( sprintf "Cannot add departure because I don't know the stop_id: %s", $departure->stop_id );
        return;
    }
    
    if( not $self->get_line( $departure->line_id ) ){
        # TODO: RCL 2011-11-20 Make this a debug message
        # carp( sprintf 'Cannot add departure. Line id unknown: "%s"', $departure->line_id );
        return;
    }
    
    push( @{ $self->departures }, $departure );
    # TODO: RCL 2011-11-09 Sort departures by departure time?
}

1;

