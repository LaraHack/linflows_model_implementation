#!/bin/bash

sudo docker exec -it virtuoso_db_1 isql-v -U dba -P admin "EXEC=ld_dir ('./dumps', '*.trig', 'http://example.com'); rdf_loader_run();"
