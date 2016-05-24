# DSE Analytics - DAY ONE

We will start with loading a dataset through simple insert statements (loading with Spark will come!)

1 ) Create the keyspace and table 
    https://github.com/MurphyRP/DSESpark_day1/blob/master/createKeyspace.cql
    
2) Insert a starter set of location data
    https://github.com/MurphyRP/DSESpark_day1/blob/master/data/locationSmall.txt
    
3) Run ```<installdir>/bin/dsetool sparkmaster``` and note the IP (external IP) of the Master node
    
3) Open the Spark-SQL shell
``` sudo <installdir>/bin/dse spark-sql ```
4) To to the Spark Master UI  
    ```http://<master ip

    



