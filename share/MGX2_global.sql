--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.2 (Ubuntu 15.2-1.pgdg20.04+1)

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
-- Name: category; Type: TABLE; Schema: public; Owner: gpmsroot
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO gpmsroot;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: gpmsroot
--

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO gpmsroot;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpmsroot
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: reference; Type: TABLE; Schema: public; Owner: gpmsroot
--

CREATE TABLE public.reference (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    ref_length integer NOT NULL,
    ref_filepath character varying(255) NOT NULL
);


ALTER TABLE public.reference OWNER TO gpmsroot;

--
-- Name: reference_id_seq; Type: SEQUENCE; Schema: public; Owner: gpmsroot
--

CREATE SEQUENCE public.reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_id_seq OWNER TO gpmsroot;

--
-- Name: reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpmsroot
--

ALTER SEQUENCE public.reference_id_seq OWNED BY public.reference.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: gpmsroot
--

CREATE TABLE public.region (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(32) NOT NULL,
    reg_start integer NOT NULL,
    reg_stop integer NOT NULL,
    ref_id bigint NOT NULL
);


ALTER TABLE public.region OWNER TO gpmsroot;

--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: gpmsroot
--

CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO gpmsroot;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpmsroot
--

ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;


--
-- Name: term; Type: TABLE; Schema: public; Owner: gpmsroot
--

CREATE TABLE public.term (
    id integer NOT NULL,
    cat_id bigint NOT NULL,
    parent_id bigint,
    name character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.term OWNER TO gpmsroot;

--
-- Name: term_id_seq; Type: SEQUENCE; Schema: public; Owner: gpmsroot
--

CREATE SEQUENCE public.term_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_id_seq OWNER TO gpmsroot;

--
-- Name: term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpmsroot
--

ALTER SEQUENCE public.term_id_seq OWNED BY public.term.id;


--
-- Name: tool; Type: TABLE; Schema: public; Owner: gpmsroot
--

CREATE TABLE public.tool (
    id bigint NOT NULL,
    author character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255),
    version real NOT NULL,
    file character varying(255) NOT NULL,
    scope integer
);


ALTER TABLE public.tool OWNER TO gpmsroot;

--
-- Name: tool_id_seq; Type: SEQUENCE; Schema: public; Owner: gpmsroot
--

CREATE SEQUENCE public.tool_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tool_id_seq OWNER TO gpmsroot;

--
-- Name: tool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gpmsroot
--

ALTER SEQUENCE public.tool_id_seq OWNED BY public.tool.id;


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: reference id; Type: DEFAULT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.reference ALTER COLUMN id SET DEFAULT nextval('public.reference_id_seq'::regclass);


--
-- Name: region id; Type: DEFAULT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);


--
-- Name: term id; Type: DEFAULT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.term ALTER COLUMN id SET DEFAULT nextval('public.term_id_seq'::regclass);


