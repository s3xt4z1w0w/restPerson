--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Debian 14.11-1.pgdg120+2)
-- Dumped by pg_dump version 15.3

-- Started on 2024-06-08 01:14:18

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 228 (class 1255 OID 16491)
-- Name: update_city(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_city() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE update_log
SET last_updated = CURRENT_TIMESTAMP
WHERE table_name = 'city';
RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_city() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16489)
-- Name: update_university(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_university() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE update_log
SET last_updated = CURRENT_TIMESTAMP
WHERE table_name = 'university';
RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_university() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16393)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    name character varying(255) NOT NULL,
    country_id integer
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16392)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_city_id_seq OWNER TO postgres;

--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 211
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- TOC entry 220 (class 1259 OID 16445)
-- Name: cost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cost (
    cost_id integer NOT NULL,
    program_id integer NOT NULL,
    tuition numeric(10,2) NOT NULL,
    dormitory_cost numeric(10,2),
    registration_fee numeric(10,2),
    insurance_cost numeric(10,2),
    medical_examination_cost numeric(10,2),
    literature_cost numeric(10,2),
    additional_costs numeric(10,2),
    accommodation_min numeric(10,2),
    accommodation_max numeric(10,2),
    living_expenses_min numeric(10,2),
    living_expenses_max numeric(10,2),
    deposit numeric(10,2)
);


ALTER TABLE public.cost OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16444)
-- Name: cost_cost_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cost_cost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cost_cost_id_seq OWNER TO postgres;

--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 219
-- Name: cost_cost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cost_cost_id_seq OWNED BY public.cost.cost_id;


--
-- TOC entry 210 (class 1259 OID 16386)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    country_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_country_id_seq OWNER TO postgres;

--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 209
-- Name: country_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_country_id_seq OWNED BY public.country.country_id;


--
-- TOC entry 216 (class 1259 OID 16417)
-- Name: program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program (
    program_id integer NOT NULL,
    university_id integer NOT NULL,
    name character varying(255),
    degree character varying(255) NOT NULL,
    language character varying(255) NOT NULL,
    start_date date NOT NULL,
    duration character varying(255) NOT NULL,
    speciality character varying(255)
);


ALTER TABLE public.program OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16416)
-- Name: program_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_program_id_seq OWNER TO postgres;

--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 215
-- Name: program_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_program_id_seq OWNED BY public.program.program_id;


--
-- TOC entry 222 (class 1259 OID 16457)
-- Name: requirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requirement (
    requirement_id integer NOT NULL,
    program_id integer NOT NULL,
    hsk character varying(255),
    ielts character varying(255),
    gpa numeric(3,2),
    documents text
);


ALTER TABLE public.requirement OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16456)
-- Name: requirement_requirement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requirement_requirement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requirement_requirement_id_seq OWNER TO postgres;

--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 221
-- Name: requirement_requirement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requirement_requirement_id_seq OWNED BY public.requirement.requirement_id;


--
-- TOC entry 218 (class 1259 OID 16431)
-- Name: scholarship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship (
    scholarship_id integer NOT NULL,
    program_id integer NOT NULL,
    type character varying(255) NOT NULL,
    coverage character varying(255),
    amount character varying(255),
    deadline date,
    comments text,
    isaccommodation boolean DEFAULT false,
    islivingexpense boolean DEFAULT false
);


ALTER TABLE public.scholarship OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16430)
-- Name: scholarship_scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarship_scholarship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scholarship_scholarship_id_seq OWNER TO postgres;

--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 217
-- Name: scholarship_scholarship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarship_scholarship_id_seq OWNED BY public.scholarship.scholarship_id;


--
-- TOC entry 224 (class 1259 OID 16471)
-- Name: translation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.translation (
    translation_id integer NOT NULL,
    table_name character varying(255) NOT NULL,
    column_name character varying(255) NOT NULL,
    foreign_key integer NOT NULL,
    language_code character(2) NOT NULL,
    text text NOT NULL
);


