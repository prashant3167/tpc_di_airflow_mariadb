#!/usr/bin/env bash
airflow db init
airflow users create -u pkg -f p -l p -r Admin -e anc@hdn.com -p pkg
airflow webserver