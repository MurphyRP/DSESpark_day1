# DSE Analytics - DAY ONE

## Getting started, resources and Spark Applications

We will start with loading a dataset through simple insert statements (loading with Spark will come!)

1 ) Create the keyspace and table 
    https://github.com/MurphyRP/DSESpark_day1/blob/master/createKeyspace.cql
    
2) Insert a starter set of location data
    https://github.com/MurphyRP/DSESpark_day1/blob/master/data/locationSmall.txt
    
3) Use dsetool to determine (and note) the IP (external IP) of the Master node 
```
<installdir>/bin/dsetool sparkmater
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

``` sudo <installdir>/bin/dse spark-sql -total-executor-cores 2 ```

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

``` Describe bootcamp.us_locations ```

2) How many rows are in the table?

3) How many 'sites' are in 'CA'?

4) What states are in the table?

4) What is the highest site in (in this small set) 'AZ'?

    You don't need this but...
```ruby
select * from bootcamp.us_locations where state_alpha = 'AZ' order by elevation_in_ft desc limit 1;
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
    