ALTER TABLE public.translation OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16470)
-- Name: translation_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.translation_translation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.translation_translation_id_seq OWNER TO postgres;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 223
-- Name: translation_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.translation_translation_id_seq OWNED BY public.translation.translation_id;


--
-- TOC entry 214 (class 1259 OID 16405)
-- Name: university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university (
    university_id integer NOT NULL,
    name character varying(255) NOT NULL,
    city_id integer,
    abbreviation character varying(10)
);


ALTER TABLE public.university OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16404)
-- Name: university_university_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.university_university_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.university_university_id_seq OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 213
-- Name: university_university_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.university_university_id_seq OWNED BY public.university.university_id;


--
-- TOC entry 226 (class 1259 OID 16482)
-- Name: update_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.update_log (
    id integer NOT NULL,
    table_name character varying(255),
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.update_log OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16481)
-- Name: update_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.update_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.update_log_id_seq OWNER TO postgres;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 225
-- Name: update_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.update_log_id_seq OWNED BY public.update_log.id;


--
-- TOC entry 3233 (class 2604 OID 16396)
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- TOC entry 3239 (class 2604 OID 16448)
-- Name: cost cost_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost ALTER COLUMN cost_id SET DEFAULT nextval('public.cost_cost_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 16389)
-- Name: country country_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN country_id SET DEFAULT nextval('public.country_country_id_seq'::regclass);


--
-- TOC entry 3235 (class 2604 OID 16420)
-- Name: program program_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program ALTER COLUMN program_id SET DEFAULT nextval('public.program_program_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 16460)
-- Name: requirement requirement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requirement ALTER COLUMN requirement_id SET DEFAULT nextval('public.requirement_requirement_id_seq'::regclass);


--
-- TOC entry 3236 (class 2604 OID 16434)
-- Name: scholarship scholarship_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship ALTER COLUMN scholarship_id SET DEFAULT nextval('public.scholarship_scholarship_id_seq'::regclass);


--
-- TOC entry 3241 (class 2604 OID 16474)
-- Name: translation translation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation ALTER COLUMN translation_id SET DEFAULT nextval('public.translation_translation_id_seq'::regclass);


--
-- TOC entry 3234 (class 2604 OID 16408)
-- Name: university university_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university ALTER COLUMN university_id SET DEFAULT nextval('public.university_university_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 16485)
-- Name: update_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update_log ALTER COLUMN id SET DEFAULT nextval('public.update_log_id_seq'::regclass);


--
-- TOC entry 3414 (class 0 OID 16393)
-- Dependencies: 212
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city_id, name, country_id) FROM stdin;
2	Hefei	2
3	Beijing	2
4	Changde	2
5	Xuzhou	2
6	Changchun	2
7	Hangzhou	2
8	Nanchong	2
9	Changsha	2
10	Dalian	2
11	Shanghai	2
12	Fuyang	2
13	Fuzhou	2
14	Guilin	2
15	Lanzhou	2
16	Nanning	2
1	Almaty	1
\.


--
-- TOC entry 3422 (class 0 OID 16445)
-- Dependencies: 220
-- Data for Name: cost; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cost (cost_id, program_id, tuition, dormitory_cost, registration_fee, insurance_cost, medical_examination_cost, literature_cost, additional_costs, accommodation_min, accommodation_max, living_expenses_min, living_expenses_max, deposit) FROM stdin;
1	3	22000.00	1500.00	400.00	800.00	500.00	400.00	\N	300.00	2600.00	0.00	2000.00	\N
2	3	0.00	1500.00	400.00	800.00	500.00	400.00	\N	300.00	2600.00	0.00	2000.00	\N
3	4	22000.00	5760.00	600.00	800.00	\N	550.00	\N	300.00	2600.00	0.00	2000.00	\N
4	5	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
5	6	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
6	7	24800.00	1800.00	500.00	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
7	8	35000.00	1800.00	600.00	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
8	10	0.00	\N	600.00	\N	200.00	400.00	\N	300.00	2600.00	0.00	2000.00	\N
9	11	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
10	12	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
11	13	17000.00	1500.00	400.00	600.00	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
12	14	17000.00	1500.00	400.00	600.00	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
13	15	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
14	16	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
15	17	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
16	18	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
17	19	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
18	20	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
19	21	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
20	22	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
23	25	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
24	26	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
25	27	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
26	28	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
27	29	0.00	\N	\N	\N	\N	\N	\N	300.00	2600.00	0.00	2000.00	\N
21	23	15000.00	1500.00	400.00	\N	\N	\N	500.00	300.00	2600.00	0.00	2000.00	\N
22	24	16000.00	1600.00	500.00	800.00	500.00	500.00	600.00	300.00	2600.00	0.00	2000.00	2000.00
\.


--
-- TOC entry 3412 (class 0 OID 16386)
-- Dependencies: 210
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (country_id, name) FROM stdin;
1	Kazakhstan
2	China
\.


--
-- TOC entry 3418 (class 0 OID 16417)
-- Dependencies: 216
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program (program_id, university_id, name, degree, language, start_date, duration, speciality) FROM stdin;
3	1	Mechanical Engineering	Undergraduate	Chinese	2023-09-01	4 years	\N
4	2	Integrated Cicuit Science and Engineering	Master	Chinese	2023-09-01	3 years	\N
5	2	Management Science and Engineering	Undergraduate	Chinese	2023-09-01	4 years	\N
6	3	Materials Science and Engineering	Undergraduate	Chinese	2023-09-01	4 years	\N
7	4	Aeronautical and Astronautical Science and Technology	Master	English	2023-09-01	3 years	\N
8	4	Mechanical Engineering	Undergraduate	Chinese	2023-09-01	4 years	\N
9	5	Integrated Cicuit Science and Engineering	Master	English	2023-09-01	3 years	\N
10	6	Management Science and Engineering	Specialist	Chinese	2023-09-01	3 years	\N
12	7	Aeronautical and Astronautical Science and Technology	Undergraduate	Chinese	2023-09-01	4 years	\N
13	8	Mechanical Engineering	PhD	Chinese	2023-09-01	4 years	\N
14	8	Integrated Cicuit Science and Engineering	Master	English	2023-09-01	3 years	\N
15	9	Aeronautical and Astronautical Science and Technology	Undergraduate	Chinese	2023-09-01	4 years	\N
16	10	Materials Science and Engineering	Master	English	2023-09-01	4 years	\N
17	11	Mechanical Engineering	Master	English	2023-09-01	3 years	\N
18	12	Integrated Cicuit Science and Engineering	Master	Chinese	2023-09-01	3 years	\N
19	13	Management Science and Engineering	Master	English	2023-09-01	3 years	\N
20	13	Materials Science and Engineering	Non-academic qualification	Chinese	2023-09-01	1 years	\N
21	14	Aeronautical and Astronautical Science and Technology	Master	English	2023-09-01	4 years	\N
22	14	Mechanical Engineering	Undergraduate	Chinese	2023-09-01	4 years	\N
23	15	Integrated Cicuit Science and Engineering	Undergraduate	English	2023-09-01	4 years	\N
24	16	Management Science and Engineering	Undergraduate	Chinese	2023-09-01	4 years	\N
25	17	Materials Science and Engineering	Master	English	2023-09-01	3 years	\N
26	17	Aeronautical and Astronautical Science and Technology	Undergraduate	Chinese	2023-09-01	4 years	\N
27	18	Mechanical Engineering	Specialist	Chinese	2023-09-01	3 years	\N
28	19	Integrated Cicuit Science and Engineering	Undergraduate	Chinese	2023-09-01	4-5 years	\N
29	19	Management Science and Engineering	Master	Chinese	2023-09-01	3 years	\N
11	6	Management Science and Engineering	Non-academic qualification	English	2023-09-01	1 years	\N
\.


--
-- TOC entry 3424 (class 0 OID 16457)
-- Dependencies: 222
-- Data for Name: requirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requirement (requirement_id, program_id, hsk, ielts, gpa, documents) FROM stdin;
\.


--
-- TOC entry 3420 (class 0 OID 16431)
-- Dependencies: 218
-- Data for Name: scholarship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarship (scholarship_id, program_id, type, coverage, amount, deadline, comments, isaccommodation, islivingexpense) FROM stdin;
1	3	school award	\N	To be determined	2024-05-08	\N	f	f
3	4	school award	\N	none	2024-06-30	\N	f	f
4	5	school award	\N	none	2024-06-30	\N	f	f
5	6	City Award	\N	none	2024-05-31	\N	f	f
6	7	National Award	Living expenses	2,500 yuan/month	2024-06-10	\N	f	t
7	8	National Award	Living expenses	3,000 yuan/month	2024-06-10	\N	f	t
8	10	school award	\N	none	2024-07-31	\N	f	f
9	11	school award	\N	none	2024-07-31	\N	f	f
10	12	International Chinese Teacher Scholarship	Living expenses	2,500 yuan/month	2024-05-15	\N	f	t
12	14	school award	Living expenses	1,000 yuan/month	2024-07-07	\N	f	t
13	15	National Award	Living expenses	2,500 yuan/month	2024-05-10	\N	f	t
15	17	school award	Bursary	500-1,000 yuan	2024-06-30	\N	f	t
16	18	National Award	Living expenses	3,000 yuan/month	2024-05-10	\N	f	t
17	19	National Award	Living expenses	2,500 yuan/month	2024-05-15	\N	f	t
18	20	National Award	\N	\N	2024-04-20	\N	f	f
19	21	International Chinese Teacher Scholarship	Living expenses	2,500 yuan/month	2024-05-15	\N	f	t
20	22	International Chinese Teacher Scholarship	Living expenses	2,500 yuan/month	2024-05-15	\N	f	t
22	24	school award	\N	none	2024-08-31	\N	f	f
23	25	school award	\N	none	2024-06-30	\N	f	f
25	27	school award	Living expenses	1,000 yuan/month	2024-06-30	\N	f	t
26	28	Provincial Award	\N	To be determined	2024-05-30	\N	f	f
27	29	Provincial Award	\N	To be determined	2024-05-30	\N	f	f
11	13	school award	Living expenses	1,000 yuan/month	2024-07-07	\N	t	t
14	16	school award	\N	\N	2024-04-06	\N	t	f
21	23	school award	\N	none	2024-09-20	\N	t	f
24	26	school award	\N	none	2024-06-30	\N	t	t
2	4	school award	\N	none	2024-06-30	\N	t	f
\.


--
-- TOC entry 3426 (class 0 OID 16471)
-- Dependencies: 224
-- Data for Name: translation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.translation (translation_id, table_name, column_name, foreign_key, language_code, text) FROM stdin;
\.


--
-- TOC entry 3416 (class 0 OID 16405)
-- Dependencies: 214
-- Data for Name: university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university (university_id, name, city_id, abbreviation) FROM stdin;
1	Anhui Jianzhu University	2	AHJZU
2	Beijing Institute of Graphic Arts	3	BIGC
3	Beijing International Studies University	3	BISU
4	Beijing Jiaotong University	3	BJTU
5	Beijing University of Posts and Telecommunications	3	BUPT
6	Changde Vocational and Technical College	4	CDZY
7	Changsha University of Science and Technology	9	CSUST
8	China University of Mining and Technology	5	CUMT
9	Changchun University of Science and Technology	6	CUST
10	Zhejiang University of Communication	7	CUZ
11	West China Normal University	8	CWNU
12	Dalian Jiaotong University	10	DJTU
13	Dongbei University of Finance and Economics	10	DUFE
14	East China Normal University	11	ECNU
15	Fuyang Normal University	12	FYNU
16	Fuzhou University of Foreign Studies and Foreign Trade	13	FZFU
17	Guilin University of Electronic Science and Technology	14	GUET
18	Gansu Agricultural Vocational and Technical College	15	GVCA
19	Guangxi University of Traditional Chinese Medicine	16	GXTCMU
\.


--
-- TOC entry 3428 (class 0 OID 16482)
-- Dependencies: 226
-- Data for Name: update_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.update_log (id, table_name, last_updated) FROM stdin;
\.


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 211
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_city_id_seq', 17, true);


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 219
-- Name: cost_cost_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cost_cost_id_seq', 27, true);


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 209
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_country_id_seq', 2, true);


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 215
-- Name: program_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_program_id_seq', 29, true);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 221
-- Name: requirement_requirement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requirement_requirement_id_seq', 1, false);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 217
-- Name: scholarship_scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_scholarship_id_seq', 27, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 223
-- Name: translation_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.translation_translation_id_seq', 1, false);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 213
-- Name: university_university_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.university_university_id_seq', 19, true);


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 225
-- Name: update_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.update_log_id_seq', 1, false);


--
-- TOC entry 3247 (class 2606 OID 16398)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 3255 (class 2606 OID 16450)
-- Name: cost cost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost
    ADD CONSTRAINT cost_pkey PRIMARY KEY (cost_id);


--
-- TOC entry 3245 (class 2606 OID 16391)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 3251 (class 2606 OID 16424)
-- Name: program program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (program_id);


--
-- TOC entry 3257 (class 2606 OID 16464)
-- Name: requirement requirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requirement
    ADD CONSTRAINT requirement_pkey PRIMARY KEY (requirement_id);


--
-- TOC entry 3253 (class 2606 OID 16438)
-- Name: scholarship scholarship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_pkey PRIMARY KEY (scholarship_id);


--
-- TOC entry 3259 (class 2606 OID 16478)
-- Name: translation translation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_pkey PRIMARY KEY (translation_id);


--
-- TOC entry 3261 (class 2606 OID 16480)
-- Name: translation translation_table_name_column_name_foreign_key_language_cod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_table_name_column_name_foreign_key_language_cod_key UNIQUE (table_name, column_name, foreign_key, language_code);


--
-- TOC entry 3249 (class 2606 OID 16410)
-- Name: university university_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_pkey PRIMARY KEY (university_id);


--
-- TOC entry 3263 (class 2606 OID 16488)
-- Name: update_log update_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.update_log
    ADD CONSTRAINT update_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2620 OID 16492)
-- Name: city update_university_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_university_timestamp AFTER INSERT OR DELETE OR UPDATE ON public.city FOR EACH ROW EXECUTE FUNCTION public.update_city();


--
-- TOC entry 3271 (class 2620 OID 16490)
-- Name: university update_university_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_university_timestamp AFTER INSERT OR DELETE OR UPDATE ON public.university FOR EACH ROW EXECUTE FUNCTION public.update_university();


--
-- TOC entry 3264 (class 2606 OID 16399)
-- Name: city city_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id);


--
-- TOC entry 3268 (class 2606 OID 16451)
-- Name: cost cost_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost
    ADD CONSTRAINT cost_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- TOC entry 3266 (class 2606 OID 16425)
-- Name: program program_university_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_university_id_fkey FOREIGN KEY (university_id) REFERENCES public.university(university_id);


--
-- TOC entry 3269 (class 2606 OID 16465)
-- Name: requirement requirement_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requirement
    ADD CONSTRAINT requirement_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- TOC entry 3267 (class 2606 OID 16439)
-- Name: scholarship scholarship_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- TOC entry 3265 (class 2606 OID 16411)
-- Name: university university_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university
    ADD CONSTRAINT university_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id);


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-06-08 01:14:18

--
-- PostgreSQL database dump complete
--

