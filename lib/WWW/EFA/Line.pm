package WWW::EFA::Line;
use Moose;
with 'WWW::EFA::Roles::Printable'; # provides to_string

has 'id'                => ( is => 'ro', isa => 'Str'                   );
has 'label'             => ( is => 'ro', isa => 'Str'                   );
has 'colour'            => ( is => 'ro', isa => 'Str'                   );
has 'destination'       => ( is => 'ro', isa => 'WWW::EFA::Location'    );
has 'line'              => ( is => 'ro', isa => 'Str'                   );
has 'direction'         => ( is => 'ro', isa => 'Str'                   ); # TODO: RCL 2011-11-09 Check for 'H' or 'R'
has 'route_description' => ( is => 'ro', isa => 'Str'                   );

has 'mot'               => ( is => 'ro', isa => 'Int'                   );
has 'realtime'          => ( is => 'ro', isa => 'Bool'                   );
has 'number'            => ( is => 'ro', isa => 'Str'                   );
has 'symbol'            => ( is => 'ro', isa => 'Str'                   );
has 'code'              => ( is => 'ro', isa => 'Str'                   );

1;

=head1 NAME

WWW::EFA::Line - a transport line

=head1 SYNOPSIS



=head1 DESCRIPTION


=head1 METHODS

=over 4


=back

=head1 COPYRIGHT

Copyright 2011, Robin Clarke, Munich, Germany

=head1 AUTHOR

Robin Clarke <perl@robinclarke.net>

