## DSE Analytics - Introduction

## Getting started, resources and Spark Applications

We will start with loading a dataset through simple insert statements (loading with Spark will come!)

1 ) Create the keyspace and table 
    https://github.com/MurphyRP/DSESpark_day1/blob/master/createKeyspace.cql
    
2) Insert a starter set of location data
    https://github.com/MurphyRP/DSESpark_day1/blob/master/data/locationSmall.txt
    
3) Use dsetool to determine (and note) the IP (external IP) of the Master node 
```
<installdir>/bin/dsetool sparkmaster
```
    
4) Open the Spark-SQL shell
``` sudo <installdir>/bin/dse spark-sql ```

5) Go to the Spark Master UI  
    ```http://<master ip>:7080 ```
    
    A) What applications are running?
    B) How many cores are being used per node? Per cluster?
    C) How much ram is being used per node? Per cluster?
    
6) Click on the ApplicationID

    A) How many executors are running?
    B) Are there any errors in stdout/stderr?
    
7) Open a new terminal window and start a new Spark-SQL shell.

    A) What happened?
    B) Why?
    
8) Close the first Spark-SQL session.

    A) What happened?
    B) Why?
    
9) Close the second Spark-SQL sesion and reopen with configuration change.

``` sudo <installdir>/bin/dse spark-sql --total-executor-cores 2 ```

10) Refresh the Master UI 

    A) What application is running?
    B) How many cores are being used?
    C) Can you open a second Spark-SQL Session?
    
11) Open a second Spark-SQL session with more executor memory (adjust as appropriate for your system)
``` sudo <installdir>/dse spark-sql --total-executor-cores 2  --executor-memory  2G ```

    A) Any change to the observed behavior above?
    
12) When would you want to set system-wide defaults for these settings?

http://docs.datastax.com/en/datastax_enterprise/5.0/datastax_enterprise/spark/sparkCassProps.html

## Simple data exploration

### Spark-SQL CLI

1) Let's look at our table in the Spark-SQL CLI


Run
```
Describe bootcamp.us_locations 
```

#### Brush off your SQL - in this case SparkSQL

2) How many rows are in the table?

3) How many 'sites' are in 'CA'?

4) What states are in the table?

4) What is the highest site in (in this small set) 'AZ'?

    You don't need this but...
```ruby
select feature_name from bootcamp.us_locations where state_alpha = 'AZ' order by elevation_in_ft desc limit 1;
```

5) Why are you running simple Spark-SQL? Why would anyone need Spark-SQL with DSE/Cassandra?

6) Where might an ad-hoc 'interface' to Cassandra via Spark make more sense? Does CLI sound like a common usage pattern?

### Spark CLI

1) Open Spark 

``` sudo <installdir>/bin/dse spark -total-executor-cores 2 ```
    
    A) What contexts are available?
    B) For DSE 4.8 and earlier version users, what is different?
    
2) Refresh the Spark Master UI

    A) What applications are running?
    B) Is there anything different than when we were running the Spark-SQL shell?
    C) Why do these applications not 'stop' running?
    
3) Think DAG! (Directed Acyclic Graph) https://en.wikipedia.org/wiki/Directed_acyclic_graph

4) Run 
```scala
val firstTest = 10;
```
Note:  '=' is an Assignment Operator in Scala (and most languages)

    A) What is the output?
    B) You wrote Scala!
    C) How do you print the value to the prompt? Think Scala.

4) Run
```scala
val resCount = sqlContext.sql("select count(*) from bootcamp.us_locations")
```

    A)What was the output? How was this different than the 'firstTest' assignment?
    B)What is resCount?
5) Run
```scala
println(resCount)
```
    A) What was the output?
    B) Why was no value printed?
    
6) Run
```scala
resCount.take(1)
```
    A) Did it take longer than the println?
    B) What was the output?
    
7) Run
```scala
val resFull = sqlContext.sql("select * from bootcamp.us_locations")
```
    A) What was the output?
    
8) Run
```scala
resFull.printSchema()
```

    A) What is the output?
    B) Has data been retrieved from Cassandra yet? Why (yes or no)?
    

9) Run
```scala
resFull.take(5)
```
    A) What is the output?
    B) Has data been retrieved from Cassandra yet? Why (yes or no)?
    
10) Run
```scala
resFull.groupBy("state_alpha").count().show()
```
    A) What is the output?
    B) What is different about this execution?
11) Run
```
resFull.filter("state_alpha = 'AZ'").sort($"elevation_in_ft".desc).take(1)
```
Sort is an alias of group by. Spark often provides a 'sql knowledge' friendly alias but does not always provide all the functionality of the underlying function.

12) What else can be done with a simple DataFrame?

http://spark.apache.org/docs/latest/api/scala/index.html#org.apache.spark.sql.DataFrame

#### Writing to Cassandra

1) Create a simple States table with:
https://github.com/MurphyRP/DSESpark_day1/blob/master/createStateTable.cql 

2) Run
```scala
val states = sqlContext.sql("select distinct(state_alpha) from bootcamp.us_locations")
```
    A) Take a look at the contents. .show() is appropriate here
    
3) Run
```scala
states.write.format("org.apache.spark.sql.cassandra").options(Map( "table" -> "states", "keyspace" -> "bootcamp")).save()
```
    A) What was written to Cassandra?
    
4) In CQLSH or DevCenter, run
```
update bootcamp.states set state_name = 'Arizona' where state_alpha = 'AZ';
update bootcamp.states set state_name = 'Colorado' where state_alpha = 'CO';
```
5) in Scala CLI run
```scala
val statesFromCass = sqlContext.sql("select state_alpha, state_name from bootcamp.states")

statesFromCass.registerTempTable("statesList")

resFull.registerTempTable("us_locations")

val arizonaHighPoint = sqlContext.sql("select feature_name, s.state_name from statesList s inner join locations l on s.state_alpha = l.state_alpha and l.state_alpha = 'AZ' order by elevation_in_ft desc") 
```

    A) What was created?
    B) Has data been retrieved from Cassandra? Why (yes or no)?

6) Run
```scala
arizonaHighPoint.take(1)
```

    A) What just happened?
    B) What was the output? Was it as expected?
    C) How long did it take?

7) Run
```scala
arizonaHighPoint.show()
```

    A) What was different?
    B) Did it take more time or less?
    C) If you run it again, how long does it take?
    
8) Run
```
resFull.cache()

arizonaHighPoint.show()
```

    A) Execute the second command twice.
    B) Faster or slower?
    C) Why?


## Spark submit

1) Using WGet or SCP, pull/push the file below to your user directory on Spark (the node you are using)
```
https://github.com/MurphyRP/DSESpark_day1/blob/master/simplePySubmit.py
```
Maybe cd into your home dir and then wget? **Note: wget from GITHub does not use the same URL as the Git UI**
```
cd
wget https://raw.githubusercontent.com/MurphyRP/DSESpark_day1/master/simplePySubmit.py
```

2) Submit the python file to Spark.
```
sudo <installDir>/bin/dse spark-submit ~/simplePySubmit.py
```
    A) What happened?
    B) "DSE Submit" wraps the submit in the correct DSE context and provides the spark master url
    C) Where would submit be more appropriate than the CLI?

https://github.com/datastax/spark-cassandra-connector/blob/master/doc/14_data_frames.md






