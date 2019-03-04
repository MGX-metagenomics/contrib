--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: category; Type: TABLE; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE TABLE category (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE category OWNER TO mgxadm;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: mgxadm
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO mgxadm;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mgxadm
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: reference; Type: TABLE; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE TABLE reference (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    ref_length integer NOT NULL,
    ref_filepath character varying(255) NOT NULL
);


ALTER TABLE reference OWNER TO mgxadm;

--
-- Name: reference_id_seq; Type: SEQUENCE; Schema: public; Owner: mgxadm
--

CREATE SEQUENCE reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reference_id_seq OWNER TO mgxadm;

--
-- Name: reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mgxadm
--

ALTER SEQUENCE reference_id_seq OWNED BY reference.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE TABLE region (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(32),
    reg_start integer NOT NULL,
    reg_stop integer NOT NULL,
    ref_id bigint NOT NULL REFERENCES reference(id)
);


ALTER TABLE region OWNER TO mgxadm;

--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: mgxadm
--

CREATE SEQUENCE region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE region_id_seq OWNER TO mgxadm;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mgxadm
--

ALTER SEQUENCE region_id_seq OWNED BY region.id;


--
-- Name: term; Type: TABLE; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE TABLE term (
    id integer NOT NULL,
    cat_id bigint NOT NULL,
    parent_id bigint,
    name character varying(255) NOT NULL,
    description text
);


ALTER TABLE term OWNER TO mgxadm;

--
-- Name: term_id_seq; Type: SEQUENCE; Schema: public; Owner: mgxadm
--

CREATE SEQUENCE term_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE term_id_seq OWNER TO mgxadm;

--
-- Name: term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mgxadm
--

ALTER SEQUENCE term_id_seq OWNED BY term.id;


--
-- Name: tool; Type: TABLE; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE TABLE tool (
    id bigint NOT NULL,
    author character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255),
    version real NOT NULL,
    xml_file character varying(255) NOT NULL
);


ALTER TABLE tool OWNER TO mgxadm;

--
-- Name: tool_id_seq; Type: SEQUENCE; Schema: public; Owner: mgxadm
--

CREATE SEQUENCE tool_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tool_id_seq OWNER TO mgxadm;

--
-- Name: tool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mgxadm
--

