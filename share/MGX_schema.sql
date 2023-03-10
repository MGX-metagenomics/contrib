--
-- MGX DB schema
--

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;



CREATE TABLE habitat (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) UNIQUE NOT NULL,
    biome character varying(255),
    description text,
    latitude numeric(11,8) NOT NULL,
    longitude numeric(11,8) NOT NULL
);
ALTER TABLE public.habitat OWNER TO mgx_user;
ALTER TABLE public.habitat_id_seq OWNER TO mgx_user;
ALTER SEQUENCE habitat_id_seq OWNED BY habitat.id;



CREATE TABLE sample (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    collectiondate timestamp without time zone,
    material character varying(255) NOT NULL,
    temperature numeric(7,2),
    volume integer,
    volume_unit character varying(255),
    habitat_id bigint NOT NULL REFERENCES habitat(id)
);
ALTER TABLE public.sample OWNER TO mgx_user;
ALTER TABLE public.sample_id_seq OWNER TO mgx_user;
ALTER SEQUENCE sample_id_seq OWNED BY sample.id;



CREATE TABLE dnaextract (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    sample_id bigint NOT NULL REFERENCES sample(id),
    name TEXT NOT NULL,
    description text,
    fiveprimer character varying(255),
    method character varying(255),
    protocol character varying(255),
    targetfragment character varying(255),
    targetgene character varying(255),
    threeprimer character varying(255)
);
ALTER TABLE public.dnaextract OWNER TO mgx_user;
ALTER TABLE public.dnaextract_id_seq OWNER TO mgx_user;
ALTER SEQUENCE dnaextract_id_seq OWNED BY dnaextract.id;



CREATE TABLE seqrun (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    database_accession character varying(255),
    num_sequences bigint NOT NULL,
    sequencing_method bigint NOT NULL,
    sequencing_technology bigint NOT NULL,
    submitted_to_insdc boolean NOT NULL,
    paired boolean NOT NULL,
    dnaextract_id bigint NOT NULL REFERENCES dnaextract(id)
);
ALTER TABLE public.seqrun OWNER TO mgx_user;
ALTER TABLE public.seqrun_id_seq OWNER TO mgx_user;
ALTER SEQUENCE seqrun_id_seq OWNED BY seqrun.id;



CREATE TABLE read (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    length INTEGER,
    seqrun_id bigint NOT NULL REFERENCES seqrun(id),
    discard boolean NOT NULL DEFAULT false
);
ALTER TABLE public.read OWNER TO mgx_user;
ALTER TABLE public.read_id_seq OWNER TO mgx_user;
ALTER SEQUENCE read_id_seq OWNED BY read.id;
CREATE INDEX read_seqrun_name_idx ON read USING btree (seqrun_id, name);
CREATE INDEX read_id_discard_idx ON read USING btree (id, discard);



CREATE TABLE tool (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    author character varying(255) NOT NULL,
    description text NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(512),
    version real NOT NULL,
    scope integer NOT NULL,
    file character varying(255)
);
ALTER TABLE public.tool OWNER TO mgx_user;
ALTER TABLE ONLY tool ADD CONSTRAINT tool_name_key UNIQUE (name, scope, version);




CREATE TABLE attributetype (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(512) NOT NULL,
    structure character(1) NOT NULL,
    value_type character(1) NOT NULL
);
ALTER TABLE public.attributetype OWNER TO mgx_user;
ALTER TABLE public.attributetype_id_seq OWNER TO mgx_user;
ALTER SEQUENCE attributetype_id_seq OWNED BY attributetype.id;

CREATE UNIQUE INDEX attrtype_unique_idx ON attributetype USING btree (name, structure, value_type);


CREATE TABLE assembly (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    reads_assembled BIGINT,
    n50 BIGINT
);
ALTER TABLE public.assembly OWNER TO mgx_user;
ALTER TABLE ONLY assembly ADD CONSTRAINT asmname_key UNIQUE (name);
ALTER TABLE public.assembly_id_seq OWNER TO mgx_user;
ALTER SEQUENCE assembly_id_seq OWNED BY assembly.id;



