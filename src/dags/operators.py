
from airflow import DAG
from airflow.providers.mysql.operators.mysql import MySqlOperator
# from airflow.operators.mysql_operator import MySqlOperator
import os



class LoadDataOperator(MySqlOperator):
    def __init__(
        self,
        table,
        file,
        delimiter,
        columns,
        db="staging",
        skip_rows=0,
        **kwargs,
    ):
        self.table = table
        self.file = file
        self.delimiter = delimiter
        self.sql = f"""LOAD DATA LOCAL INFILE '{file}' INTO TABLE {db}.{table}
            FIELDS
                OPTIONALLY ENCLOSED BY '"'
                TERMINATED BY '{delimiter}'
            LINES
                TERMINATED BY '\\n'
            IGNORE {skip_rows} ROWS ({columns})
            """
        super().__init__(sql=self.sql,**kwargs)

    def execute(self, context):
        super().execute(context)



class BulkLoadDataOperator(MySqlOperator):
    def __init__(
        self,
        table,
        base_path,
        delimiter,
        columns,
        db="staging",
        skip_rows=0,
        **kwargs,
    ):
        self.table = table
        self.delimiter = delimiter
        self.base_path = base_path
        self.skip_rows = skip_rows
        self.columns = columns
        self.sql = "show tables;"
        super().__init__(sql=self.sql,**kwargs)

    def execute(self, context):
        mysql = MysqlHook(mysql_conn_id=self.mysql_conn_id)
        for fname in os.listdir(self.base_path):
            mysql.run(f"""
            LOAD DATA LOCAL INFILE '{self.base_path}/{fname}' INTO TABLE {self.db}.{self.table}
            FIELDS
                OPTIONALLY ENCLOSED BY '"'
                TERMINATED BY '{self.delimiter}'
            LINES
                TERMINATED BY '\\n'
            IGNORE {self.skip_rows} ROWS ({self.columns})
            """)
        # super().execute(context)


class RunQueryOperator(MySqlOperator):
    def __init__(
        self,
        file,
        **kwargs,
    ):
        self.sql = file
        super().__init__(sql=self.sql,**kwargs)
    
    def execute(self, context):
        super().execute(context)