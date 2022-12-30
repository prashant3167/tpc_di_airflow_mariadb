from typing import List


from airflow.providers.mysql.operators.mysql import MySqlOperator


def reset_table(table_name: str) -> MySqlOperator:
    return MySqlOperator(
        task_id="reset_" + table_name, sql="queries/reset/reset_" + table_name + ".sql"
    )


def get_file_path(
    incremental: bool, filename: str, extension: str = "txt"
) -> List[str]:
    folder_path = "incremental"
    if not incremental:
        folder_path = "/staging/Batch1"

    return "{}/{}.{}".format(folder_path, filename, extension)
