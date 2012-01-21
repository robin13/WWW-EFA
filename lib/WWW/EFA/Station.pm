package WWW::EFA::Station;
use Moose;
with 'WWW::EFA::Roles::Printable'; # provides to_string

=head1 NAME

WWW::EFA::Station - Store a station with its location, departures and lines

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

# TODO: RCL 2011-08-23 Complete

=head1 PARAMS/ACCESSORS

=cut

has 'location' => (
    is          => 'ro',
    isa         => 'WWW::EFA::Location',
    required    => 1,
    );

has 'departures' => (
    is          => 'rw',
    isa         => 'ArrayRef',
    default     => sub{ [] },
    );

has 'lines' => (
    is          => 'rw',
    isa         => 'ArrayRef',
    default     => sub{ [] },
    );

1;
