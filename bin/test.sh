#!/bin/sh
COORD_TO=48.161398,11.586392   # near Muenchener Freiheit
COORD_TO=48.173241,11.354939    # Puchheim (S4)
COORD_TO=48.105712,11.041152    # Geltendorf (S4)
COORD_FROM=48.139651,11.531578 # near Astallerstr
COORD_FROM=48.168533,11.646286  # Johanneskirchen (S8)
COORD_FROM=48.14037,11.559103  # hauptbahnhof muenchen
RADIUS=500
RESULTS=10
CACHE_DIR=/home/rcl/temp/efa_cache
export PERL5LIB=./lib
perl -MCarp=verbose ./bin/test_mvv.pl --coords_from $COORD_FROM --coords_to $COORD_TO \
  --distance $RADIUS --results $RESULTS \
  --cache_dir $CACHE_DIR