CREATE TABLE job (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    created_by character varying(64),
    job_state integer,
    startdate timestamp without time zone,
    finishdate timestamp without time zone,
    apikey character varying(255),
    seqruns BIGINT[],
    assembly BIGINT REFERENCES assembly(id),
    tool_id bigint NOT NULL REFERENCES tool(id)
);
ALTER TABLE public.job OWNER TO mgx_user;
ALTER TABLE public.job_id_seq OWNER TO mgx_user;
ALTER SEQUENCE job_id_seq OWNED BY job.id;
-- CREATE INDEX job_seqrun_idx ON job USING btree (seqrun_id);
CREATE INDEX job_tool_idx ON job USING btree (tool_id);
CREATE INDEX job_jobstate_idx ON job USING btree (job_state);


ALTER TABLE public.assembly ADD COLUMN job_id BIGINT NOT NULL REFERENCES job(id);
CREATE INDEX assembly_jobid_idx ON assembly USING btree(job_id);


CREATE TABLE jobparameter (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    job_id bigint NOT NULL REFERENCES job(id),
    node_id bigint NOT NULL,
    param_name character varying(255) NOT NULL,
    param_value character varying(255) NOT NULL,
    user_name character varying(255) NOT NULL,
    user_desc character varying(255) NOT NULL
);
ALTER TABLE public.jobparameter OWNER TO mgx_user;
ALTER TABLE public.jobparameter_id_seq OWNER TO mgx_user;
ALTER SEQUENCE jobparameter_id_seq OWNED BY job.id;
CREATE INDEX jobparameter_jobid_idx ON jobparameter USING btree(job_id);

-- prevent setting of duplicate job parameters
CREATE UNIQUE INDEX jobparameter_unique_idx ON jobparameter USING btree (job_id, node_id, param_name);




CREATE TABLE attribute (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    value character varying(1024) NOT NULL,
    attrtype_id bigint NOT NULL REFERENCES attributetype(id),
    job_id bigint NOT NULL REFERENCES job(id),
    parent_id bigint REFERENCES attribute(id)
);

ALTER TABLE public.attribute OWNER TO mgx_user;
ALTER TABLE public.attribute_id_seq OWNER TO mgx_user;
ALTER SEQUENCE attribute_id_seq OWNED BY attribute.id;
CREATE INDEX attr_attrtype_job_idx ON attribute USING btree (attrtype_id, job_id);
CREATE INDEX attr_job_idx ON attribute USING btree (job_id);
CREATE INDEX attr_parent_idx ON attribute USING btree (parent_id);
CREATE INDEX attr_id_parent_idx ON attribute USING btree (id,parent_id);
CREATE INDEX attr_value_ci_idx ON attribute (upper(value) text_pattern_ops);

CREATE UNIQUE INDEX attribute_unique_idx ON attribute USING btree (attrtype_id, value, job_id, parent_id);



CREATE TABLE attributecount (
    attr_id bigint UNIQUE NOT NULL REFERENCES attribute(id),
    run_id BIGINT NOT NULL REFERENCES seqrun(id),
    cnt bigint CHECK(cnt > 0)
);
ALTER TABLE public.attributecount OWNER TO mgx_user;
CREATE INDEX attrcount_idx ON attributecount USING btree(attr_id, run_id);



CREATE TABLE observation (
    start integer,
    stop integer,
    seq_id bigint NOT NULL REFERENCES read(id),
    attr_id bigint NOT NULL REFERENCES attribute(id)
);
ALTER TABLE public.observation OWNER TO mgx_user;
CREATE INDEX obs_attr_idx ON observation USING btree (attr_id);
CREATE INDEX obs_seq_idx ON observation USING btree (seq_id);


--
-- reference mapping
--
CREATE TABLE reference (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    ref_length integer NOT NULL,
    ref_filePath character varying(255) 
);
ALTER TABLE public.reference OWNER TO mgx_user;
ALTER TABLE public.reference_id_seq OWNER TO mgx_user;
ALTER SEQUENCE reference_id_seq OWNED BY reference.id;
ALTER TABLE ONLY reference ADD CONSTRAINT ref_name_key UNIQUE (name);


