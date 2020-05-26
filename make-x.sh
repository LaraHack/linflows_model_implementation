#!/bin/bash

sudo chmod 777 virtuoso/data/virtuoso/dumps
mkdir -p virtuoso/data/virtuoso/dumps
rm virtuoso/data/virtuoso/dumps/*.nq
TIMESTAMP=$(date '+%Y%m%d%H%M%S')
cat article_*/nanopubs_*_article.trig > temp.trig
cat article_*/modified/nanopubs_*.trig >> temp.trig
./np mktrusty -r -o trusty.nanopubs-x.trig temp.trig
./np op filter -o virtuoso/data/virtuoso/dumps/trusty.nanopubs-x.$TIMESTAMP.nq trusty.nanopubs-x.trig
rm temp.trig
