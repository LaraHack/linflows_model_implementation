1) Generate trustyURIs

./np
./np help
./np op help
./np check nanopubs_V1.trig
./np check trusty.nanopubs_V1.trig
./np mktrusty -r nanopubs_V1.trig

2) Install Docker

3) Install Virtuoso Docker image
https://github.com/tenforce/docker-virtuoso

______________________________

Option 1: With Docker Compose
______________________________

Create a docker-comppose.yml file containing the following:

db:
  image: tenforce/virtuoso:1.3.1-virtuoso7.2.2
  environment:
    SPARQL_UPDATE: "true"
    DEFAULT_GRAPH: "http://www.example.com/my-graph"
    DBA_PASSWORD: "admin"
  volumes:
    - ./data/virtuoso:/data
  ports:

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

4) Load nanopubs into triple store
