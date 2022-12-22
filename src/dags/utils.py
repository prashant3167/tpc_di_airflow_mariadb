from typing import List, Dict

from airflow.contrib.operators.bigquery_operator import BigQueryOperator
from airflow.contrib.operators.gcs_to_bq import GoogleCloudStorageToBigQueryOperator

from constants import *
from airflow.providers.mysql.operators.mysql import MySqlOperator


def construct_gcs_to_bq_operator(task_id: str, source_objects: List[str], schema_fields: List[Dict],
                                 destination_project_dataset_table: str) -> GoogleCloudStorageToBigQueryOperator:
    return GoogleCloudStorageToBigQueryOperator(
        task_id=task_id,
        bucket=GCS_BUCKET,
        source_objects=source_objects,
        schema_fields=schema_fields,
        field_delimiter=get_delimiter(source_objects),
        destination_project_dataset_table=destination_project_dataset_table,
        write_disposition='WRITE_TRUNCATE',
        autodetect=False,
        bigquery_conn_id=BIG_QUERY_CONN_ID,
        google_cloud_storage_conn_id=GOOGLE_CLOUD_DEFAULT,
        ignore_unknown_values=False
    )


def execute_sql(task_id: str, sql_file_path: str) -> BigQueryOperator:
    return BigQueryOperator(
        task_id=task_id,
        sql=sql_file_path,
        bigquery_conn_id=BIG_QUERY_CONN_ID,
        write_disposition='WRITE_APPEND',
        use_legacy_sql=False,
        location='US'
    )

def reset_table(table_name: str) -> MySqlOperator:
    return MySqlOperator(task_id="reset_" + table_name, sql='queries/reset/reset_' + table_name + '.sql')


def insert_if_empty(task_id: str, sql_file_path: str, destination_table: str) -> BigQueryOperator:
    return BigQueryOperator(
        task_id=task_id,
        sql=sql_file_path,
        bigquery_conn_id=BIG_QUERY_CONN_ID,
        write_disposition='WRITE_EMPTY',
        destination_dataset_table=destination_table,
        use_legacy_sql=False,
        location='US'
    )


def insert_overwrite(task_id: str, sql_file_path: str, destination_table: str) -> BigQueryOperator:
    return BigQueryOperator(
        task_id=task_id,
        sql=sql_file_path,
        bigquery_conn_id=BIG_QUERY_CONN_ID,
        write_disposition='WRITE_TRUNCATE',
        destination_dataset_table=destination_table,
        use_legacy_sql=False,
        location='US'
    )


def get_delimiter(source_objects: List[str]) -> str:
    field_delimiter = '|'
    return field_delimiter
    for source_object in source_objects:
        print()
        if source_object.split(".")[1] == CSV_EXTENSION:
            field_delimiter = ','
            break
    return field_delimiter


def get_file_path(incremental: bool, filename: str, extension: str = 'txt') -> List[str]:
    folder_path = "incremental"
    if not incremental:
        folder_path = "/staging/Batch1"

    return "{}/{}.{}".format(folder_path, filename, extension)