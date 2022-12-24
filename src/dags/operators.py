
from airflow import DAG
from airflow.providers.mysql.operators.mysql import MySqlOperator
# from airflow.operators.mysql_operator import MySqlOperator
import os
from airflow.providers.mysql.hooks.mysql import MySqlHook
import re



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
        mysql_conn_id ='mysql_default',
        **kwargs,
    ):
        self.table = table
        self.delimiter = delimiter
        self.base_path = base_path
        self.skip_rows = skip_rows
        self.columns = columns
        self.sql = "show tables;"
        self.mysql_conn_id = mysql_conn_id
        self.db = db
        super().__init__(sql=self.sql,**kwargs)

    def execute(self, context):
        # mysql = MySqlHook(mysql_conn_id=self.mysql_conn_id)
        hook = MySqlHook(mysql_conn_id=self.mysql_conn_id, schema=self.database)
        # sql = "show tables;"
        # result = hook.get_first(sql)
        print(f"{self.db}.{self.table}")
        for fname in os.listdir(self.base_path):
            if re.match(r"FINWIRE[0-9]{4}Q[1-4]$", fname):
                print(fname)
                hook.run(f"""LOAD DATA LOCAL INFILE '{self.base_path}/{fname}' INTO TABLE {self.db}.{self.table}
                LINES
                    TERMINATED BY '\\n'
                IGNORE {self.skip_rows} ROWS ({self.columns})
                """,
                autocommit=True
                )
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