#!/bin/bash

sudo docker exec -it virtuoso_db_1 isql-v -U dba -P admin "EXEC=log_enable(3,1); DELETE FROM rdf_quad; ld_dir ('./dumps', '*.trig', 'http://example.com'); rdf_loader_run();"
