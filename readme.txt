Hello guys, 
  This readme file is specifically for connectors. You will need to modify the connectors as per your requirements.
  Only modify the topics name in elasticsearch connector and table name in debezium connector to connect to the table of your choice.

  Well sometimes kibana-connect container doesn't launch when you run the program for the first time on your system, 
  in which case a simple restart of the container will suffice.

  A separate inject_connectors file has been provided to inject them, and yeah before you do that please make sure that all containers are up and running.
  They take a considerable amount of time on my pc, but my pc is low speced so you should give the poor thing a break. 
  I hope you will be able to deploy it a whole lot faster than me.
  
  Now coming to the ports on which programmes are hosted, here is the complete list:-
    - Postgresql:- localhost:5432
    - Zookeeper:- localhost:2181
    - Kafka:- localhost:9092
    - Bootstrap-server:- broker:29092
    - Kafka-Connect:- localhost:8083
    - Spark-Master:- localhost:9090
    - Spark-Worker-A:- localhost:9094
    - Spark-Worker-B:- localhost:9095
    - Elasticsearch:- localhost:9200
    - Kibana: localhost:5600
    
  Make sure to go through the "env" file to know about your usernames and passwords.
Anyway thank you guys for taking out your valuable time to look into my project.
