#!/bin/bash

sudo chmod 777 virtuoso/data/virtuoso/dumps
mkdir -p virtuoso/data/virtuoso/dumps
rm virtuoso/data/virtuoso/dumps/*.trig
TIMESTAMP=$(date '+%Y%m%d%H%M%S')
cat article_*/nanopubs_*.trig > temp.trig
./np mktrusty -r -o virtuoso/data/virtuoso/dumps/trusty.nanopubs.$TIMESTAMP.trig temp.trig
rm temp.trig
