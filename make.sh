#!/bin/bash

cat article_*/nanopubs_*.trig > temp.trig
./np mktrusty -r -o trusty.nanopubs.trig temp.trig
rm temp.trig
