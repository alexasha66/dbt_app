-- public.cards definition

-- Drop table

-- DROP TABLE public.cards;

CREATE UNLOGGED TABLE IF NOT EXISTS public.cards (
	datetr date NULL,
	numtr varchar(16) NULL,
	reciever varchar(10) NULL,
	tmo varchar(10) NULL,
	surname varchar(18) NULL,
	name1 varchar(15) NULL,
	name2 varchar(15) NULL,
	birthday date NULL,
	age numeric(3) NULL,
	sex varchar(1) NULL,
	polis_s varchar(20) NULL,
	polis_n varchar(20) NULL,
	polis_w varchar(5) NULL,
	pasp_s varchar(10) NULL,
	pasp_n varchar(6) NULL,
	street varchar(5) NULL,
	streetype varchar(2) NULL,
	area varchar(3) NULL,
	house varchar(7) NULL,
	korp varchar(2) NULL,
	flat numeric(4) NULL,
	who varchar(4) NULL,
	"order" varchar(1) NULL,
	profile varchar(16) NULL,
	datein date NULL,
	dateout date NULL,
	amount numeric(5, 1) NULL,
	diagnosis varchar(5) NULL,
	history varchar(20) NULL,
	tmonth varchar(2) NULL,
	pin varchar(15) NULL,
	sum numeric(10, 2) NULL,
	sum_n numeric(11, 2) NULL,
	card_id varchar(8) NULL,
	acntdate date NULL,
	ctrldate date NULL,
	id_account varchar(20) NULL,
	id_patient varchar(20) NULL,
	id_case varchar(20) NULL,
	ref_date date NULL,
	numpay varchar(7) NULL,
	datepay date NULL,
	address varchar(200) NULL,
	okato varchar(3) NULL,
	polis_beg date NULL,
	polis_end date NULL,
	cod_z int8 NULL,
	vid varchar(1) NULL,
	code_prot int4 NULL,
	case_qresult79 int4 NULL,
	code_mo varchar(50) NULL,
	id_service varchar(20) NULL
);
CREATE UNIQUE INDEX cards_id_service_idx ON public.cards USING btree (id_service);

-- Permissions

ALTER TABLE public.cards OWNER TO postgres;
GRANT ALL ON TABLE public.cards TO postgres;


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

TRUNCATE TABLE dop_info_date;

-- COPY dop_info_date (id_service, ctrldate)
-- FROM '/var/lib/postgresql/files/dop_info_date.csv' DELIMITER ',' CSV HEADER;

-- TRUNCATE TABLE dop_info_ump;

-- COPY dop_info_ump (id_service,case_ump)
-- FROM '/var/lib/postgresql/files/dop_info_case_ump.csv' DELIMITER ',' CSV HEADER;

-- TRUNCATE TABLE cards;

-- COPY cards (datetr,numtr,reciever,tmo,surname,name1,name2,birthday,age,sex,polis_s,polis_n,polis_w,pasp_s,pasp_n,street,streetype,area,house,korp,flat,order,profile,datein,dateout,amount,diagnosis,history,tmonth,pin,sum,sum_n,card_id,ctrldate,id_account,id_patient,id_case,address,okato,polis_beg,polis_end,case_qresult79,code_mo,id_service)
-- FROM '/var/lib/postgresql/files/cards_1000.csv' DELIMITER ',' CSV HEADER;
