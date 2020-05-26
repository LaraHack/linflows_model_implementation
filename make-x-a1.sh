#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S')
cat article_1/nanopubs_*_article.trig > temp.trig
cat article_1/modified/nanopubs_*.trig >> temp.trig
./np mktrusty -r -o trusty.nanopubs-x.trig temp.trig
./np op filter -o trusty.nanopubs-x.$TIMESTAMP.nq trusty.nanopubs-x.trig
rm temp.trig
