# # """
# # This module contains utility functions to interact with the Spark catalog.
# #
# # """
# #
# # from pyspark.sql import SparkSession
# #
# #
# # def create_namespace_if_not_exists(
# #         spark: SparkSession,
# #         namespace: str = "default"
# # ) -> None:
# #
# #     """
# #     Create a namespace in the Spark catalog if it does not exist.
# #
# #     :param spark: The Spark session.
# #     :param namespace: The name of the namespace. Default is "default".
# #     :return: None
# #     """
# #
# #     spark.sql(f"CREATE DATABASE IF NOT EXISTS {namespace}")
# #     print(f"Namespace {namespace} is ready to use.")
# #
# #
# # def table_exists(
# #         spark: SparkSession,
# #         table_name: str,
# #         namespace: str = "default",
# # ) -> bool:
# #
# #     """
# #     Check if a table exists in the Spark catalog.
# #
# #     :param spark: The Spark session.
# #     :param table_name: The name of the table.
# #     :param namespace: The namespace of the table. Default is "default".
# #     :return: True if the table exists, False otherwise.
# #     """
# #
# #     spark_catalog = f"{namespace}.{table_name}"
# #
# #     try:
# #         spark.table(spark_catalog)
# #         print(f"Table {spark_catalog} exists.")
# #         return True
# #     except Exception as e:
# #         print(f"Table {spark_catalog} does not exist: {e}")
# #         return False
# #
# #
# # def remove_table(
# #         spark: SparkSession,
# #         table_name: str,
# #         namespace: str = "default",
# # ) -> None:
# #
# #     """
# #     Remove a table from the Spark catalog.
# #
# #     :param spark: The Spark session.
# #     :param table_name: The name of the table.
# #     :param namespace: The namespace of the table. Default is "default".
# #     :return: None
# #     """
# #
# #     spark_catalog = f"{namespace}.{table_name}"
# #
# #     spark.sql(f"DROP TABLE IF EXISTS {spark_catalog}")
# #     print(f"Table {spark_catalog} removed.")
# #
#
#
# from datetime import datetime
#
# from pyspark import SparkConf
# from pyspark.sql import DataFrame, SparkSession
#
# # Requires install of delta-spark package and hadoop
#
# # Fair scheduler configuration TODO PUT IN A FILE or RETURN FROM API
# SPARK_DEFAULT_POOL = "default"
# SPARK_POOLS = [SPARK_DEFAULT_POOL, "highPriority"]
#
# ## ATTENTION USERS: DO NOT MODIFY THIS FILE, as it will be overwritten
#
#
# def delta_lake_config():
#     """
#     Configure Delta Lake settings for the Spark session.
#
#     Args:
#         config: Dictionary to update with Delta Lake settings.
#     """
#     config = {}
#     config.update({
#         "spark.sql.extensions": "io.delta.sql.DeltaSparkSessionExtension",
#         "spark.sql.catalog.spark_catalog": "org.apache.spark.sql.delta.catalog.DeltaCatalog",
#         "spark.databricks.delta.retentionDurationCheck.enabled": "false",
#         "spark.sql.catalogImplementation": "hive"
#     })
#
#
#
# def get_spark_session(
#         app_name: str | None = None,
#         local: bool = False,
#         delta_lake: bool = True,
#         scheduler_pool: str = SPARK_DEFAULT_POOL,
# ) -> SparkSession:
#     """
#     Create and configure a Spark session with CDM-specific settings.
#
#     This function creates a Spark session configured for the CDM environment,
#     including support for Delta Lake, MinIO S3 storage, and fair scheduling.
#
#     Args:
#         app_name: Application name. If None, generates a timestamp-based name
#         local: If True, creates a local Spark session (ignores other configs)
#         delta_lake: If True, enables Delta Lake support with required JARs
#         scheduler_pool: Fair scheduler pool name (default: "default")
#
#     Returns:
#         Configured SparkSession instance
#
#     Raises:
#         EnvironmentError: If required environment variables are missing
#         FileNotFoundError: If required JAR files are missing
#
#     Example:
#         >>> # Basic usage
#         >>> spark = get_spark_session("MyApp")
#
#         >>> # With custom scheduler pool
#         >>> spark = get_spark_session("MyApp", scheduler_pool="highPriority")
#
#         >>> # Local development
#         >>> spark = get_spark_session("TestApp", local=True)
#     """
#     # Generate app name if not provided
#     if app_name is None:
#         timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
#         app_name = f"kbase_spark_session_{timestamp}"
#
#     # For local development, return simple session
#     if local:
#         return SparkSession.builder.appName(app_name).getOrCreate()
#
#     # Build configuration dictionary
#     config: dict[str, str] = {"spark.app.name": app_name}
#
#     # Configure core Spark settings
#     #TODO LOKO AT THIS
#     #_configure_dynamic_allocation(config)
#     #_configure_fair_scheduler(config)
#     #_configure_driver_host(config)
#     #_configure_spark_master(config)
#
#     # Configure Delta Lake if enabled
#     #if delta_lake:
#         # TODO FIX THIS
#         #config.update(_get_s3_conf())
#         #_configure_delta_lake(config)
#
#     # Create and configure Spark session
#     spark_conf = SparkConf().setAll(list(config.items()))
#
#
#     if delta_lake:
#         spark_conf.update(delta_lake_config())
#
#
#     spark = SparkSession.builder.config(conf=spark_conf).getOrCreate()
#     spark.sparkContext.setLogLevel("ERROR")
#
#     # Set scheduler pool
#     # TODO LOOK AT THIS
#     #_set_scheduler_pool(spark, scheduler_pool)
#
#     return spark
