# Dockerfile for customized Airflow image with uv and dependencies

FROM apache/airflow:3.0.0-python3.12

USER airflow

RUN pip install --no-cache-dir uv \
 && uv pip install nba_api==1.3.1 dbt-core==1.9.0 dbt-postgres==1.9.0 pandas==2.2.2