ALTER SEQUENCE tool_id_seq OWNED BY tool.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY reference ALTER COLUMN id SET DEFAULT nextval('reference_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY region ALTER COLUMN id SET DEFAULT nextval('region_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY term ALTER COLUMN id SET DEFAULT nextval('term_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY tool ALTER COLUMN id SET DEFAULT nextval('tool_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: mgxadm
--

COPY category (id, name) FROM stdin;
1	seq_platforms
2	seq_methods
3	volume_units
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mgxadm
--

SELECT pg_catalog.setval('category_id_seq', 3, true);


--
-- Data for Name: term; Type: TABLE DATA; Schema: public; Owner: mgxadm
--

COPY term (id, cat_id, parent_id, name, description) FROM stdin;
1	1	\N	Roche/454 GS 20	\N
2	1	\N	Roche/454 GS FLX	\N
3	1	\N	Roche/454 GS FLX Titanium	\N
4	1	\N	Roche/454 GS Junior	\N
5	1	\N	Illumina MiSeq	\N
6	1	\N	Illumina GA IIx	\N
7	1	\N	Illumina HiSeq 2000/1000	\N
8	1	\N	Illumina HiSeq 2500/1500	\N
9	1	\N	IonTorrent PGM	\N
10	1	\N	IonTorrent Proton	\N
15	1	\N	Illumina NextSeq 500	\N
12	2	\N	Whole-Genome Shotgun	\N
13	2	\N	Paired-End	\N
14	2	\N	Mate-Pair	\N
\.


--
-- Name: term_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mgxadm
--

SELECT pg_catalog.setval('term_id_seq', 15, true);


--
-- Data for Name: tool; Type: TABLE DATA; Schema: public; Owner: mgxadm
--

COPY tool (id, author, description, name, url, version, xml_file) FROM stdin;
3	Sebastian Jaenicke	Annotate GC content of reads	GC content	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/GC.xml
2	Sebastian Jaenicke	Annotate read length	Read length	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/readlength.xml
4	Sebastian Jaenicke	Classification of 16S rRNA fragments	16S Pipeline	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/rdp_pipeline.xml
5	Sebastian Jaenicke	LCA based on NCBI nt	LCA nt	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/lca_pipeline.xml
6	Sebastian Jaenicke	COG-based functional classification	COG	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/eggnog.xml
21	Sebastian Jaenicke	Discard sequences matching E. coli DH1	E.coli-Filter	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/ecolifilter.xml
22	Sebastian Jaenicke	Discard ribosomal gene fragments (5S, 16S, 23S, tRNA)	rRNA-Discard	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/discard_rRNAs.xml
23	Sebastian Jaenicke	LCA based on NCBI nr	LCA nr	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/lca_nr.xml
24	Sebastian Jaenicke	MvirDB-based virulence analysis	MvirDB	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/mvirdb.xml
11	Sebastian Jaenicke	MetaPhyler taxonomic classification	MetaPhyler	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/metaphyler.xml
12	Sebastian Jaenicke	Metagenomic microbial community profiling using unique clade-specific marker genes	MetaPhlAn	http://huttenhower.sph.harvard.edu/metaphlan	1	/vol/mgx-data/GLOBAL/metaphlan.xml
13	Sebastian Jaenicke	PKS Screen	PKS Screen	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pks.xml
14	Sebastian Jaenicke	MetaCV: a composition-based algorithm to classify metagenomic reads	MetaCV	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/metacv.xml
15	Sebastian Jaenicke	Phage screening vs EBI phage genomes	Phage screening	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/phagescreen.xml
16	Sebastian Jaenicke	Phage protein screening vs EBI phage proteins	Phage protein screening	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/phageprotscreen.xml
17	Sebastian Jaenicke	Plasmid protein screening vs EBI plasmid proteins	Plasmid protein screening	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/plasmidprotscreen.xml
18	Sebastian Jaenicke	EC number annotation based on best-Blast-hit vs. SwissProt database	SwissProt EC numbers	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/ecnumber.xml
19	Sebastian Jaenicke	Fast and accurate taxonomic assignments of metagenomic sequences using MetaBin	MetaBin	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/metabin.xml
20	Sebastian Jaenicke	Discard sequences matching pCC1Fos vector	pCC1Fos-Filter	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/referencefilter.xml
25	Sebastian Jaenicke	PKS/NRPS analysis based on BLAST vs ClusterMine360 database	ClusterMine360	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/clustermine360.xml
26	Sebastian Jaenicke	Bowtie2-based reference mapping	Bowtie2	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/bowtie_refmap.xml
27	Sebastian Jaenicke	Annotate best Blast hit versus user-provided set of AA sequences	BestHit-AA	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/besthit_aa.xml
28	Sebastian Jaenicke	Kraken: ultrafast metagenomic sequence classification using exact alignments	Kraken	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/kraken.xml
29	Sebastian Jaenicke	Annotate best Pfam domain hit	Pfam	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pfam_besthit.xml
30	Sebastian Jaenicke	Annotate best TIGRFAMS domain hit	TIGRFAMS	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/tigrfam_besthit.xml
31	Sebastian Jaenicke	Automated Carbohydrate-active enzyme annotation based on dbCAN	dbCAN	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/dbCAN_besthit.xml
32	Sebastian Jaenicke	Fragment recruitment employing FR-HIT	FR-HIT	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/frhit_refmap.xml
33	Sebastian Jaenicke	Antibiotic resistance gene annotation using best Blast hit vs. ARG-ANNOT database	ARG-ANNOT	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/argannot.xml
34	Sebastian Jaenicke	Antibiotic resistance gene screening using Blast vs CARD (Comprehensive antibiotic resistance database)	CARD	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/card.xml
35	Sebastian Jaenicke	Antibacterial biocide- and metal-resistance gene annotation using best Blast hit vs. BacMet database	BacMet	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/bacmet.xml
36	Sebastian Jaenicke	Antibiotic resistance gene annotation using best Blast hit vs. ARDB database	ARDB	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/ardb.xml
37	Sebastian Jaenicke	Fragment recruitment based on NCBI BLASTN	Blast-Mapping	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/blastn_refmap.xml
38	Burkhard Linke	RDP-based taxonomic assignment for 16S amplicons	16S-Amplicons Bergey	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/rdp_amplicons.xml
\.


--
-- Name: tool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mgxadm
--

SELECT pg_catalog.setval('tool_id_seq', 38, true);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: mgxadm; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: reference_pkey; Type: CONSTRAINT; Schema: public; Owner: mgxadm; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (id);


--
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: mgxadm; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: term_pkey; Type: CONSTRAINT; Schema: public; Owner: mgxadm; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (id);


--
-- Name: region_startstop_idx; Type: INDEX; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE INDEX region_startstop_idx ON region USING btree (reg_start, reg_stop);


--
-- Name: term_unique_idx; Type: INDEX; Schema: public; Owner: mgxadm; Tablespace: 
--

CREATE UNIQUE INDEX term_unique_idx ON term USING btree (name);


--
-- Name: term_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES category(id);


--
-- Name: term_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mgxadm
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES term(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: category; Type: ACL; Schema: public; Owner: mgxadm
--

REVOKE ALL ON TABLE category FROM PUBLIC;
REVOKE ALL ON TABLE category FROM mgxadm;
GRANT ALL ON TABLE category TO mgxadm;
GRANT SELECT ON TABLE category TO mgx_global;


--
-- Name: reference; Type: ACL; Schema: public; Owner: mgxadm
--

REVOKE ALL ON TABLE reference FROM PUBLIC;
REVOKE ALL ON TABLE reference FROM mgxadm;
GRANT ALL ON TABLE reference TO mgxadm;
GRANT SELECT ON TABLE reference TO mgx_global;


--
-- Name: region; Type: ACL; Schema: public; Owner: mgxadm
--

REVOKE ALL ON TABLE region FROM PUBLIC;
REVOKE ALL ON TABLE region FROM mgxadm;
GRANT ALL ON TABLE region TO mgxadm;
GRANT SELECT ON TABLE region TO mgx_global;


--
-- Name: term; Type: ACL; Schema: public; Owner: mgxadm
--

REVOKE ALL ON TABLE term FROM PUBLIC;
REVOKE ALL ON TABLE term FROM mgxadm;
GRANT ALL ON TABLE term TO mgxadm;
GRANT SELECT ON TABLE term TO mgx_global;


--
-- Name: tool; Type: ACL; Schema: public; Owner: mgxadm
--

REVOKE ALL ON TABLE tool FROM PUBLIC;
REVOKE ALL ON TABLE tool FROM mgxadm;
GRANT ALL ON TABLE tool TO mgxadm;
GRANT SELECT ON TABLE tool TO mgx_global;


--
-- PostgreSQL database dump complete
--

