.PHONY: dbt dbt-run dbt-test dbt-debug dbt-build dbt-clean fetch

fetch:
	docker exec -it $$(docker ps -qf "name=airflow-apiserver") python fetch_and_load_data.py $(ARGS)

DBT_CONTAINER := $$(docker ps -qf "name=dbt")

dbt:
	docker exec -w /home/airflow/dbt/nba_stats_dbt -it $(DBT_CONTAINER) dbt $(ARGS)


dbt-run:
	make dbt ARGS="run"

dbt-test:
	make dbt ARGS="test"

dbt-debug:
	make dbt ARGS="debug"

dbt-build:
	make dbt ARGS="build"

dbt-clean:
	make dbt ARGS="clean"