CREATE TABLE region (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(10) NOT NULL,
    reg_start integer NOT NULL,
    reg_stop integer NOT NULL,
    ref_id bigint NOT NULL REFERENCES reference(id)
);
ALTER TABLE public.region OWNER TO mgx_user;
ALTER TABLE public.region_id_seq OWNER TO mgx_user;
ALTER SEQUENCE region_id_seq OWNED BY region.id;
CREATE INDEX region_refid_idx ON region USING btree (ref_id);
CREATE INDEX region_startstop_idx ON region USING btree (reg_start, reg_stop);


CREATE TABLE mapping (
   id BIGSERIAL UNIQUE PRIMARY KEY,
   ref_id bigint NOT NULL REFERENCES reference(id),
   run_id bigint NOT NULL REFERENCES seqrun(id),
   job_id bigint NOT NULL REFERENCES job(id),
   bam_file character varying(255) NOT NULL
);
ALTER TABLE public.mapping OWNER TO mgx_user;
ALTER TABLE public.mapping_id_seq OWNER TO mgx_user;
ALTER SEQUENCE mapping_id_seq OWNED BY mapping.id;
CREATE UNIQUE INDEX mapping_unique_idx ON mapping USING btree (run_id, ref_id, job_id);


CREATE TABLE bin (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    completeness REAL,
    contamination REAL,
    taxonomy character varying,
    n50 BIGINT,
    predicted_cds INTEGER,
    num_contigs INTEGER,
    total_bp BIGINT,
    assembly_id BIGINT REFERENCES assembly(id)
);
ALTER TABLE public.bin OWNER TO mgx_user;
ALTER TABLE public.bin_id_seq OWNER TO mgx_user;
ALTER SEQUENCE bin_id_seq OWNED BY bin.id;
CREATE INDEX bin_assemblyid_idx ON bin USING btree(assembly_id);


CREATE TABLE contig (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    name character varying(255) NOT NULL,
    gc FLOAT,
    length_bp INTEGER,
    coverage INTEGER,
    bin_id BIGINT REFERENCES bin(id)
);
ALTER TABLE public.contig OWNER TO mgx_user;
ALTER TABLE public.contig_id_seq OWNER TO mgx_user;
ALTER SEQUENCE contig_id_seq OWNED BY contig.id;
CREATE INDEX contig_binid_idx ON contig USING btree(bin_id);


CREATE TABLE gene (
    id BIGSERIAL UNIQUE PRIMARY KEY,
    start INTEGER,
    stop INTEGER,
    type character varying(10) NOT NULL,
    coverage INTEGER,
    contig_id BIGINT REFERENCES contig(id)
);
ALTER TABLE public.gene OWNER TO mgx_user;
ALTER TABLE public.gene_id_seq OWNER TO mgx_user;
ALTER SEQUENCE gene_id_seq OWNED BY gene.id;
CREATE INDEX gene_contigid_idx ON gene USING btree(contig_id);



CREATE TABLE gene_coverage (
    run_id BIGINT REFERENCES seqrun(id),
    gene_id BIGINT REFERENCES gene(id),
    coverage INTEGER
);
ALTER TABLE public.gene_coverage OWNER TO mgx_user;
CREATE INDEX genecov_geneid_runid_idx ON gene_coverage USING btree(gene_id, run_id);



CREATE TABLE gene_observation (
    start integer,
    stop integer,
    gene_id bigint NOT NULL REFERENCES gene(id),
    attr_id bigint NOT NULL REFERENCES attribute(id)
);
ALTER TABLE public.gene_observation OWNER TO mgx_user;
CREATE INDEX geneobs_attr_idx ON gene_observation USING btree (attr_id);
CREATE INDEX geneobs_gene_idx ON gene_observation USING btree (gene_id);




REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- function declarations 
--
DROP FUNCTION IF EXISTS getDistribution(attrtype bigint, job bigint, seqrun bigint);
CREATE OR REPLACE FUNCTION getDistribution(attrtype bigint, job bigint, seqrun bigint)
    RETURNS TABLE(attr_id bigint, attr_value text, count bigint, attr_parent bigint)
    AS $$
        SELECT attr.id as attr_id, attr.value as attr_value, attrcount.cnt as count, attr.parent_id as attr_parent
            FROM attribute attr
            LEFT JOIN attributetype atype ON (attr.attrtype_id = atype.id)
            LEFT JOIN attributecount attrcount ON (attr.id = attrcount.attr_id)
            LEFT JOIN job j ON (attr.job_id=j.id)
            WHERE attr.attrtype_id=$1
            AND attr.job_id=$2
            AND attrcount.run_id=$3
            AND j.job_state=5
