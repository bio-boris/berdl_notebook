from datetime import datetime

from pyspark import SparkConf
from pyspark.sql import DataFrame, SparkSession

# Fair scheduler configuration TODO PUT IN A FILE or RETURN FROM API
SPARK_DEFAULT_POOL = "default"
SPARK_POOLS = [SPARK_DEFAULT_POOL, "highPriority"]

## ATTENTION USERS: DO NOT MODIFY THIS FILE, as it will be overwritten


def get_spark_session(
        app_name: str | None = None,
        local: bool = False,
        delta_lake: bool = True,
        scheduler_pool: str = SPARK_DEFAULT_POOL,
) -> SparkSession:
    """
    Create and configure a Spark session with CDM-specific settings.

    This function creates a Spark session configured for the CDM environment,
    including support for Delta Lake, MinIO S3 storage, and fair scheduling.

    Args:
        app_name: Application name. If None, generates a timestamp-based name
        local: If True, creates a local Spark session (ignores other configs)
        delta_lake: If True, enables Delta Lake support with required JARs
        scheduler_pool: Fair scheduler pool name (default: "default")

    Returns:
        Configured SparkSession instance

    Raises:
        EnvironmentError: If required environment variables are missing
        FileNotFoundError: If required JAR files are missing

    Example:
        >>> # Basic usage
        >>> spark = get_spark_session("MyApp")

        >>> # With custom scheduler pool
        >>> spark = get_spark_session("MyApp", scheduler_pool="highPriority")

        >>> # Local development
        >>> spark = get_spark_session("TestApp", local=True)
    """
    # Generate app name if not provided
    if app_name is None:
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        app_name = f"kbase_spark_session_{timestamp}"

    # For local development, return simple session
    if local:
        return SparkSession.builder.appName(app_name).getOrCreate()

    # Build configuration dictionary
    config: dict[str, str] = {"spark.app.name": app_name}

    # Configure core Spark settings
    #TODO LOKO AT THIS
    #_configure_dynamic_allocation(config)
    #_configure_fair_scheduler(config)
    #_configure_driver_host(config)
    #_configure_spark_master(config)

    # Configure Delta Lake if enabled
    #if delta_lake:
        # TODO FIX THIS
        #config.update(_get_s3_conf())
        #_configure_delta_lake(config)

    # Create and configure Spark session
    spark_conf = SparkConf().setAll(list(config.items()))
    spark = SparkSession.builder.config(conf=spark_conf).getOrCreate()
    spark.sparkContext.setLogLevel("ERROR")

    # Set scheduler pool
    # TODO LOOK AT THIS
    #_set_scheduler_pool(spark, scheduler_pool)

    return spark
