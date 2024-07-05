from pyspark.sql import SparkSession
from pyspark.sql.functions import sum as _sum

# Initialize SparkSession
spark = SparkSession.builder.appName("TotalSalaryCalculation").getOrCreate()

# Read the data from HDFS into a DataFrame
df = spark.read.csv("hdfs://localhost:50000/employee_data.csv", header=True, inferSchema=True)

# Calculate the total salary and write the result to HDFS
total_salary_df = df.select(_sum("salary").alias("total_salary"))

# Save the result to HDFS
total_salary_df.write.mode("overwrite").csv("hdfs://localhost:50000/total_salary")

# Stop the SparkSession
spark.stop()
