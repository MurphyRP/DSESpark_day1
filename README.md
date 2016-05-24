# DSE Analytics - DAY ONE

We will start with loading a dataset through simple insert statements (loading with Spark will come!)

1 ) Create the keyspace and table 
    https://github.com/MurphyRP/DSESpark_day1/blob/master/createKeyspace.cql
    
2) Insert a starter set of location data
    https://github.com/MurphyRP/DSESpark_day1/blob/master/data/locationSmall.txt
    
3) Run ```<installdir>/bin/dsetool sparkmaster``` and note the IP (external IP) of the Master node
    
4) Open the Spark-SQL shell
``` sudo <installdir>/bin/dse spark-sql ```
5) To to the Spark Master UI  
    ```http://<master ip>:7080
    
    A) What applications are running?
    B) How many cores are being used per node? Per cluster?
    C) How much ram is being used per node? Per cluster?
    
6) Click on the ApplicationID

    A) How many executors are running?
    B) Are there any errors in stdout/stderr?

    



