# DSE Analytics - DAY ONE

## Getting started, resources and Spark Applications

We will start with loading a dataset through simple insert statements (loading with Spark will come!)

1 ) Create the keyspace and table 
    https://github.com/MurphyRP/DSESpark_day1/blob/master/createKeyspace.cql
    
2) Insert a starter set of location data
    https://github.com/MurphyRP/DSESpark_day1/blob/master/data/locationSmall.txt
    
3) Run ```<installdir>/bin/dsetool sparkmaster``` and note the IP (external IP) of the Master node
    
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

## Simple data exploration



