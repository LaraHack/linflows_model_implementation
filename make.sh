#!/bin/bash

sudo chmod 777 virtuoso/data/virtuoso/dumps
mkdir -p virtuoso/data/virtuoso/dumps
cat article_*/nanopubs_*.trig > temp.trig
./np mktrusty -r -o virtuoso/data/virtuoso/dumps/trusty.nanopubs.trig temp.trig
rm temp.trig
