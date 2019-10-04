#!/bin/bash

cat nanopubs_V1.trig nanopubs_reviews.trig > temp.trig
./np mktrusty -r -o trusty.nanopubs.trig temp.trig
rm temp.trig
