# word count program
from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession
from datetime import datetime

# Initialize Spark Session
spark = SparkSession.builder.appName("WordCount").getOrCreate()

# Read the text file into an RDD
text_file = spark.sparkContext.textFile("file:///home/navin/Downloads/wordcount.txt")

# Perform the WordCount
counts = text_file.flatMap(lambda line: line.split(" ")).map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b)

# Convert to DataFrame
counts_df = counts.toDF(["word", "count"])

# Coalesce to a single partition
counts_single_partition = counts_df.coalesce(1)

# Append the timestamp in output file
timestamp=datetime.now().strftime("%Y%m%d%H%M%S")
outputFilePath=f"file:///home/navin/Downloads/output_{timestamp}"

# Save the result to HDFS
counts_single_partition.write.mode("overwrite").csv(outputFilePath)

# Stop the SparkSession
spark.stop()