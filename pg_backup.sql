--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE airflow;
ALTER ROLE airflow WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:FbVhh9PStH7u9DzwCYjm7A==$JC9JpUF9StqyMi7w7y+kGIU8pJJ36f/Lx6Gv5zHZFkc=:ysKmdjZqy1YcyZwKWE/fh1NpSFvhtK/4qo9Fm9sQYKg=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "airflow" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: airflow; Type: DATABASE; Schema: -; Owner: airflow
--

CREATE DATABASE airflow WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE airflow OWNER TO airflow;

\connect airflow

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO airflow;

--
-- Name: asset; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset (
    id integer NOT NULL,
    name character varying(1500) NOT NULL,
    uri character varying(1500) NOT NULL,
    "group" character varying(1500) NOT NULL,
    extra json NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.asset OWNER TO airflow;

--
-- Name: asset_active; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_active (
    name character varying(1500) NOT NULL,
    uri character varying(1500) NOT NULL
);


ALTER TABLE public.asset_active OWNER TO airflow;

--
-- Name: asset_alias; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_alias (
    id integer NOT NULL,
    name character varying(1500) NOT NULL,
    "group" character varying(1500) NOT NULL
);


ALTER TABLE public.asset_alias OWNER TO airflow;

--
-- Name: asset_alias_asset; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_alias_asset (
    alias_id integer NOT NULL,
    asset_id integer NOT NULL
);


ALTER TABLE public.asset_alias_asset OWNER TO airflow;

--
-- Name: asset_alias_asset_event; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_alias_asset_event (
    alias_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.asset_alias_asset_event OWNER TO airflow;

--
-- Name: asset_alias_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.asset_alias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asset_alias_id_seq OWNER TO airflow;

--
-- Name: asset_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.asset_alias_id_seq OWNED BY public.asset_alias.id;


--
-- Name: asset_dag_run_queue; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_dag_run_queue (
    asset_id integer NOT NULL,
    target_dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.asset_dag_run_queue OWNER TO airflow;

--
-- Name: asset_event; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_event (
    id integer NOT NULL,
    asset_id integer NOT NULL,
    extra json NOT NULL,
    source_task_id character varying(250),
    source_dag_id character varying(250),
    source_run_id character varying(250),
    source_map_index integer DEFAULT '-1'::integer,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.asset_event OWNER TO airflow;

--
-- Name: asset_event_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.asset_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asset_event_id_seq OWNER TO airflow;

--
-- Name: asset_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.asset_event_id_seq OWNED BY public.asset_event.id;


--
-- Name: asset_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asset_id_seq OWNER TO airflow;

--
-- Name: asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.asset_id_seq OWNED BY public.asset.id;


--
-- Name: asset_trigger; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.asset_trigger (
    asset_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.asset_trigger OWNER TO airflow;

--
-- Name: backfill; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.backfill (
    id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    from_date timestamp with time zone NOT NULL,
    to_date timestamp with time zone NOT NULL,
    dag_run_conf json NOT NULL,
    is_paused boolean,
    reprocess_behavior character varying(250) NOT NULL,
    max_active_runs integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.backfill OWNER TO airflow;

--
-- Name: backfill_dag_run; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.backfill_dag_run (
    id integer NOT NULL,
    backfill_id integer NOT NULL,
    dag_run_id integer,
    exception_reason character varying(250),
    logical_date timestamp with time zone NOT NULL,
    sort_ordinal integer NOT NULL
);


ALTER TABLE public.backfill_dag_run OWNER TO airflow;

--
-- Name: backfill_dag_run_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.backfill_dag_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.backfill_dag_run_id_seq OWNER TO airflow;

--
-- Name: backfill_dag_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.backfill_dag_run_id_seq OWNED BY public.backfill_dag_run.id;


--
-- Name: backfill_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.backfill_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.backfill_id_seq OWNER TO airflow;

--
-- Name: backfill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.backfill_id_seq OWNED BY public.backfill.id;


--
-- Name: callback_request; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.callback_request (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    priority_weight integer NOT NULL,
    callback_data jsonb NOT NULL,
    callback_type character varying(20) NOT NULL
);


ALTER TABLE public.callback_request OWNER TO airflow;

--
-- Name: callback_request_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.callback_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.callback_request_id_seq OWNER TO airflow;

--
-- Name: callback_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.callback_request_id_seq OWNED BY public.callback_request.id;


--
-- Name: connection; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.connection (
    id integer NOT NULL,
    conn_id character varying(250) NOT NULL,
    conn_type character varying(500) NOT NULL,
    description text,
    host character varying(500),
    schema character varying(500),
    login text,
    password text,
    port integer,
    is_encrypted boolean,
    is_extra_encrypted boolean,
    extra text
);


ALTER TABLE public.connection OWNER TO airflow;

--
-- Name: connection_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.connection_id_seq OWNER TO airflow;

--
-- Name: connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.connection_id_seq OWNED BY public.connection.id;


--
-- Name: dag; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag (
    dag_id character varying(250) NOT NULL,
    is_paused boolean,
    is_stale boolean,
    last_parsed_time timestamp with time zone,
    last_expired timestamp with time zone,
    fileloc character varying(2000),
    relative_fileloc character varying(2000),
    bundle_name character varying(250),
    bundle_version character varying(200),
    owners character varying(2000),
    dag_display_name character varying(2000),
    description text,
    timetable_summary text,
    timetable_description character varying(1000),
    asset_expression json,
    max_active_tasks integer NOT NULL,
    max_active_runs integer,
    max_consecutive_failed_dag_runs integer NOT NULL,
    has_task_concurrency_limits boolean NOT NULL,
    has_import_errors boolean DEFAULT false,
    next_dagrun timestamp with time zone,
    next_dagrun_data_interval_start timestamp with time zone,
    next_dagrun_data_interval_end timestamp with time zone,
    next_dagrun_create_after timestamp with time zone
);


ALTER TABLE public.dag OWNER TO airflow;

--
-- Name: dag_bundle; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_bundle (
    name character varying(250) NOT NULL,
    active boolean,
    version character varying(200),
    last_refreshed timestamp with time zone
);


ALTER TABLE public.dag_bundle OWNER TO airflow;

--
-- Name: dag_code; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_code (
    id uuid NOT NULL,
    dag_id character varying(250) NOT NULL,
    fileloc character varying(2000) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    source_code text NOT NULL,
    source_code_hash character varying(32) NOT NULL,
    dag_version_id uuid NOT NULL
);


ALTER TABLE public.dag_code OWNER TO airflow;

--
-- Name: dag_owner_attributes; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_owner_attributes (
    dag_id character varying(250) NOT NULL,
    owner character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


ALTER TABLE public.dag_owner_attributes OWNER TO airflow;

--
-- Name: dag_priority_parsing_request; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_priority_parsing_request (
    id character varying(32) NOT NULL,
    bundle_name character varying(250) NOT NULL,
    relative_fileloc character varying(2000) NOT NULL
);


ALTER TABLE public.dag_priority_parsing_request OWNER TO airflow;

--
-- Name: dag_run; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_run (
    id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    queued_at timestamp with time zone,
    logical_date timestamp with time zone,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    state character varying(50),
    run_id character varying(250) NOT NULL,
    creating_job_id integer,
    run_type character varying(50) NOT NULL,
    triggered_by character varying(50),
    conf jsonb,
    data_interval_start timestamp with time zone,
    data_interval_end timestamp with time zone,
    run_after timestamp with time zone NOT NULL,
    last_scheduling_decision timestamp with time zone,
    log_template_id integer,
    updated_at timestamp with time zone,
    clear_number integer DEFAULT 0 NOT NULL,
    backfill_id integer,
    bundle_version character varying(250),
    scheduled_by_job_id integer,
    context_carrier jsonb,
    span_status character varying(250) DEFAULT 'not_started'::character varying NOT NULL,
    created_dag_version_id uuid
);


ALTER TABLE public.dag_run OWNER TO airflow;

--
-- Name: dag_run_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.dag_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dag_run_id_seq OWNER TO airflow;

--
-- Name: dag_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.dag_run_id_seq OWNED BY public.dag_run.id;


--
-- Name: dag_run_note; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_run_note (
    user_id character varying(128),
    dag_run_id integer NOT NULL,
    content character varying(1000),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_run_note OWNER TO airflow;

--
-- Name: dag_schedule_asset_alias_reference; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_schedule_asset_alias_reference (
    alias_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_alias_reference OWNER TO airflow;

--
-- Name: dag_schedule_asset_name_reference; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_schedule_asset_name_reference (
    name character varying(1500) NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_name_reference OWNER TO airflow;

--
-- Name: dag_schedule_asset_reference; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_schedule_asset_reference (
    asset_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_reference OWNER TO airflow;

--
-- Name: dag_schedule_asset_uri_reference; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_schedule_asset_uri_reference (
    uri character varying(1500) NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_asset_uri_reference OWNER TO airflow;

--
-- Name: dag_tag; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_tag (
    name character varying(100) NOT NULL,
    dag_id character varying(250) NOT NULL
);


ALTER TABLE public.dag_tag OWNER TO airflow;

--
-- Name: dag_version; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_version (
    id uuid NOT NULL,
    version_number integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    bundle_name character varying(250),
    bundle_version character varying(250),
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_version OWNER TO airflow;

--
-- Name: dag_warning; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dag_warning (
    dag_id character varying(250) NOT NULL,
    warning_type character varying(50) NOT NULL,
    message text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_warning OWNER TO airflow;

--
-- Name: dagrun_asset_event; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.dagrun_asset_event (
    dag_run_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.dagrun_asset_event OWNER TO airflow;

--
-- Name: deadline; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.deadline (
    id uuid NOT NULL,
    dag_id character varying(250),
    dagrun_id integer,
    deadline timestamp without time zone NOT NULL,
    callback character varying(500) NOT NULL,
    callback_kwargs json
);


ALTER TABLE public.deadline OWNER TO airflow;

--
-- Name: import_error; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.import_error (
    id integer NOT NULL,
    "timestamp" timestamp with time zone,
    filename character varying(1024),
    bundle_name character varying(250),
    stacktrace text
);


ALTER TABLE public.import_error OWNER TO airflow;

--
-- Name: import_error_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.import_error_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.import_error_id_seq OWNER TO airflow;

--
-- Name: import_error_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.import_error_id_seq OWNED BY public.import_error.id;


--
-- Name: job; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.job (
    id integer NOT NULL,
    dag_id character varying(250),
    state character varying(20),
    job_type character varying(30),
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    latest_heartbeat timestamp with time zone,
    executor_class character varying(500),
    hostname character varying(500),
    unixname character varying(1000)
);


ALTER TABLE public.job OWNER TO airflow;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_id_seq OWNER TO airflow;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.job_id_seq OWNED BY public.job.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.log (
    id integer NOT NULL,
    dttm timestamp with time zone,
    dag_id character varying(250),
    task_id character varying(250),
    map_index integer,
    event character varying(60),
    logical_date timestamp with time zone,
    run_id character varying(250),
    owner character varying(500),
    owner_display_name character varying(500),
    extra text,
    try_number integer
);


ALTER TABLE public.log OWNER TO airflow;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_id_seq OWNER TO airflow;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: log_template; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.log_template (
    id integer NOT NULL,
    filename text NOT NULL,
    elasticsearch_id text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.log_template OWNER TO airflow;

--
-- Name: log_template_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.log_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_template_id_seq OWNER TO airflow;

--
-- Name: log_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.log_template_id_seq OWNED BY public.log_template.id;


--
-- Name: rendered_task_instance_fields; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.rendered_task_instance_fields (
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    rendered_fields json NOT NULL,
    k8s_pod_yaml json
);


ALTER TABLE public.rendered_task_instance_fields OWNER TO airflow;

--
-- Name: serialized_dag; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.serialized_dag (
    id uuid NOT NULL,
    dag_id character varying(250) NOT NULL,
    data json,
    data_compressed bytea,
    created_at timestamp with time zone NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    dag_hash character varying(32) NOT NULL,
    dag_version_id uuid NOT NULL
);


ALTER TABLE public.serialized_dag OWNER TO airflow;

--
-- Name: slot_pool; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.slot_pool (
    id integer NOT NULL,
    pool character varying(256),
    slots integer,
    description text,
    include_deferred boolean NOT NULL
);


ALTER TABLE public.slot_pool OWNER TO airflow;

--
-- Name: slot_pool_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.slot_pool_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.slot_pool_id_seq OWNER TO airflow;

--
-- Name: slot_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.slot_pool_id_seq OWNED BY public.slot_pool.id;


--
-- Name: task_instance; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.task_instance (
    id uuid NOT NULL,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    duration double precision,
    state character varying(20),
    try_number integer,
    max_tries integer DEFAULT '-1'::integer,
    hostname character varying(1000),
    unixname character varying(1000),
    pool character varying(256) NOT NULL,
    pool_slots integer NOT NULL,
    queue character varying(256),
    priority_weight integer,
    operator character varying(1000),
    custom_operator_name character varying(1000),
    queued_dttm timestamp with time zone,
    scheduled_dttm timestamp with time zone,
    queued_by_job_id integer,
    last_heartbeat_at timestamp with time zone,
    pid integer,
    executor character varying(1000),
    executor_config bytea,
    updated_at timestamp with time zone,
    rendered_map_index character varying(250),
    context_carrier jsonb,
    span_status character varying(250) DEFAULT 'not_started'::character varying NOT NULL,
    external_executor_id character varying(250),
    trigger_id integer,
    trigger_timeout timestamp with time zone,
    next_method character varying(1000),
    next_kwargs jsonb,
    task_display_name character varying(2000),
    dag_version_id uuid
);


ALTER TABLE public.task_instance OWNER TO airflow;

--
-- Name: task_instance_history; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.task_instance_history (
    task_instance_id uuid NOT NULL,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    try_number integer NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    duration double precision,
    state character varying(20),
    max_tries integer DEFAULT '-1'::integer,
    hostname character varying(1000),
    unixname character varying(1000),
    pool character varying(256) NOT NULL,
    pool_slots integer NOT NULL,
    queue character varying(256),
    priority_weight integer,
    operator character varying(1000),
    custom_operator_name character varying(1000),
    queued_dttm timestamp with time zone,
    scheduled_dttm timestamp with time zone,
    queued_by_job_id integer,
    pid integer,
    executor character varying(1000),
    executor_config bytea,
    updated_at timestamp with time zone,
    rendered_map_index character varying(250),
    context_carrier jsonb,
    span_status character varying(250) DEFAULT 'not_started'::character varying NOT NULL,
    external_executor_id character varying(250),
    trigger_id integer,
    trigger_timeout timestamp without time zone,
    next_method character varying(1000),
    next_kwargs jsonb,
    task_display_name character varying(2000),
    dag_version_id uuid
);


ALTER TABLE public.task_instance_history OWNER TO airflow;

--
-- Name: task_instance_note; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.task_instance_note (
    ti_id uuid NOT NULL,
    user_id character varying(128),
    content character varying(1000),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_instance_note OWNER TO airflow;

--
-- Name: task_map; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.task_map (
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer NOT NULL,
    length integer NOT NULL,
    keys jsonb,
    CONSTRAINT ck_task_map_task_map_length_not_negative CHECK ((length >= 0))
);


ALTER TABLE public.task_map OWNER TO airflow;

--
-- Name: task_outlet_asset_reference; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.task_outlet_asset_reference (
    asset_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_outlet_asset_reference OWNER TO airflow;

--
-- Name: task_reschedule; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.task_reschedule (
    id integer NOT NULL,
    ti_id uuid NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    reschedule_date timestamp with time zone NOT NULL
);


ALTER TABLE public.task_reschedule OWNER TO airflow;

--
-- Name: task_reschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.task_reschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_reschedule_id_seq OWNER TO airflow;

--
-- Name: task_reschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.task_reschedule_id_seq OWNED BY public.task_reschedule.id;


--
-- Name: trigger; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.trigger (
    id integer NOT NULL,
    classpath character varying(1000) NOT NULL,
    kwargs text NOT NULL,
    created_date timestamp with time zone NOT NULL,
    triggerer_id integer
);


ALTER TABLE public.trigger OWNER TO airflow;

--
-- Name: trigger_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.trigger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trigger_id_seq OWNER TO airflow;

--
-- Name: trigger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.trigger_id_seq OWNED BY public.trigger.id;


--
-- Name: variable; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.variable (
    id integer NOT NULL,
    key character varying(250),
    val text,
    description text,
    is_encrypted boolean
);


ALTER TABLE public.variable OWNER TO airflow;

--
-- Name: variable_id_seq; Type: SEQUENCE; Schema: public; Owner: airflow
--

CREATE SEQUENCE public.variable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variable_id_seq OWNER TO airflow;

--
-- Name: variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: airflow
--

ALTER SEQUENCE public.variable_id_seq OWNED BY public.variable.id;


--
-- Name: xcom; Type: TABLE; Schema: public; Owner: airflow
--

CREATE TABLE public.xcom (
    dag_run_id integer NOT NULL,
    task_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    key character varying(512) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    value jsonb,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.xcom OWNER TO airflow;

--
-- Name: asset id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset ALTER COLUMN id SET DEFAULT nextval('public.asset_id_seq'::regclass);


--
-- Name: asset_alias id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias ALTER COLUMN id SET DEFAULT nextval('public.asset_alias_id_seq'::regclass);


--
-- Name: asset_event id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_event ALTER COLUMN id SET DEFAULT nextval('public.asset_event_id_seq'::regclass);


--
-- Name: backfill id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill ALTER COLUMN id SET DEFAULT nextval('public.backfill_id_seq'::regclass);


--
-- Name: backfill_dag_run id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill_dag_run ALTER COLUMN id SET DEFAULT nextval('public.backfill_dag_run_id_seq'::regclass);


--
-- Name: callback_request id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.callback_request ALTER COLUMN id SET DEFAULT nextval('public.callback_request_id_seq'::regclass);


--
-- Name: connection id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.connection ALTER COLUMN id SET DEFAULT nextval('public.connection_id_seq'::regclass);


--
-- Name: dag_run id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run ALTER COLUMN id SET DEFAULT nextval('public.dag_run_id_seq'::regclass);


--
-- Name: import_error id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.import_error ALTER COLUMN id SET DEFAULT nextval('public.import_error_id_seq'::regclass);


--
-- Name: job id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.job_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: log_template id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.log_template ALTER COLUMN id SET DEFAULT nextval('public.log_template_id_seq'::regclass);


--
-- Name: slot_pool id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.slot_pool ALTER COLUMN id SET DEFAULT nextval('public.slot_pool_id_seq'::regclass);


--
-- Name: task_reschedule id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_reschedule ALTER COLUMN id SET DEFAULT nextval('public.task_reschedule_id_seq'::regclass);


--
-- Name: trigger id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.trigger ALTER COLUMN id SET DEFAULT nextval('public.trigger_id_seq'::regclass);


--
-- Name: variable id; Type: DEFAULT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.variable ALTER COLUMN id SET DEFAULT nextval('public.variable_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.alembic_version (version_num) FROM stdin;
29ce7909c52b
\.


--
-- Data for Name: asset; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset (id, name, uri, "group", extra, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: asset_active; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_active (name, uri) FROM stdin;
\.


--
-- Data for Name: asset_alias; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_alias (id, name, "group") FROM stdin;
\.


--
-- Data for Name: asset_alias_asset; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_alias_asset (alias_id, asset_id) FROM stdin;
\.


--
-- Data for Name: asset_alias_asset_event; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_alias_asset_event (alias_id, event_id) FROM stdin;
\.


--
-- Data for Name: asset_dag_run_queue; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_dag_run_queue (asset_id, target_dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: asset_event; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_event (id, asset_id, extra, source_task_id, source_dag_id, source_run_id, source_map_index, "timestamp") FROM stdin;
\.


--
-- Data for Name: asset_trigger; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.asset_trigger (asset_id, trigger_id) FROM stdin;
\.


--
-- Data for Name: backfill; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.backfill (id, dag_id, from_date, to_date, dag_run_conf, is_paused, reprocess_behavior, max_active_runs, created_at, completed_at, updated_at) FROM stdin;
\.


--
-- Data for Name: backfill_dag_run; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.backfill_dag_run (id, backfill_id, dag_run_id, exception_reason, logical_date, sort_ordinal) FROM stdin;
\.


--
-- Data for Name: callback_request; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.callback_request (id, created_at, priority_weight, callback_data, callback_type) FROM stdin;
\.


--
-- Data for Name: connection; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.connection (id, conn_id, conn_type, description, host, schema, login, password, port, is_encrypted, is_extra_encrypted, extra) FROM stdin;
\.


--
-- Data for Name: dag; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag (dag_id, is_paused, is_stale, last_parsed_time, last_expired, fileloc, relative_fileloc, bundle_name, bundle_version, owners, dag_display_name, description, timetable_summary, timetable_description, asset_expression, max_active_tasks, max_active_runs, max_consecutive_failed_dag_runs, has_task_concurrency_limits, has_import_errors, next_dagrun, next_dagrun_data_interval_start, next_dagrun_data_interval_end, next_dagrun_create_after) FROM stdin;
\.


--
-- Data for Name: dag_bundle; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_bundle (name, active, version, last_refreshed) FROM stdin;
dags-folder	t	\N	2025-04-30 21:59:14.842426+00
\.


--
-- Data for Name: dag_code; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_code (id, dag_id, fileloc, created_at, last_updated, source_code, source_code_hash, dag_version_id) FROM stdin;
\.


--
-- Data for Name: dag_owner_attributes; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_owner_attributes (dag_id, owner, link) FROM stdin;
\.


--
-- Data for Name: dag_priority_parsing_request; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_priority_parsing_request (id, bundle_name, relative_fileloc) FROM stdin;
\.


--
-- Data for Name: dag_run; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_run (id, dag_id, queued_at, logical_date, start_date, end_date, state, run_id, creating_job_id, run_type, triggered_by, conf, data_interval_start, data_interval_end, run_after, last_scheduling_decision, log_template_id, updated_at, clear_number, backfill_id, bundle_version, scheduled_by_job_id, context_carrier, span_status, created_dag_version_id) FROM stdin;
\.


--
-- Data for Name: dag_run_note; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_run_note (user_id, dag_run_id, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_alias_reference; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_schedule_asset_alias_reference (alias_id, dag_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_name_reference; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_schedule_asset_name_reference (name, dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_reference; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_schedule_asset_reference (asset_id, dag_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_asset_uri_reference; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_schedule_asset_uri_reference (uri, dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: dag_tag; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_tag (name, dag_id) FROM stdin;
\.


--
-- Data for Name: dag_version; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_version (id, version_number, dag_id, bundle_name, bundle_version, created_at, last_updated) FROM stdin;
\.


--
-- Data for Name: dag_warning; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dag_warning (dag_id, warning_type, message, "timestamp") FROM stdin;
\.


--
-- Data for Name: dagrun_asset_event; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.dagrun_asset_event (dag_run_id, event_id) FROM stdin;
\.


--
-- Data for Name: deadline; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.deadline (id, dag_id, dagrun_id, deadline, callback, callback_kwargs) FROM stdin;
\.


--
-- Data for Name: import_error; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.import_error (id, "timestamp", filename, bundle_name, stacktrace) FROM stdin;
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.job (id, dag_id, state, job_type, start_date, end_date, latest_heartbeat, executor_class, hostname, unixname) FROM stdin;
4	\N	running	SchedulerJob	2025-04-30 21:59:14.971354+00	\N	2025-04-30 22:02:26.190784+00	\N	c845b89e4f4c	airflow
3	\N	running	SchedulerJob	2025-04-30 21:59:14.925693+00	\N	2025-04-30 22:02:26.186026+00	\N	47f3e7f2a894	airflow
1	\N	running	TriggererJob	2025-04-30 21:59:14.80446+00	\N	2025-04-30 22:02:26.490885+00	\N	47f3e7f2a894	airflow
2	\N	running	DagProcessorJob	2025-04-30 21:59:14.781696+00	\N	2025-04-30 22:02:27.341061+00	\N	47f3e7f2a894	airflow
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.log (id, dttm, dag_id, task_id, map_index, event, logical_date, run_id, owner, owner_display_name, extra, try_number) FROM stdin;
1	2025-04-30 21:59:08.299181+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "c845b89e4f4c", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
2	2025-04-30 21:59:08.317488+00	\N	\N	\N	cli_check	\N	\N	airflow	\N	{"host_name": "47f3e7f2a894", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}	\N
3	2025-04-30 21:59:13.306351+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "c845b89e4f4c", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
4	2025-04-30 21:59:13.406071+00	\N	\N	\N	cli_scheduler	\N	\N	airflow	\N	{"host_name": "47f3e7f2a894", "full_command": "['/home/airflow/.local/bin/airflow', 'scheduler']"}	\N
5	2025-04-30 21:59:13.466771+00	\N	\N	\N	cli_api_server	\N	\N	airflow	\N	{"host_name": "47f3e7f2a894", "full_command": "['/home/airflow/.local/bin/airflow', 'api-server']"}	\N
6	2025-04-30 21:59:13.560676+00	\N	\N	\N	cli_dag_processor	\N	\N	airflow	\N	{"host_name": "47f3e7f2a894", "full_command": "['/home/airflow/.local/bin/airflow', 'dag-processor']"}	\N
7	2025-04-30 21:59:13.667293+00	\N	\N	\N	cli_triggerer	\N	\N	airflow	\N	{"host_name": "47f3e7f2a894", "full_command": "['/home/airflow/.local/bin/airflow', 'triggerer']"}	\N
\.


--
-- Data for Name: log_template; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.log_template (id, filename, elasticsearch_id, created_at) FROM stdin;
1	{{ ti.dag_id }}/{{ ti.task_id }}/{{ ts }}/{{ try_number }}.log	{dag_id}-{task_id}-{logical_date}-{try_number}	2025-04-30 21:59:03.511815+00
2	dag_id={{ ti.dag_id }}/run_id={{ ti.run_id }}/task_id={{ ti.task_id }}/{% if ti.map_index >= 0 %}map_index={{ ti.map_index }}/{% endif %}attempt={{ try_number|default(ti.try_number) }}.log	{dag_id}-{task_id}-{run_id}-{map_index}-{try_number}	2025-04-30 21:59:03.511821+00
\.


--
-- Data for Name: rendered_task_instance_fields; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.rendered_task_instance_fields (dag_id, task_id, run_id, map_index, rendered_fields, k8s_pod_yaml) FROM stdin;
\.


--
-- Data for Name: serialized_dag; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.serialized_dag (id, dag_id, data, data_compressed, created_at, last_updated, dag_hash, dag_version_id) FROM stdin;
\.


--
-- Data for Name: slot_pool; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.slot_pool (id, pool, slots, description, include_deferred) FROM stdin;
1	default_pool	128	Default pool	f
\.


--
-- Data for Name: task_instance; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.task_instance (id, task_id, dag_id, run_id, map_index, start_date, end_date, duration, state, try_number, max_tries, hostname, unixname, pool, pool_slots, queue, priority_weight, operator, custom_operator_name, queued_dttm, scheduled_dttm, queued_by_job_id, last_heartbeat_at, pid, executor, executor_config, updated_at, rendered_map_index, context_carrier, span_status, external_executor_id, trigger_id, trigger_timeout, next_method, next_kwargs, task_display_name, dag_version_id) FROM stdin;
\.


--
-- Data for Name: task_instance_history; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.task_instance_history (task_instance_id, task_id, dag_id, run_id, map_index, try_number, start_date, end_date, duration, state, max_tries, hostname, unixname, pool, pool_slots, queue, priority_weight, operator, custom_operator_name, queued_dttm, scheduled_dttm, queued_by_job_id, pid, executor, executor_config, updated_at, rendered_map_index, context_carrier, span_status, external_executor_id, trigger_id, trigger_timeout, next_method, next_kwargs, task_display_name, dag_version_id) FROM stdin;
\.


--
-- Data for Name: task_instance_note; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.task_instance_note (ti_id, user_id, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_map; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.task_map (dag_id, task_id, run_id, map_index, length, keys) FROM stdin;
\.


--
-- Data for Name: task_outlet_asset_reference; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.task_outlet_asset_reference (asset_id, dag_id, task_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_reschedule; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.task_reschedule (id, ti_id, start_date, end_date, duration, reschedule_date) FROM stdin;
\.


--
-- Data for Name: trigger; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.trigger (id, classpath, kwargs, created_date, triggerer_id) FROM stdin;
\.


--
-- Data for Name: variable; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.variable (id, key, val, description, is_encrypted) FROM stdin;
\.


--
-- Data for Name: xcom; Type: TABLE DATA; Schema: public; Owner: airflow
--

COPY public.xcom (dag_run_id, task_id, map_index, key, dag_id, run_id, value, "timestamp") FROM stdin;
\.


--
-- Name: asset_alias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.asset_alias_id_seq', 1, false);


--
-- Name: asset_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.asset_event_id_seq', 1, false);


--
-- Name: asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.asset_id_seq', 1, false);


--
-- Name: backfill_dag_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.backfill_dag_run_id_seq', 1, false);


--
-- Name: backfill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.backfill_id_seq', 1, false);


--
-- Name: callback_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.callback_request_id_seq', 1, false);


--
-- Name: connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.connection_id_seq', 1, false);


--
-- Name: dag_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.dag_run_id_seq', 1, false);


--
-- Name: import_error_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.import_error_id_seq', 1, false);


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.job_id_seq', 4, true);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.log_id_seq', 7, true);


--
-- Name: log_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.log_template_id_seq', 2, true);


--
-- Name: slot_pool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.slot_pool_id_seq', 1, true);


--
-- Name: task_reschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.task_reschedule_id_seq', 1, false);


--
-- Name: trigger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.trigger_id_seq', 1, false);


--
-- Name: variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airflow
--

SELECT pg_catalog.setval('public.variable_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: asset_active asset_active_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_active
    ADD CONSTRAINT asset_active_pkey PRIMARY KEY (name, uri);


--
-- Name: asset_alias_asset_event asset_alias_asset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias_asset_event
    ADD CONSTRAINT asset_alias_asset_event_pkey PRIMARY KEY (alias_id, event_id);


--
-- Name: asset_alias_asset asset_alias_asset_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias_asset
    ADD CONSTRAINT asset_alias_asset_pkey PRIMARY KEY (alias_id, asset_id);


--
-- Name: asset_alias asset_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias
    ADD CONSTRAINT asset_alias_pkey PRIMARY KEY (id);


--
-- Name: asset_event asset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_event
    ADD CONSTRAINT asset_event_pkey PRIMARY KEY (id);


--
-- Name: asset asset_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY (id);


--
-- Name: asset_trigger asset_trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_trigger
    ADD CONSTRAINT asset_trigger_pkey PRIMARY KEY (asset_id, trigger_id);


--
-- Name: asset_dag_run_queue assetdagrunqueue_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_dag_run_queue
    ADD CONSTRAINT assetdagrunqueue_pkey PRIMARY KEY (asset_id, target_dag_id);


--
-- Name: backfill_dag_run backfill_dag_run_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT backfill_dag_run_pkey PRIMARY KEY (id);


--
-- Name: backfill backfill_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill
    ADD CONSTRAINT backfill_pkey PRIMARY KEY (id);


--
-- Name: callback_request callback_request_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.callback_request
    ADD CONSTRAINT callback_request_pkey PRIMARY KEY (id);


--
-- Name: connection connection_conn_id_uq; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_conn_id_uq UNIQUE (conn_id);


--
-- Name: connection connection_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_pkey PRIMARY KEY (id);


--
-- Name: dag_bundle dag_bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_bundle
    ADD CONSTRAINT dag_bundle_pkey PRIMARY KEY (name);


--
-- Name: dag_code dag_code_dag_version_id_uq; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_dag_version_id_uq UNIQUE (dag_version_id);


--
-- Name: dag_code dag_code_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_pkey PRIMARY KEY (id);


--
-- Name: dag_version dag_id_v_name_v_number_unique_constraint; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_version
    ADD CONSTRAINT dag_id_v_name_v_number_unique_constraint UNIQUE (dag_id, version_number);


--
-- Name: dag_owner_attributes dag_owner_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_owner_attributes
    ADD CONSTRAINT dag_owner_attributes_pkey PRIMARY KEY (dag_id, owner);


--
-- Name: dag dag_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag
    ADD CONSTRAINT dag_pkey PRIMARY KEY (dag_id);


--
-- Name: dag_priority_parsing_request dag_priority_parsing_request_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_priority_parsing_request
    ADD CONSTRAINT dag_priority_parsing_request_pkey PRIMARY KEY (id);


--
-- Name: dag_run dag_run_dag_id_logical_date_key; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_dag_id_logical_date_key UNIQUE (dag_id, logical_date);


--
-- Name: dag_run dag_run_dag_id_run_id_key; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_dag_id_run_id_key UNIQUE (dag_id, run_id);


--
-- Name: dag_run_note dag_run_note_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_pkey PRIMARY KEY (dag_run_id);


--
-- Name: dag_run dag_run_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_pkey PRIMARY KEY (id);


--
-- Name: dag_tag dag_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_tag
    ADD CONSTRAINT dag_tag_pkey PRIMARY KEY (name, dag_id);


--
-- Name: dag_version dag_version_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_version
    ADD CONSTRAINT dag_version_pkey PRIMARY KEY (id);


--
-- Name: dag_warning dag_warning_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_warning
    ADD CONSTRAINT dag_warning_pkey PRIMARY KEY (dag_id, warning_type);


--
-- Name: dagrun_asset_event dagrun_asset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dagrun_asset_event
    ADD CONSTRAINT dagrun_asset_event_pkey PRIMARY KEY (dag_run_id, event_id);


--
-- Name: deadline deadline_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.deadline
    ADD CONSTRAINT deadline_pkey PRIMARY KEY (id);


--
-- Name: dag_schedule_asset_alias_reference dsaar_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_alias_reference
    ADD CONSTRAINT dsaar_pkey PRIMARY KEY (alias_id, dag_id);


--
-- Name: dag_schedule_asset_name_reference dsanr_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_name_reference
    ADD CONSTRAINT dsanr_pkey PRIMARY KEY (name, dag_id);


--
-- Name: dag_schedule_asset_reference dsar_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_reference
    ADD CONSTRAINT dsar_pkey PRIMARY KEY (asset_id, dag_id);


--
-- Name: dag_schedule_asset_uri_reference dsaur_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_uri_reference
    ADD CONSTRAINT dsaur_pkey PRIMARY KEY (uri, dag_id);


--
-- Name: import_error import_error_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.import_error
    ADD CONSTRAINT import_error_pkey PRIMARY KEY (id);


--
-- Name: backfill_dag_run ix_bdr_backfill_id_dag_run_id; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT ix_bdr_backfill_id_dag_run_id UNIQUE (backfill_id, dag_run_id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: log_template log_template_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.log_template
    ADD CONSTRAINT log_template_pkey PRIMARY KEY (id);


--
-- Name: rendered_task_instance_fields rendered_task_instance_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.rendered_task_instance_fields
    ADD CONSTRAINT rendered_task_instance_fields_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: serialized_dag serialized_dag_dag_version_id_uq; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_dag_version_id_uq UNIQUE (dag_version_id);


--
-- Name: serialized_dag serialized_dag_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_pkey PRIMARY KEY (id);


--
-- Name: slot_pool slot_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.slot_pool
    ADD CONSTRAINT slot_pool_pkey PRIMARY KEY (id);


--
-- Name: slot_pool slot_pool_pool_uq; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.slot_pool
    ADD CONSTRAINT slot_pool_pool_uq UNIQUE (pool);


--
-- Name: task_instance task_instance_composite_key; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_composite_key UNIQUE (dag_id, task_id, run_id, map_index);


--
-- Name: task_instance_history task_instance_history_dtrt_uq; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance_history
    ADD CONSTRAINT task_instance_history_dtrt_uq UNIQUE (dag_id, task_id, run_id, map_index, try_number);


--
-- Name: task_instance_history task_instance_history_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance_history
    ADD CONSTRAINT task_instance_history_pkey PRIMARY KEY (task_instance_id);


--
-- Name: task_instance_note task_instance_note_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_pkey PRIMARY KEY (ti_id);


--
-- Name: task_instance task_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_pkey PRIMARY KEY (id);


--
-- Name: task_map task_map_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_map
    ADD CONSTRAINT task_map_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: task_reschedule task_reschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_pkey PRIMARY KEY (id);


--
-- Name: task_outlet_asset_reference toar_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_outlet_asset_reference
    ADD CONSTRAINT toar_pkey PRIMARY KEY (asset_id, dag_id, task_id);


--
-- Name: trigger trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.trigger
    ADD CONSTRAINT trigger_pkey PRIMARY KEY (id);


--
-- Name: variable variable_key_uq; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_key_uq UNIQUE (key);


--
-- Name: variable variable_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_pkey PRIMARY KEY (id);


--
-- Name: xcom xcom_pkey; Type: CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.xcom
    ADD CONSTRAINT xcom_pkey PRIMARY KEY (dag_run_id, task_id, map_index, key);


--
-- Name: dag_id_state; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX dag_id_state ON public.dag_run USING btree (dag_id, state);


--
-- Name: deadline_idx; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX deadline_idx ON public.deadline USING btree (deadline);


--
-- Name: idx_asset_active_name_unique; Type: INDEX; Schema: public; Owner: airflow
--

CREATE UNIQUE INDEX idx_asset_active_name_unique ON public.asset_active USING btree (name);


--
-- Name: idx_asset_active_uri_unique; Type: INDEX; Schema: public; Owner: airflow
--

CREATE UNIQUE INDEX idx_asset_active_uri_unique ON public.asset_active USING btree (uri);


--
-- Name: idx_asset_alias_asset_alias_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_alias_asset_alias_id ON public.asset_alias_asset USING btree (alias_id);


--
-- Name: idx_asset_alias_asset_asset_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_alias_asset_asset_id ON public.asset_alias_asset USING btree (asset_id);


--
-- Name: idx_asset_alias_asset_event_alias_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_alias_asset_event_alias_id ON public.asset_alias_asset_event USING btree (alias_id);


--
-- Name: idx_asset_alias_asset_event_event_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_alias_asset_event_event_id ON public.asset_alias_asset_event USING btree (event_id);


--
-- Name: idx_asset_alias_name_unique; Type: INDEX; Schema: public; Owner: airflow
--

CREATE UNIQUE INDEX idx_asset_alias_name_unique ON public.asset_alias USING btree (name);


--
-- Name: idx_asset_dag_run_queue_target_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_dag_run_queue_target_dag_id ON public.asset_dag_run_queue USING btree (target_dag_id);


--
-- Name: idx_asset_id_timestamp; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_id_timestamp ON public.asset_event USING btree (asset_id, "timestamp");


--
-- Name: idx_asset_name_uri_unique; Type: INDEX; Schema: public; Owner: airflow
--

CREATE UNIQUE INDEX idx_asset_name_uri_unique ON public.asset USING btree (name, uri);


--
-- Name: idx_asset_trigger_asset_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_trigger_asset_id ON public.asset_trigger USING btree (asset_id);


--
-- Name: idx_asset_trigger_trigger_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_asset_trigger_trigger_id ON public.asset_trigger USING btree (trigger_id);


--
-- Name: idx_dag_run_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_run_dag_id ON public.dag_run USING btree (dag_id);


--
-- Name: idx_dag_run_queued_dags; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_run_queued_dags ON public.dag_run USING btree (state, dag_id) WHERE ((state)::text = 'queued'::text);


--
-- Name: idx_dag_run_run_after; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_run_run_after ON public.dag_run USING btree (run_after);


--
-- Name: idx_dag_run_running_dags; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_run_running_dags ON public.dag_run USING btree (state, dag_id) WHERE ((state)::text = 'running'::text);


--
-- Name: idx_dag_schedule_asset_alias_reference_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_schedule_asset_alias_reference_dag_id ON public.dag_schedule_asset_alias_reference USING btree (dag_id);


--
-- Name: idx_dag_schedule_asset_name_reference_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_schedule_asset_name_reference_dag_id ON public.dag_schedule_asset_name_reference USING btree (dag_id);


--
-- Name: idx_dag_schedule_asset_reference_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_schedule_asset_reference_dag_id ON public.dag_schedule_asset_reference USING btree (dag_id);


--
-- Name: idx_dag_schedule_asset_uri_reference_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_schedule_asset_uri_reference_dag_id ON public.dag_schedule_asset_uri_reference USING btree (dag_id);


--
-- Name: idx_dag_tag_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_tag_dag_id ON public.dag_tag USING btree (dag_id);


--
-- Name: idx_dag_warning_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dag_warning_dag_id ON public.dag_warning USING btree (dag_id);


--
-- Name: idx_dagrun_asset_events_dag_run_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dagrun_asset_events_dag_run_id ON public.dagrun_asset_event USING btree (dag_run_id);


--
-- Name: idx_dagrun_asset_events_event_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_dagrun_asset_events_event_id ON public.dagrun_asset_event USING btree (event_id);


--
-- Name: idx_job_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_job_dag_id ON public.job USING btree (dag_id);


--
-- Name: idx_job_state_heartbeat; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_job_state_heartbeat ON public.job USING btree (state, latest_heartbeat);


--
-- Name: idx_log_dttm; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_log_dttm ON public.log USING btree (dttm);


--
-- Name: idx_log_event; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_log_event ON public.log USING btree (event);


--
-- Name: idx_log_task_instance; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_log_task_instance ON public.log USING btree (dag_id, task_id, run_id, map_index, try_number);


--
-- Name: idx_next_dagrun_create_after; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_next_dagrun_create_after ON public.dag USING btree (next_dagrun_create_after);


--
-- Name: idx_task_outlet_asset_reference_dag_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_task_outlet_asset_reference_dag_id ON public.task_outlet_asset_reference USING btree (dag_id);


--
-- Name: idx_tih_dag_run; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_tih_dag_run ON public.task_instance_history USING btree (dag_id, run_id);


--
-- Name: idx_xcom_key; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_xcom_key ON public.xcom USING btree (key);


--
-- Name: idx_xcom_task_instance; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX idx_xcom_task_instance ON public.xcom USING btree (dag_id, task_id, run_id, map_index);


--
-- Name: job_type_heart; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX job_type_heart ON public.job USING btree (job_type, latest_heartbeat);


--
-- Name: ti_dag_run; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_dag_run ON public.task_instance USING btree (dag_id, run_id);


--
-- Name: ti_dag_state; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_dag_state ON public.task_instance USING btree (dag_id, state);


--
-- Name: ti_heartbeat; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_heartbeat ON public.task_instance USING btree (last_heartbeat_at);


--
-- Name: ti_pool; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_pool ON public.task_instance USING btree (pool, state, priority_weight);


--
-- Name: ti_state; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_state ON public.task_instance USING btree (state);


--
-- Name: ti_state_lkp; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_state_lkp ON public.task_instance USING btree (dag_id, task_id, run_id, state);


--
-- Name: ti_trigger_id; Type: INDEX; Schema: public; Owner: airflow
--

CREATE INDEX ti_trigger_id ON public.task_instance USING btree (trigger_id);


--
-- Name: asset_dag_run_queue adrq_asset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_dag_run_queue
    ADD CONSTRAINT adrq_asset_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: asset_dag_run_queue adrq_dag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_dag_run_queue
    ADD CONSTRAINT adrq_dag_fkey FOREIGN KEY (target_dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: asset_active asset_active_asset_name_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_active
    ADD CONSTRAINT asset_active_asset_name_uri_fkey FOREIGN KEY (name, uri) REFERENCES public.asset(name, uri) ON DELETE CASCADE;


--
-- Name: asset_alias_asset asset_alias_asset_alias_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias_asset
    ADD CONSTRAINT asset_alias_asset_alias_id_fkey FOREIGN KEY (alias_id) REFERENCES public.asset_alias(id) ON DELETE CASCADE;


--
-- Name: asset_alias_asset asset_alias_asset_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias_asset
    ADD CONSTRAINT asset_alias_asset_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: asset_alias_asset_event asset_alias_asset_event_alias_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias_asset_event
    ADD CONSTRAINT asset_alias_asset_event_alias_id_fkey FOREIGN KEY (alias_id) REFERENCES public.asset_alias(id) ON DELETE CASCADE;


--
-- Name: asset_alias_asset_event asset_alias_asset_event_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_alias_asset_event
    ADD CONSTRAINT asset_alias_asset_event_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.asset_event(id) ON DELETE CASCADE;


--
-- Name: asset_trigger asset_trigger_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_trigger
    ADD CONSTRAINT asset_trigger_asset_id_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: asset_trigger asset_trigger_trigger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.asset_trigger
    ADD CONSTRAINT asset_trigger_trigger_id_fkey FOREIGN KEY (trigger_id) REFERENCES public.trigger(id) ON DELETE CASCADE;


--
-- Name: backfill_dag_run bdr_backfill_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT bdr_backfill_fkey FOREIGN KEY (backfill_id) REFERENCES public.backfill(id) ON DELETE CASCADE;


--
-- Name: backfill_dag_run bdr_dag_run_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.backfill_dag_run
    ADD CONSTRAINT bdr_dag_run_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE SET NULL;


--
-- Name: dag_run created_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT created_dag_version_id_fkey FOREIGN KEY (created_dag_version_id) REFERENCES public.dag_version(id) ON DELETE SET NULL;


--
-- Name: dag_owner_attributes dag.dag_id; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_owner_attributes
    ADD CONSTRAINT "dag.dag_id" FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag dag_bundle_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag
    ADD CONSTRAINT dag_bundle_name_fkey FOREIGN KEY (bundle_name) REFERENCES public.dag_bundle(name);


--
-- Name: dag_code dag_code_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_dag_version_id_fkey FOREIGN KEY (dag_version_id) REFERENCES public.dag_version(id) ON DELETE CASCADE;


--
-- Name: dag_run dag_run_backfill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_backfill_id_fkey FOREIGN KEY (backfill_id) REFERENCES public.backfill(id);


--
-- Name: dag_run_note dag_run_note_dr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_dr_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dag_tag dag_tag_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_tag
    ADD CONSTRAINT dag_tag_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_version dag_version_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_version
    ADD CONSTRAINT dag_version_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dagrun_asset_event dagrun_asset_event_dag_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dagrun_asset_event
    ADD CONSTRAINT dagrun_asset_event_dag_run_id_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dagrun_asset_event dagrun_asset_event_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dagrun_asset_event
    ADD CONSTRAINT dagrun_asset_event_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.asset_event(id) ON DELETE CASCADE;


--
-- Name: dag_warning dcw_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_warning
    ADD CONSTRAINT dcw_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: deadline deadline_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.deadline
    ADD CONSTRAINT deadline_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: deadline deadline_dagrun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.deadline
    ADD CONSTRAINT deadline_dagrun_id_fkey FOREIGN KEY (dagrun_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_alias_reference dsaar_asset_alias_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_alias_reference
    ADD CONSTRAINT dsaar_asset_alias_fkey FOREIGN KEY (alias_id) REFERENCES public.asset_alias(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_alias_reference dsaar_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_alias_reference
    ADD CONSTRAINT dsaar_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_name_reference dsanr_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_name_reference
    ADD CONSTRAINT dsanr_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_reference dsar_asset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_reference
    ADD CONSTRAINT dsar_asset_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_reference dsar_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_reference
    ADD CONSTRAINT dsar_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_asset_uri_reference dsaur_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_schedule_asset_uri_reference
    ADD CONSTRAINT dsaur_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: rendered_task_instance_fields rtif_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.rendered_task_instance_fields
    ADD CONSTRAINT rtif_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- Name: serialized_dag serialized_dag_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_dag_version_id_fkey FOREIGN KEY (dag_version_id) REFERENCES public.dag_version(id) ON DELETE CASCADE;


--
-- Name: task_instance task_instance_dag_run_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_dag_run_fkey FOREIGN KEY (dag_id, run_id) REFERENCES public.dag_run(dag_id, run_id) ON DELETE CASCADE;


--
-- Name: task_instance task_instance_dag_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_dag_version_id_fkey FOREIGN KEY (dag_version_id) REFERENCES public.dag_version(id) ON DELETE CASCADE;


--
-- Name: task_instance_history task_instance_history_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance_history
    ADD CONSTRAINT task_instance_history_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dag_run task_instance_log_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT task_instance_log_template_id_fkey FOREIGN KEY (log_template_id) REFERENCES public.log_template(id);


--
-- Name: task_instance_note task_instance_note_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_ti_fkey FOREIGN KEY (ti_id) REFERENCES public.task_instance(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_instance task_instance_trigger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_trigger_id_fkey FOREIGN KEY (trigger_id) REFERENCES public.trigger(id) ON DELETE CASCADE;


--
-- Name: task_map task_map_task_instance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_map
    ADD CONSTRAINT task_map_task_instance_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_reschedule task_reschedule_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_ti_fkey FOREIGN KEY (ti_id) REFERENCES public.task_instance(id) ON DELETE CASCADE;


--
-- Name: task_outlet_asset_reference toar_asset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_outlet_asset_reference
    ADD CONSTRAINT toar_asset_fkey FOREIGN KEY (asset_id) REFERENCES public.asset(id) ON DELETE CASCADE;


--
-- Name: task_outlet_asset_reference toar_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.task_outlet_asset_reference
    ADD CONSTRAINT toar_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: xcom xcom_task_instance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: airflow
--

ALTER TABLE ONLY public.xcom
    ADD CONSTRAINT xcom_task_instance_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

