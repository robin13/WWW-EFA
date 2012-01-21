#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use YAML;
use Class::Date qw/date now/;
use File::Spec::Functions;
use WWW::EFA::Provider::MVV;
use WWW::EFA::Coordinates;
use WWW::EFA::Location;

my %params;
GetOptions( \%params,
    'results=i',
    'distance=i',
    'coords_from=s',
    'coords_to=s',
    'cache_dir=s',
    ) or die( "Invalid params\n" );

# Defaults
%params = (
    distance  => 1000,
    results   => 5,
    %params,
    );

my %coords;
foreach my $fromto( qw/from to/ ){
    if( $params{'coords_' . $fromto } and $params{'coords_' . $fromto} =~ m/^(\d+\.\d+),(\d+\.\d+)$/ ){
        $coords{$fromto}{lat} = $1;
        $coords{$fromto}{lon} = $2;
    }
}

my %efa_params;

if( $params{cache_dir} ){
    if( not -d $params{cache_dir} and not mkdir( $params{cache_dir} ) ){
        die( "Could not create cache_dir ($params{cache_dir}): $!\n" );
    }
    my $data_dir = catfile( $params{cache_dir}, 'data' );
    if( not -d $data_dir ){
        if( not mkdir( $data_dir ) ){
            die( "Could not create data_dir ($data_dir): $!\n" );
        }
    }
    $efa_params{cache_dir} = $data_dir if( -d $data_dir );
}

my $efa = WWW::EFA::Provider::MVV->new( %efa_params );

my $search_to_location = WWW::EFA::Location->new(
    coordinates => WWW::EFA::Coordinates->new( %{ $coords{to} } ),
    );
my $search_from_location = WWW::EFA::Location->new(
    coordinates => WWW::EFA::Coordinates->new( %{ $coords{from} } ),
    );

# This is just to test that the method works
my( $stop_by_finder ) = $efa->stop_finder(
    location    => $search_from_location,
    );


my( $from_location ) = $efa->coord_request(
    location     => $search_from_location,
    max_results  => $params{results},
    max_distance => $params{distance},
    );

my( $to_location ) = $efa->coord_request(
    location     => $search_to_location,
    max_results  => $params{results},
    max_distance => $params{distance},
    );


#printf "#####\nGetting departures near station\n%s#####\n", $from_location->string;
my $departures = $efa->departures( location => $from_location );
print $departures->string;

exit(0);

printf "##### Getting trips between\n%s\n%s\n",
       $from_location->string, $to_location->string;

my $trips = $efa->trips(
    from    => $from_location,
    to      => $to_location,
    date    => now(), #date( '2011-11-15 10:00:00' ),
    );

printf "##### From\n%s", $trips->origin_location->string;
printf "##### To\n%s", $trips->destination_location->string;

my $fmt = "%-19s  => %-19s %3s\n";
printf $fmt, 'Departure', 'Arrival', 'Mins';
my %intervals;
my $last_departure = undef;
foreach my $route( @{ $trips->routes } ){
    my $travel_mins = int( ( $route->arrival_time - $route->departure_time ) / 60 );
    if( $last_departure ){
        my $interval = int( ( $route->departure_time - $last_departure ) / 60 );
        $intervals{$interval}++;
    }
    $last_departure = $route->departure_time;
    
    printf "%-s  => %20s (%s)\n", 
        $route->departure_time->string, 
        $route->arrival_time->string,
        $travel_mins; 
}

print Dump( \%intervals );

    
exit( 0 );