$$ LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;


DROP FUNCTION IF EXISTS getFilteredDistribution(attrtype bigint, job bigint, filterattr bigint);
CREATE OR REPLACE FUNCTION getFilteredDistribution(attrtype bigint, job bigint, filterattr bigint)
   RETURNS TABLE(attrid bigint, attr_value text, count bigint, attr_parent bigint)
   LANGUAGE PLPGSQL VOLATILE 
   AS $$
   BEGIN
       CREATE TEMPORARY TABLE temp_tbl (attr_id bigint, value text, parent_id bigint, attrtype_id bigint) ON COMMIT DROP; /* gsh #158005 */
       INSERT INTO temp_tbl SELECT attr_id, value, parent_id, attrtype_id FROM (SELECT * FROM (SELECT r.seq_id, o.* FROM observation r, observation o WHERE r.seq_id = o.seq_id AND r.attr_id=$3) o, attribute a, job j WHERE o.attr_id=a.id AND a.job_id=j.id AND j.job_state=5 AND a.job_id=$2) t; /* gsh #158005 */

       RETURN query SELECT attr_id, value, count(value), parent_id FROM temp_tbl WHERE attrtype_id=$1 GROUP BY attr_id, value, parent_id ORDER BY attr_id; /* gsh #158005 */
   END
$$ RETURNS NULL ON NULL INPUT SECURITY INVOKER;



DROP FUNCTION IF EXISTS getHierarchy(attrtype bigint, job bigint, seqrun bigint);
CREATE OR REPLACE FUNCTION getHierarchy(attrtype bigint, job bigint, seqrun bigint)
    RETURNS TABLE(attrtype_id bigint, attrtype_name text, atype_structure character(1), attrtype_valtype character(1), attr_id bigint, attr_value text, parent_id bigint, count bigint)
    AS $$
        WITH RECURSIVE subattributes AS (
            WITH attributecounts AS (
                SELECT attr.attrtype_id as attrtype_id, atype.name as attrtype_name,
                    atype.structure as atype_structure, atype.value_type as attrtype_valtype,
                    attr.id as attr_id, attr.value as attr_value, attr.parent_id as parent_id, attrcount.cnt as count
                FROM attribute attr
                LEFT JOIN attributetype atype ON (attr.attrtype_id = atype.id)
                LEFT JOIN attributecount attrcount ON (attr.id = attrcount.attr_id)
                WHERE attr.job_id=$2
                AND attrcount.run_id=$3
            )
            SELECT * FROM attributecounts WHERE attr_id=(
                WITH RECURSIVE findroot AS (
                    WITH hierarchy AS (
                        SELECT attr.attrtype_id AS attrtype_id, attr.id AS attr_id, attr.parent_id AS parent_id
                        FROM attribute attr
                        LEFT JOIN attributetype atype ON (attr.attrtype_id = atype.id)
                        WHERE attr.job_id=$2
                    )
                    SELECT * FROM hierarchy WHERE attrtype_id=$1
                    UNION
                    SELECT parent.* FROM hierarchy AS parent
                    JOIN findroot AS fr ON (fr.parent_id = parent.attr_id)
                )
                SELECT attr_id FROM findroot WHERE parent_id IS NULL
            )
            UNION
            SELECT temp.* FROM attributecounts AS temp
            JOIN subattributes AS sa ON (sa.attr_id = temp.parent_id)
        )
        SELECT attrtype_id, attrtype_name, atype_structure, attrtype_valtype,
            attr_id, attr_value, parent_id, count FROM subattributes
$$ LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;



