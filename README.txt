############################################

1) Generate trustyURIs

./np
./np help
./np op help
./np check nanopubs_V1.trig
./np mktrusty -r nanopubs_V1.trig
./np check trusty.nanopubs_V1.trig

############################################

2) Install Docker

############################################

3) Install Virtuoso Docker image
https://github.com/tenforce/docker-virtuoso

______________________________

Option 1: With Docker Compose
______________________________

Create a docker-compose.yml file containing the following:

db:
  image: tenforce/virtuoso:1.3.1-virtuoso7.2.2
  environment:
    SPARQL_UPDATE: "true"
    DEFAULT_GRAPH: "http://www.example.com/my-graph"
    DBA_PASSWORD: "admin"
  volumes:
    - ./data/virtuoso:/data
  ports:

Then start docker:
sudo service docker start

And run docker-compose:
sudo docker-compose up
______________________________

Option 2: With Docker Run
______________________________

Create a run.sh file containing the following:

docker run --name my-virtuoso \
    -p 8890:8890 -p 1111:1111 \
    -e DBA_PASSWORD=admin \
    -e SPARQL_UPDATE=true \
    -e DEFAULT_GRAPH=http://www.example.com/my-graph \
    -v ./data:/data \
    -d tenforce/virtuoso

Once the server is up and running, in browser:
http://localhost:8890/conductor

And login with "dba" and password "admin"

############################################

4) Load nanopubs into triple store

1. Place files to load into the triplestore (trusty.nanopubs_A1_V1.trig, trusty.nanopubs_A2_V1.trig and trusty.nanopubs_A3_V1.trig) into a folder like /path/virtuoso/dumps
2. Modifiy the virtuoso.ini file in /path/virtuoso such that the folder where you placed your dump files are in the DirsAllowed:
    DirsAllowed			= ., /usr/local/virtuoso-opensource/share/virtuoso/vad, ./dumps
3. Restart your server
4. Find out the name of your docker instance in the NAMES field:
    sudo docker ps
5. Loading data manually in Virtuoso, assuming the name of your Docker instance is triple_store_db_1 (replace with the corresponding output of the previous command):
  sudo docker exec -it triple_store_db_1 bash
  isql-v -U dba -P $DBA_PASSWORD
  SQL> ld_dir ('./dumps', '*.trig', 'http://example.com');
  SQL> rdf_loader_run();

  select * from DB.DBA.load_list;

In case you want to delete the triples in the store:
  SQL> log_enable(3,1);
  SQL> DELETE FROM rdf_quad WHERE g = iri_to_id ('http://mygraph.org');
