from datetime import datetime

from airflow import DAG
from airflow.contrib.operators.gcs_to_bq import GoogleCloudStorageToBigQueryOperator
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.operators.empty import EmptyOperator

from constants import CSV_EXTENSION, GCS_BUCKET, BIG_QUERY_CONN_ID, GOOGLE_CLOUD_DEFAULT
from transformations.convert_customer_mgmt_xml_to_csv import xml_to_csv
from utils import  get_file_path, insert_overwrite, reset_table, insert_if_empty, \
    execute_sql

from operators import LoadDataOperator,BulkLoadDataOperator

from airflow.providers.mysql.operators.mysql import MySqlOperator
from datetime import timedelta


AIRFLOW = 'airflow'

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2019, 11, 11),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 3,
    'max_active_runs':2
}

with DAG('my_historical_load', schedule_interval=None, default_args=default_args) as dag:
    load_date_file_to_master = LoadDataOperator(
        task_id="load_date_to_master",
        execution_timeout=timedelta(hours=3),
        db="master",
        table='dim_date',
        file=get_file_path(False,'Date'),
        delimiter="|",
        columns="SK_DateID,DateValue,DateDesc,CalendarYearID,CalendarYearDesc,CalendarQtrID,CalendarQtrDesc,CalendarMonthID,CalendarMonthDesc,CalendarWeekID,CalendarWeekDesc,DayOfWeekNum,DayOfWeekDesc,FiscalYearID,FiscalYearDesc,FiscalQtrID,FiscalQtrDesc,HolidayFlag"
    )

    load_time_file_to_master = LoadDataOperator(
        task_id="load_time_to_master",
        execution_timeout=timedelta(hours=3),
        db="master",
        table='dim_time',
        file=get_file_path(False,'Time'),
        delimiter="|",
        columns="SK_TimeID,TimeValue,HourID,HourDesc,MinuteID,MinuteDesc,SecondID,SecondDesc,MarketHoursFlag,OfficeHoursFlag"
    )

    load_industry_file_to_master = LoadDataOperator(
        task_id="load_industry_to_master",
        db="master",
        table='industry',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'Industry'),
        delimiter="|",
        columns="IN_ID,IN_NAME,IN_SC_ID"
    )

    load_status_type_file_to_master = LoadDataOperator(
        task_id="load_status_type_to_master",
        db="master",
        table='status_type',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'StatusType'),
        delimiter="|",
        columns="ST_ID,ST_NAME"
        )

    load_tax_rate_file_to_master = LoadDataOperator(
        task_id="load_tax_rate_to_master",
        db="master",
        table='tax_rate',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'TaxRate'),
        delimiter="|",
        columns="TX_ID,TX_NAME,TX_RATE"
        )

    load_trade_type_file_to_master = LoadDataOperator(
        task_id="load_trade_type_to_master",
        db="master",
        table='trade_type',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'TradeType'),
        delimiter="|",
        columns="TT_ID,TT_NAME,TT_IS_SELL,TT_IS_MRKT"
        )

    load_hr_file_to_staging = LoadDataOperator(
        task_id="load_hr_to_staging",
        db="staging",
        table='hr',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'HR','csv'),
        delimiter=",",
        columns="EmployeeID,ManagerID,EmployeeFirstName,EmployeeLastName,EmployeeMI,EmployeeJobCode,EmployeeBranch,EmployeeOffice,EmployeePhone"
        )

    transform_hr_to_broker = MySqlOperator(task_id='transform_hr_to_broker',
                                            execution_timeout=timedelta(hours=3),
                                              sql='queries/transform_load_dim_broker.sql')

    [load_date_file_to_master, load_hr_file_to_staging] >> transform_hr_to_broker



    load_batch_date_from_file = LoadDataOperator(
        task_id="load_batch_date_from_file",
        db="staging",
        table='batch_date',
        file=get_file_path(False,'BatchDate'),
        delimiter="|",
        columns="BatchDate",
        execution_timeout=timedelta(hours=3),
        )

    reset_batch_number = reset_table(table_name='batch_number')

    reference_data_load_complete = EmptyOperator(task_id='reference_data_load_complete')


    [load_date_file_to_master, load_time_file_to_master, load_industry_file_to_master, load_status_type_file_to_master,
     load_tax_rate_file_to_master, load_trade_type_file_to_master, transform_hr_to_broker, load_batch_date_from_file
    #  ,reset_batch_number
     ] >> reference_data_load_complete



    load_prospect_file_to_staging = LoadDataOperator(
        task_id="load_prospect_historical_to_staging",
        db="staging",
        table='prospect',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'Prospect','csv'),
        delimiter=",",
        columns="AgencyID,LastName,FirstName,MiddleInitial,Gender,AddressLine1,AddressLine2,PostalCode,City,State,Country,Phone,Income,NumberCars,NumberChildren,MaritalStatus,Age,CreditRating,OwnOrRentFlag,Employer,NumberCreditCards,NetWorth"
    )
    
    load_trade_to_staging = LoadDataOperator(
        task_id="load_trade_to_staging",
        db="staging",
        table='trade_historical',
        execution_timeout=timedelta(hours=3),
        file=get_file_path(False,'Trade'),
        delimiter="|",
        columns="T_ID,T_DTS,T_ST_ID,T_TT_ID,T_IS_CASH,T_S_SYMB,T_QTY,T_BID_PRICE,T_CA_ID,T_EXEC_NAME,T_TRADE_PRICE,T_CHRG,T_COMM,T_TAX"
    )



    load_trade_history_to_staging = LoadDataOperator(
        task_id="load_trade_history_to_staging",
        execution_timeout=timedelta(hours=3),
        db="staging",
        table='trade_history_historical',
        file=get_file_path(False,'TradeHistory'),
        delimiter="|",
        columns="TH_T_ID,TH_DTS,TH_ST_ID"
    )
    
    load_cash_transactions_to_staging = LoadDataOperator(
        task_id="load_cash_transactions_to_staging",
        execution_timeout=timedelta(hours=3),
        db="staging",
        table='cash_transaction_historical',
        file=get_file_path(False,'CashTransaction'),
        delimiter="|",
        columns="CT_CA_ID,CT_DTS,CT_AMT,CT_NAME"
    )

    load_holding_history_historical_to_staging = LoadDataOperator(
        task_id='load_holding_history_historical_to_staging',
        execution_timeout=timedelta(hours=3),
        db="staging",
        table='holding_history_historical',
        file=get_file_path(False,'HoldingHistory'),
        delimiter="|",
        columns="HH_H_T_ID,HH_T_ID,HH_BEFORE_QTY,HH_AFTER_QTY"
    )



    load_watch_history_historical_to_staging = LoadDataOperator(
        task_id='load_watch_history_historical_to_staging',
        db="staging",
        execution_timeout=timedelta(hours=3),
        table='watch_history_historical',
        file=get_file_path(False,'WatchHistory'),
        delimiter="|",
        columns="W_C_ID,W_S_SYMB,W_DTS,W_ACTION"
    )
    
    load_daily_market_to_staging = LoadDataOperator(
        task_id='load_daily_market_to_staging',
        db="staging",
        execution_timeout=timedelta(hours=3),
        table='daily_market_historical',
        file=get_file_path(False,'DailyMarket'),
        delimiter="|",
        columns="DM_DATE,DM_S_SYMB,DM_CLOSE,DM_HIGH,DM_LOW,DM_VOL"
    )



    # # Reference data loading done

    # # Convert XML to JSON

    # download_customer_management = BashOperator(task_id='download_customer_mangement_xml_to_worker',
    #                                             bash_command='rm -rf /home/airflow/gcs/data/CustomerMgmt.xml && gsutil cp gs://tpc-di_data/historical/CustomerMgmt.xml /home/airflow/gcs/data/')

    reset_staging_customer_management = reset_table(table_name='staging_customer_management')
    transform_file_customer_management = PythonOperator(
        task_id='convert_xml_to_csv',
        execution_timeout=timedelta(hours=3),
        python_callable=xml_to_csv,
        op_kwargs={"input_file":get_file_path(False,"CustomerMgmt", "xml"),"output_file":get_file_path(False,"CustomerMgmt", "csv")},
    )
    reset_staging_customer_management >> transform_file_customer_management

    # load_customer_management_pre_staging = LoadDataOperator(
    #     task_id='load_customer_management_to_pre_staging',
    #     execution_timeout=timedelta(hours=3),
    #     db="staging",
    #     table='customer_management',
    #     file=get_file_path(False,"CustomerMgmt", "csv"),
    #     delimiter=",",
    #     columns="Action,effective_time_stamp,CustomerID,TAXID,Gender,TIER,DOB,LastName,FirstName,MiddleInitial,AddressLine1,AddressLine2,PostalCode,City,State_Prov,Country,Email1,Email2,LocalTaxID,NationalTaxID,AccountID,TaxStatus,BrokerID,AccountDesc,Phone1,Phone2,Phone3,Status"
    # )
    
    # BashOperator(task_id='upload_json_to_data_store',
    #                                                bash_command='gsutil -m cp -R /home/airflow/gcs/data/CustomerMgmt.json gs://tpc-di_data/historical/')

    # download_customer_management >> 
    # transform_file_customer_management >> load_customer_management_pre_staging

    # Load FINWIRE to master dimensions
    load_finwire_staging = BulkLoadDataOperator(
        task_id='load_finwire_files_to_staging',
        execution_timeout=timedelta(hours=3),
        base_path="/staging/Batch1/",
        db="staging",
        columns="ROW",
        table='finwire',
        delimiter=','

    )

    load_cmp_records_staging = MySqlOperator(task_id='extract_cmp_records_from_finwire',
                                                sql='queries/transform_finwire_to_cmp.sql',
                                                params ={'table':'staging.cmp_records'})

    load_dim_company_from_cmp_records = MySqlOperator(task_id='load_dim_company_from_cmp_records',
                                                            execution_timeout=timedelta(hours=3),
                                                        sql='queries/load_cmp_records_to_dim_company.sql',
                                                        params={'table':'master.dim_company'})

    process_error_cmp_records = MySqlOperator(task_id='process_cmp_records_error',
                                            sql="queries/process_cmp_records_error.sql")

    load_sec_records_staging = MySqlOperator(task_id='extract_sec_records_from_finwire',
                                                sql='queries/transform_finwire_to_sec.sql',
                                                params={'table':'staging.sec_records'}
                                                )

    load_dim_security_from_sec_records = MySqlOperator(task_id='load_dim_security_from_sec_records',
                                                         sql='queries/load_sec_records_to_dim_security.sql',
                                                         params={'table':'master.dim_security'})

    load_fin_records_staging = MySqlOperator(task_id='extract_fin_records_from_finwire',
                                                sql='queries/transform_finwire_to_fin.sql',
                                                params={'table':'staging.fin_records'})

    load_dim_finance_from_fin_records = MySqlOperator(task_id='load_dim_finance_from_fin_records',
                                                        sql='queries/load_fin_records_to_financial.sql',
                                                        params={'table':'master.financial'})

    recreate_dim_company = reset_table('dim_company')
    recreate_dim_security = reset_table('dim_security')
    recreate_financial = reset_table('financial')

    finwire_data_load_complete = EmptyOperator(task_id='finwire_data_load_complete')

    reference_data_load_complete >> load_finwire_staging
    load_cmp_records_staging >> [recreate_dim_company,process_error_cmp_records] >> load_dim_company_from_cmp_records
    # load_cmp_records_staging >> [process_error_cmp_records, load_dim_company_from_cmp_records]
    load_finwire_staging >> [load_cmp_records_staging, load_sec_records_staging, load_fin_records_staging]
    [load_dim_company_from_cmp_records,
     load_sec_records_staging] >> recreate_dim_security >> load_dim_security_from_sec_records
    [load_dim_company_from_cmp_records,
     load_fin_records_staging] >> recreate_financial >> load_dim_finance_from_fin_records

    [load_dim_company_from_cmp_records, load_dim_security_from_sec_records,
     load_dim_finance_from_fin_records] >> finwire_data_load_complete

    # # FINWIRE data loading done

    # # Load Customer Management to master dimensions

    # load_customer_management_staging = GoogleCloudStorageToBigQueryOperator(
    #     task_id='load_customer_management_file_to_staging',
    #     bucket=GCS_BUCKET,
    #     source_objects=['historical/CustomerMgmt.json'],
    #     source_format='NEWLINE_DELIMITED_JSON',
    #     destination_project_dataset_table='staging.customer_management',
    #     write_disposition='WRITE_TRUNCATE',
    #     autodetect=True,
    #     bigquery_conn_id=BIG_QUERY_CONN_ID,
    #     google_cloud_storage_conn_id=GOOGLE_CLOUD_DEFAULT,
    #     ignore_unknown_values=False
    # )

    load_customer_from_customer_management = MySqlOperator(
        task_id='load_customer_from_customer_management',
        sql='queries'
                      '/load_customer_records_from_customer_management.sql',
        params={'table':'staging.customer_historical'})

    load_account_historical_from_customer_management = MySqlOperator(
        task_id='load_account_historical_from_customer_management',
        sql='queries'
                      '/load_account_records_from_customer_management.sql',
        params={'table':'staging.account_historical'})

    load_dim_prospect_from_staging_historical = MySqlOperator(
        task_id='load_dim_prospect_from_staging_historical',
        sql='queries/load_prospect_historical_to_dim_prospect.sql',
        params={'table':'master.prospect'})

    load_dim_customer_from_staging_customer_historical = MySqlOperator(
        task_id='load_dim_customer_from_staging_customer_historical',
        execution_timeout=timedelta(hours=3),
        sql='queries/load_dim_customer_from_staging_customer_historical.sql',
        params={'table':'master.dim_customer'})

    load_dim_account_from_staging_account_historical = MySqlOperator(
        task_id='load_dim_account_from_staging_account_historical',
        execution_timeout=timedelta(hours=3),
        sql='queries/load_dim_account_from_staging_account_historical.sql',
        params={'table':'master.dim_account'})

    process_error_customer_historical_records = MySqlOperator(
        task_id='process_error_customer_historical_records',
        execution_timeout=timedelta(hours=3),
        sql="queries/process_customer_historical_error.sql")

    recreate_prospect = reset_table('prospect')
    recreate_dim_account = reset_table('dim_account')
    recreate_dim_customer = reset_table('dim_customer')


    customer_account_data_load_complete = EmptyOperator(task_id='customer_account_data_load_complete')

    # load_customer_management_pre_staging >> load_customer_management_staging
    reference_data_load_complete >> [ load_prospect_file_to_staging]

    transform_file_customer_management >> [load_customer_from_customer_management,
                                         load_account_historical_from_customer_management]

    [load_customer_from_customer_management,
     load_prospect_file_to_staging] >> recreate_prospect >> load_dim_prospect_from_staging_historical

    load_customer_from_customer_management >> process_error_customer_historical_records

    [load_customer_from_customer_management,
     load_dim_prospect_from_staging_historical] >> recreate_dim_customer >> load_dim_customer_from_staging_customer_historical

    [load_account_historical_from_customer_management,
     load_dim_customer_from_staging_customer_historical] >> recreate_dim_account >> load_dim_account_from_staging_account_historical

    [load_dim_account_from_staging_account_historical,
     load_dim_customer_from_staging_customer_historical,
     load_dim_prospect_from_staging_historical] >> customer_account_data_load_complete

    # # Customer Management done

    # # Trade loading to master dimension



    recreate_dim_trade = reset_table('dim_trade')

    load_dim_trade_from_historical = MySqlOperator(task_id="load_dim_trade_from_historical",
                                                    execution_timeout=timedelta(hours=3),
                                                     sql="queries/load_trade_historical_to_dim_trade.sql",
                                                     params={'table':'master.dim_trade'})

    trade_data_load_complete = EmptyOperator(task_id='trade_data_load_complete')

    [customer_account_data_load_complete, finwire_data_load_complete, load_trade_history_to_staging,
     load_trade_to_staging] >> recreate_dim_trade >> load_dim_trade_from_historical >> trade_data_load_complete

    dimension_loading_complete = EmptyOperator(task_id='dimension_loading_complete')

    [customer_account_data_load_complete, finwire_data_load_complete,
     trade_data_load_complete] >> dimension_loading_complete

    # # All dimension loading is complete

    # # Start Fact Loading

    recreate_fact_cash_balances = reset_table('fact_cash_balances')

    load_fact_cash_balances_from_staging_history = MySqlOperator(
        task_id="load_fact_cash_balances_from_staging_history",
        execution_timeout=timedelta(hours=3),
        sql='queries/load_cash_balances_historical_to_dim_cash_balances.sql',
        params={'table':'master.fact_cash_balances'})


    recreate_fact_holdings = reset_table('fact_holdings')

    load_fact_holding_from_staging_history = MySqlOperator(
        task_id="load_fact_holding_from_staging_history",
        execution_timeout=timedelta(hours=3),
        sql='queries/load_holdings_historical_to_fact_holdings.sql',
        params={'table':'master.fact_holdings'})


    recreate_fact_watches = reset_table('fact_watches')

    load_fact_watches_from_staging_watch_history = MySqlOperator(
        task_id="load_fact_watches_from_staging_watch_history",
        execution_timeout=timedelta(hours=3),
        sql='queries/load_watch_history_historical_to_fact_watches.sql',
        params={'table':'master.fact_watches'})

 

    create_intermediary_table_daily_market = MySqlOperator(task_id='transform_to_52_week_stats',
                                                                execution_timeout=timedelta(hours=3),
                                                              sql='queries/transform_daily_market_historical_52_week.sql',
                                                               params={'table':'staging.daily_market_historical_transformed'})

    recreate_fact_market_history = reset_table('fact_market_history')

    load_fact_market_history_from_staging_market_history_transformed = MySqlOperator(
        task_id="load_fact_market_history_from_staging_market_history_transformed",
        sql='queries/load_fact_market_history_from_historical.sql',
         params={'table':'master.fact_market_history'})

    [dimension_loading_complete,
     load_cash_transactions_to_staging] >> recreate_fact_cash_balances >> load_fact_cash_balances_from_staging_history
    [dimension_loading_complete,
     load_holding_history_historical_to_staging] >> recreate_fact_holdings >> load_fact_holding_from_staging_history
    [dimension_loading_complete,
     load_watch_history_historical_to_staging] >> recreate_fact_watches >> load_fact_watches_from_staging_watch_history
    [dimension_loading_complete,
     load_daily_market_to_staging] >> create_intermediary_table_daily_market >> recreate_fact_market_history >> load_fact_market_history_from_staging_market_history_transformed
