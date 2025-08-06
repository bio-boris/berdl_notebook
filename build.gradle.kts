plugins {
    `java`
}

// Define all versions as variables for easy updates
// NOTE: ensure Delta Spark jar version matches python pip delta-spark version specified in the Pipfile
val hadoopAwsVersion = "3.3.4"
val deltaSparkVersion = "3.2.0"
val scalaVersion = "2.12"
val postgresVersion = "42.7.3"
val sparkRedisVersion = "3.1.0"
val sparkXmlVersion = "0.18.0"

repositories {
    mavenCentral()
}

dependencies {
    // For this use case (gathering JARs for the Spark runtime),
    // runtimeOnly is the correct configuration for all dependencies.

    // AWS support for Hadoop S3A filesystem
    runtimeOnly("org.apache.hadoop:hadoop-aws:$hadoopAwsVersion")

    // Delta Lake support
    runtimeOnly("io.delta:delta-spark_${scalaVersion}:$deltaSparkVersion")

    // PostgreSQL JDBC Driver
    runtimeOnly("org.postgresql:postgresql:$postgresVersion")

    // Spark-Redis connector
    runtimeOnly("com.redislabs:spark-redis_${scalaVersion}:$sparkRedisVersion")

    // Spark-XML connector
    runtimeOnly("com.databricks:spark-xml_${scalaVersion}:$sparkXmlVersion")
}

// Custom task to copy all resolved JARs into one directory.
// This remains unchanged and works perfectly for this setup.
tasks.create<Copy>("copyLibs") {
    from(configurations.runtimeClasspath)
    into("libs")
}