DROP FUNCTION IF EXISTS getCorrelation(job1 bigint, attrtype1 bigint, job2 bigint, attrtype2 bigint);
CREATE OR REPLACE FUNCTION getCorrelation(job1 bigint, attrtype1 bigint, job2 bigint, attrtype2 bigint)
    RETURNS TABLE(attr_id1 bigint, attr_value1 text, attr_id2 bigint, attr_value2 text, count bigint)
    AS $$
        WITH firstannotation AS (
            SELECT read.id AS read_id,
            attr.id AS attr_id, attr.value AS attr_value
            FROM read
            LEFT JOIN observation ON (read.id = observation.seq_id)
            LEFT JOIN attribute attr ON (observation.attr_id = attr.id)
            LEFT JOIN attributetype atype ON (attr.attrtype_id = atype.id)
            WHERE attr.job_id=$1 AND attr.attrtype_id=$2
        )
        SELECT first.attr_id AS attr_id1, first.attr_value AS attr_value1,
        attr.id AS attr_id2, attr.value AS attr_value2, COUNT(attr.value) as count
        FROM firstannotation first
        LEFT JOIN observation obs ON (first.read_id = obs.seq_id)
        LEFT JOIN attribute attr ON (obs.attr_id = attr.id)
        LEFT JOIN attributetype atype ON (attr.attrtype_id = atype.id)
        WHERE attr.job_id=$3 AND attr.attrtype_id=$4
        GROUP BY first.attr_id, first.attr_value,
                 attr.id, attr.value
        ORDER BY first.attr_value, attr.value
$$ LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;


DROP FUNCTION IF EXISTS getObservations(seqId BIGINT);
CREATE OR REPLACE FUNCTION getObservations(seqId BIGINT)
    RETURNS TABLE(obs_start INTEGER, obs_stop INTEGER,
                  attr_value TEXT, atype_name TEXT)
    AS $$
        SELECT o.start AS obs_start, o.stop AS obs_stop,
               attr.value AS attr_value, atype.name as atype_name
        FROM observation o
        JOIN attribute attr ON (o.attr_id = attr.id)
        JOIN attributetype atype ON (attr.attrtype_id = atype.id)
        JOIN job ON (attr.job_id = job.id)
        WHERE job.job_state=5 AND o.seq_id=$1
$$ LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;


DROP FUNCTION IF EXISTS getGeneObservations(geneId BIGINT);
CREATE OR REPLACE FUNCTION getGeneObservations(geneId BIGINT)
    RETURNS TABLE(obs_start INTEGER, obs_stop INTEGER,
                  attr_value TEXT, atype_name TEXT)
    AS $$
        SELECT o.start AS obs_start, o.stop AS obs_stop,
               attr.value AS attr_value, atype.name as atype_name
        FROM gene_observation o
        JOIN attribute attr ON (o.attr_id = attr.id)
        JOIN attributetype atype ON (attr.attrtype_id = atype.id)
        JOIN job ON (attr.job_id = job.id)
        WHERE job.job_state=5 AND o.gene_id=$1
$$ LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;



DROP FUNCTION IF EXISTS getRegions(refId BIGINT, fromPos INTEGER, toPos INTEGER);
CREATE OR REPLACE FUNCTION getRegions(refId BIGINT, fromPos INTEGER, toPos INTEGER)
    RETURNS TABLE(id BIGINT, name TEXT, type TEXT, description TEXT, reg_start INTEGER,
                  reg_stop INTEGER, ref_id BIGINT)
    AS $$
      SELECT id, name, type, description, reg_start, reg_stop, ref_id FROM region
        WHERE ref_id=$1 AND (reg_start BETWEEN $2 AND $3 OR reg_stop BETWEEN $2 AND $3)
      UNION
      SELECT id, name, type, description, reg_start, reg_stop, ref_id FROM region
        WHERE ref_id=$1 AND ((reg_start < $2 AND reg_stop > $3)
         OR (reg_stop < $2 AND reg_start > $3))
$$ LANGUAGE SQL STABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;


--
-- rights and roles - not yet handled within GPMS
--
GRANT CONNECT ON DATABASE @DBNAME@ TO mgx_guest;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO mgx_guest;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO mgx_guest;

-- GRANT CONNECT ON DATABASE @DBNAME@ TO mgx_annotator;
-- GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO mgx_annotator;
-- GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO mgx_annotator;

GRANT CONNECT ON DATABASE @DBNAME@ TO mgx_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO mgx_user;
GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO mgx_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO mgx_admin;
GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO mgx_admin;

--
-- EOF
-- 