--
-- Name: tool id; Type: DEFAULT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.tool ALTER COLUMN id SET DEFAULT nextval('public.tool_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: gpmsroot
--

COPY public.category (id, name) FROM stdin;
1	seq_platforms
2	seq_methods
3	volume_units
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: public; Owner: gpmsroot
--

COPY public.term (id, cat_id, parent_id, name, description) FROM stdin;
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
16	1	\N	Illumina MiniSeq	\N
17	1	\N	Illumina NovaSeq 5000/6000	\N
18	1	\N	Illumina NextSeq 550/1000/2000	\N
19	1	\N	PacBio Revio/Sequel	\N
20	1	\N	PacBio Onso	\N
21	1	\N	ONT MinION/GridION/PromethION	\N
\.


--
-- Data for Name: tool; Type: TABLE DATA; Schema: public; Owner: gpmsroot
--

COPY public.tool (id, author, description, name, url, version, file, scope) FROM stdin;
5	Sebastian Jaenicke	LCA based on NCBI nt	LCA nt	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/lca_pipeline.xml	0
6	Sebastian Jaenicke	COG-based functional classification	COG	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/eggnog.xml	0
23	Sebastian Jaenicke	LCA based on NCBI nr	LCA nr	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/lca_nr.xml	0
24	Sebastian Jaenicke	MvirDB-based virulence analysis	MvirDB	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/mvirdb.xml	0
13	Sebastian Jaenicke	PKS Screen	PKS Screen	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pks.xml	0
15	Sebastian Jaenicke	Phage screening vs EBI phage genomes	Phage screening	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/phagescreen.xml	0
16	Sebastian Jaenicke	Phage protein screening vs EBI phage proteins	Phage protein screening	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/phageprotscreen.xml	0
17	Sebastian Jaenicke	Plasmid protein screening vs EBI plasmid proteins	Plasmid protein screening	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/plasmidprotscreen.xml	0
18	Sebastian Jaenicke	EC number annotation based on best-Blast-hit vs. SwissProt database	SwissProt EC numbers	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/ecnumber.xml	0
25	Sebastian Jaenicke	PKS/NRPS analysis based on BLAST vs ClusterMine360 database	ClusterMine360	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/clustermine360.xml	0
26	Sebastian Jaenicke	Bowtie2-based reference mapping	Bowtie2	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/bowtie_refmap.xml	0
27	Sebastian Jaenicke	Annotate best Blast hit versus user-provided set of AA sequences	BestHit-AA	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/besthit_aa.xml	0
28	Sebastian Jaenicke	Kraken: ultrafast metagenomic sequence classification using exact alignments	Kraken	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/kraken.xml	0
29	Sebastian Jaenicke	Annotate best Pfam domain hit	Pfam	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pfam_besthit.xml	0
30	Sebastian Jaenicke	Annotate best TIGRFAMS domain hit	TIGRFAMS	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/tigrfam_besthit.xml	0
31	Sebastian Jaenicke	Automated Carbohydrate-active enzyme annotation based on dbCAN	dbCAN	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/dbCAN_besthit.xml	0
32	Sebastian Jaenicke	Fragment recruitment employing FR-HIT	FR-HIT	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/frhit_refmap.xml	0
33	Sebastian Jaenicke	Antibiotic resistance gene annotation using best Blast hit vs. ARG-ANNOT database	ARG-ANNOT	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/argannot.xml	0
34	Sebastian Jaenicke	Antibiotic resistance gene screening using Blast vs CARD (Comprehensive antibiotic resistance database)	CARD	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/card.xml	0
35	Sebastian Jaenicke	Antibacterial biocide- and metal-resistance gene annotation using best Blast hit vs. BacMet database	BacMet	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/bacmet.xml	0
36	Sebastian Jaenicke	Antibiotic resistance gene annotation using best Blast hit vs. ARDB database	ARDB	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/ardb.xml	0
38	Burkhard Linke	RDP-based taxonomic assignment for 16S amplicons	16S-Amplicons Bergey	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/rdp_amplicons.xml	0
39	Sebastian Jaenicke	Kaiju: Fast and sensitive taxonomic classification for metagenomics	Kaiju	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/kaiju.xml	0
43	Sebastian Jaenicke	Centrifuge: rapid and sensitive classification of metagenomic sequences	Centrifuge	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/centrifuge.xml	0
44	Sebastian Jaenicke	HMM search vs. FunGene functional genes	FunGene HMM search	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/fungene.xml	0
57	Sebastian Jaenicke	Automated Carbohydrate-active enzyme annotation based on dbCAN	dbCAN	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_dbcan.xml	2
58	Sebastian Jaenicke	HMM search vs. FunGene functional genes	FunGene HMM search	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_fungene.xml	2
61	Sebastian Jaenicke	PKS Screen	PKS Screen	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_pks.xml	2
62	Sebastian Jaenicke	Antimicrobial resistance gene detection	AMRFinder+	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_amrfinder.xml	2
63	Sebastian Jaenicke	COG annotation	EggNOG	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_eggnog.xml	2
59	Sebastian Jaenicke	Kaiju: Fast and sensitive taxonomic classification for metagenomics	Kaiju	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_kaiju.xml	2
37	Sebastian Jaenicke	Fragment recruitment based on NCBI Magic-BLAST	Blast-Mapping	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/blastn_refmap.xml	0
46	Sebastian Jaenicke	MGX default taxonomic classification based on Kraken and Diamond vs. RefSeq proteins	MGX taxonomic classification	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/mgx_default_taxonomy.xml	0
47	Sebastian Jaenicke	Kraken 2 taxonomic assignment	Kraken 2	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/kraken2.xml	0
48	Sebastian Jaenicke	Discard host contamination based on public reference genome index	Discard-Public-Host	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/discard_public.xml	0
4	Sebastian Jaenicke	Classification of 16S rRNA fragments within metagenomes	16S Pipeline	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/rdp_pipeline.xml	0
49	Sebastian Jaenicke	Metagenome assembly, quantification and gene prediction	Metagenome Assembly	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/cwl/metagenome-assembly-pipeline.cwl	0
64	Sebastian Jaenicke	HMM search vs. NCBI PGAP models	PGAP	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/pgap.xml	0
66	Sebastian Jaenicke	MetaPhlAn 4 marker-based taxonomic classification	MetaPhlAn 4	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/metaphlan4.xml	0
50	Sebastian Jaenicke	Taxonomic classification of predicted genes using Kraken 2	Kraken 2	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_kraken2.xml	2
52	Sebastian Jaenicke	MvirDB-based virulence analysis	MvirDB	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_mvirdb.xml	2
53	Sebastian Jaenicke	Pfam protein domain annotation	Pfam	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_pfam.xml	2
56	Sebastian Jaenicke	PKS/NRPS analysis based on homology search vs the ClusterMine360 database	ClusterMine360	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_clustermine360.xml	2
55	Sebastian Jaenicke	TIGRFAMS protein domain annotation	TIGRFAMS	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_tigrfam.xml	2
60	Sebastian Jaenicke	Centrifuge: rapid and sensitive classification of metagenomic sequences	Centrifuge	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_centrifuge.xml	2
65	Sebastian Jaenicke	HMM search vs. NCBI PGAP models	PGAP	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_pgap.xml	2
51	Sebastian Jaenicke	EC number classification of predicted genes	SwissProt EC numbers	http://127.0.0.1/	1	/vol/mgx-data/GLOBAL/pipelines/mgxgene_ecnumber.xml	2
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gpmsroot
--

SELECT pg_catalog.setval('public.category_id_seq', 3, true);


--
-- Name: reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gpmsroot
--

SELECT pg_catalog.setval('public.reference_id_seq', 5899, true);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gpmsroot
--

SELECT pg_catalog.setval('public.region_id_seq', 19759169, true);


--
-- Name: term_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gpmsroot
--

SELECT pg_catalog.setval('public.term_id_seq', 21, true);


--
-- Name: tool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gpmsroot
--

SELECT pg_catalog.setval('public.tool_id_seq', 98, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: reference reference_pkey; Type: CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.reference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.term
    ADD CONSTRAINT term_pkey PRIMARY KEY (id);


--
-- Name: term_unique_idx; Type: INDEX; Schema: public; Owner: gpmsroot
--

CREATE UNIQUE INDEX term_unique_idx ON public.term USING btree (name);


--
-- Name: region region_ref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_ref_id_fkey FOREIGN KEY (ref_id) REFERENCES public.reference(id);


--
-- Name: term term_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.term
    ADD CONSTRAINT term_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES public.category(id);


--
-- Name: term term_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gpmsroot
--

ALTER TABLE ONLY public.term
    ADD CONSTRAINT term_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.term(id);


--
-- Name: TABLE category; Type: ACL; Schema: public; Owner: gpmsroot
--

GRANT SELECT ON TABLE public.category TO mgx_global;


--
-- Name: TABLE reference; Type: ACL; Schema: public; Owner: gpmsroot
--

GRANT SELECT ON TABLE public.reference TO mgx_global;


--
-- Name: TABLE region; Type: ACL; Schema: public; Owner: gpmsroot
--

GRANT SELECT ON TABLE public.region TO mgx_global;


--
-- Name: TABLE term; Type: ACL; Schema: public; Owner: gpmsroot
--

GRANT SELECT ON TABLE public.term TO mgx_global;


--
-- Name: TABLE tool; Type: ACL; Schema: public; Owner: gpmsroot
--

GRANT SELECT ON TABLE public.tool TO mgx_global;


--
-- PostgreSQL database dump complete
--

