
## 1. Install Docker
Based on your distribution, see [Docker installation instructions](https://docs.docker.com/install/linux/docker-ce/ubuntu/).

## 2. Install Virtuoso Docker image
* [Virtuoso Docker image](https://github.com/tenforce/docker-virtuoso) - if needed (or curious), check the instructions there for more details.


### OPTION 1 (__recommended__): With Docker Compose


Create a ```docker-compose.yml``` file containing the following:
```
db:
  image: tenforce/virtuoso:1.3.1-virtuoso7.2.2
  environment:
    SPARQL_UPDATE: "true"
    DEFAULT_GRAPH: "http://www.example.com/my-graph"
    DBA_PASSWORD: "admin"
  volumes:
    - ./data/virtuoso:/data
  ports:
    - "8890:8890"
```

Then start docker:
```
sudo service docker start
```

And run docker-compose:
```
sudo docker-compose up
```

### OPTION 2: With Docker Run


Create a ```run.sh``` file containing the following:
```
docker run --name my-virtuoso \
    -p 8890:8890 -p 1111:1111 \
    -e DBA_PASSWORD=admin \
    -e SPARQL_UPDATE=true \
    -e DEFAULT_GRAPH=http://www.example.com/my-graph \
    -v ./data:/data \
    -d tenforce/virtuoso
```

## 3. Access triple store

Once the server is up and running, in your browser go to:
[http://localhost:8890/conductor](http://localhost:8890/conductor)

And login with ```dba``` and password ```admin```.


## 4. Load trusty nanopubs into Virtuoso triple store

### OPTION 1 (__recommended__)

Running the following script will generate the trusty nanopubs for the nanopubs in the repository, then load them in the Virtuoso triple store Docker image indicated above: ``` sudo ./reload.sh```. Run this script in a different terminal window while the virtuoso server is up and running.

### OPTION 2
If you want to do all the steps manually yourself instead of running the script above to load the data in the triple store:

#### 1) Generate trustyURIs

##### script for nanopubs
```
./np
./np help
./np op help
```

##### checking the validity of nanopubs
```
./np check nanopubs_V1.trig
```

##### making trusty links for nanopubs
```
./np mktrusty -r nanopubs_V1.trig
```

##### checking trusty links for nanopubs
```
./np check trusty.nanopubs_V1.trig
```

#### 2) Load trusty nanopubs in triple store

1. Place files to load into the triplestore (```trusty.\*.nq``` files) into a folder like ```/<path>/virtuoso/dumps```
2. Modifiy the ```virtuoso.ini``` file in ```/<path>/virtuoso``` such that the folder where you placed your dump files are in the ```DirsAllowed```:
    * example: ```DirsAllowed			= ., /usr/local/virtuoso-opensource/share/virtuoso/vad, ./dumps```
3. Restart your server
4. Find out the name of your docker instance in the ```NAMES``` field:```sudo docker ps```
5. Loading data manually in Virtuoso, assuming the name of your Docker instance is ```virtuoso_db_1``` (replace with the corresponding output of the previous command):
  ```
  sudo docker exec -it virtuoso_db_1 bash
  isql-v -U dba -P $DBA_PASSWORD
  SQL> ld_dir ('./dumps', '*.nq', 'http://example.com');
  SQL> rdf_loader_run();

  select * from DB.DBA.load_list;
  ```

In case you want to delete the triples in the store:
```
  SQL> log_enable(3,1);
  SQL> DELETE FROM rdf_quad WHERE g = iri_to_id ('http://example.com');
```

## 5. SPARQL queries on the nanopubs loaded in the Virtuoso triple store

After starting the server and logging in the browser interface (see Step 3 above), you can run the following SPARQL queries on the newly loaded triples: [statistics dataset](/queries/statistics_dataset.md), [competency questions](/queries/competency_questions.md), [various queries](/queries/various_sparql_queries.md).
