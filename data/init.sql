-- public.visits definition

-- Drop table

-- DROP TABLE public.visits;

CREATE UNLOGGED TABLE IF NOT EXISTS public.visits (
	id_visit varchar(20) NULL,
	id_service varchar(20) NULL,
	id_prvs int4 NULL,
	diag_name varchar(255) NULL,
	diag_code varchar(10) NULL,
	serv_count float8 NULL,
	vis_begin date NULL,
	vis_end date NULL,
	id_case varchar(15) NULL,
	serv_data_name varchar(255) NULL,
	id_record int4 NULL,
	id_lpu int4 NULL,
	id_serv_made int4 NULL,
	vid varchar(1) NULL,
	ctrldate date NULL
);
CREATE INDEX visits_id_service_idx ON public.visits USING btree (id_service);
-- CREATE UNIQUE INDEX visits_id_visit_idx ON public.visits USING btree (id_visit);

-- Permissions

ALTER TABLE public.visits OWNER TO postgres;
GRANT ALL ON TABLE public.visits TO postgres;

CREATE UNLOGGED TABLE IF NOT EXISTS public.dop_info_ump (
	id_service varchar(20) NULL,
	case_ump varchar(1) NULL);
-- CREATE INDEX dop_info_ump_id_service_idx ON public.dop_info_ump USING btree (id_service);

CREATE UNLOGGED TABLE IF NOT EXISTS public.dop_info_date (
	id_service varchar(20) NULL,
	ctrldate date NULL);
-- CREATE INDEX dop_info_date_id_service_idx ON public.dop_info_date USING btree (id_service);

ALTER TABLE public.dop_info_ump OWNER TO postgres;
GRANT ALL ON TABLE public.dop_info_ump  TO postgres;

ALTER TABLE public.dop_info_date OWNER TO postgres;
GRANT ALL ON TABLE public.dop_info_date  TO postgres;

TRUNCATE TABLE visits;

COPY visits (id_visit, id_service, id_prvs, diag_name, diag_code, serv_count, vis_begin, vis_end, id_case, serv_data_name, id_record, id_lpu, id_serv_made)
FROM '/var/lib/postgresql/files/visits.csv' DELIMITER ',' CSV HEADER;

-- TRUNCATE TABLE dop_info_date;

-- COPY dop_info_date (id_service, ctrldate)
-- FROM '/var/lib/postgresql/files/dop_info_date.csv' DELIMITER ',' CSV HEADER;

-- TRUNCATE TABLE dop_info_ump;

-- COPY dop_info_ump (id_service,case_ump)
-- FROM '/var/lib/postgresql/files/dop_info_case_ump.csv' DELIMITER ',' CSV HEADER;
