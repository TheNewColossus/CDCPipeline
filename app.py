# *-* coding: utf-8 *-*

#Sparksession to create a spark instance
from pyspark.sql import SparkSession
spark = SparkSession.builder.master("spark://spark-master:7077").appName("cdc_pipeline").getOrCreate()

#Dataframe to hold the messages from the stream
df = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "broker:29092") \
  .option("subscribe", "change_captured.public.students") \
  .load()
df = df.selectExpr("CAST(value AS STRING)")

#Writing the stream in order to read it, it is a bit silly but a procedure that needs to be followed
query = df \
    .writeStream \
    .outputMode("append") \
    .format("console") \
    .queryName("stream_query") \
    .start()

#Hoping for the best
query.awaitTermination()

spark.stop()