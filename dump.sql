--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Ubuntu 15.3-1.pgdg23.04+1)
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg23.04+1)

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
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: apiCEP; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."apiCEP" (
    cep integer NOT NULL,
    cidade character(1) NOT NULL,
    uf character(1) NOT NULL
);


--
-- Name: categoriasServicos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."categoriasServicos" (
    id integer NOT NULL,
    descricao character varying NOT NULL,
    icon character varying NOT NULL
);


--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public."categoriasServicos".id;


--
-- Name: cidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cidade (
    id integer NOT NULL,
    nome character varying(120),
    uf integer
);


--
-- Name: cidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cidade_id_seq OWNED BY public.cidade.id;


--
-- Name: estado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estado (
    id integer NOT NULL,
    nome character varying(60),
    uf character varying(2),
    ddd json
);


--
-- Name: TABLE estado; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.estado IS 'Unidades Federativas';


--
-- Name: estado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estado_id_seq OWNED BY public.estado.id;


--
-- Name: prestadores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prestadores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prestadorServico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."prestadorServico" (
    id integer DEFAULT nextval('public.prestadores_id_seq'::regclass) NOT NULL,
    "userId" integer NOT NULL,
    "categoriaId" integer NOT NULL,
    "precoMin" integer,
    "precoMax" integer
);


--
-- Name: public.apiCEP_cep_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."public.apiCEP_cep_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: public.apiCEP_cep_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."public.apiCEP_cep_seq" OWNED BY public."apiCEP".cep;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    token character varying NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    valid boolean DEFAULT true NOT NULL
);


--
-- Name: public.sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."public.sessions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: public.sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."public.sessions_id_seq" OWNED BY public.sessions.id;


--
-- Name: servicoSolicitado_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."servicoSolicitado_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servicoSolicitado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."servicoSolicitado" (
    id integer DEFAULT nextval('public."servicoSolicitado_id_seq"'::regclass) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "categoriaId" integer NOT NULL,
    "solicitanteId" integer NOT NULL,
    "prestadorId" integer NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- Name: servicos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servicos (
    id integer NOT NULL,
    descricao character varying NOT NULL,
    img character varying,
    preco double precision,
    "userId" integer,
    "categoriaId" integer NOT NULL,
    available boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- Name: servicos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.servicos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servicos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.servicos_id_seq OWNED BY public.servicos.id;


--
-- Name: statusServico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."statusServico" (
    id integer NOT NULL,
    "servicoId" integer NOT NULL,
    "clienteId" integer NOT NULL,
    "prestadorId" integer NOT NULL,
    status character(1) NOT NULL,
    "contractedAt" timestamp without time zone NOT NULL
);


--
-- Name: statusServico_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."statusServico_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statusServico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."statusServico_id_seq" OWNED BY public."statusServico".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nome character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    endereco character varying NOT NULL,
    cep numeric NOT NULL,
    permission integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "numEnd" integer NOT NULL,
    bairro character varying,
    "cidadeId" integer NOT NULL,
    "estadoId" integer NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiCEP cep; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."apiCEP" ALTER COLUMN cep SET DEFAULT nextval('public."public.apiCEP_cep_seq"'::regclass);


--
-- Name: categoriasServicos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."categoriasServicos" ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- Name: cidade id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cidade ALTER COLUMN id SET DEFAULT nextval('public.cidade_id_seq'::regclass);


--
-- Name: estado id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estado ALTER COLUMN id SET DEFAULT nextval('public.estado_id_seq'::regclass);


--
-- Name: servicos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos ALTER COLUMN id SET DEFAULT nextval('public.servicos_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public."public.sessions_id_seq"'::regclass);


--
-- Name: statusServico id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."statusServico" ALTER COLUMN id SET DEFAULT nextval('public."statusServico_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public._prisma_migrations VALUES ('cd3219ea-6fe5-44a9-bddb-12e44037b98a', 'e69c9f21be2b53770b13ea52bf6c4f304a9fc86b41f1e932729ec2de45574341', '2023-08-11 19:05:35.84303-03', '0_init', '', NULL, '2023-08-11 19:05:35.84303-03', 0);
INSERT INTO public._prisma_migrations VALUES ('43a58745-0d56-4d99-91f1-8a481ff6dede', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', '2023-08-11 19:11:09.646708-03', '1_init', '', NULL, '2023-08-11 19:11:09.646708-03', 0);
INSERT INTO public._prisma_migrations VALUES ('8988bb38-6695-4d30-ab6a-9de606a859bc', 'f743b924742683ec99345717b6083534f5755ef2a23f4385d2c1433f082a3df8', '2023-08-12 14:35:15.72877-03', '2_init', '', NULL, '2023-08-12 14:35:15.72877-03', 0);
INSERT INTO public._prisma_migrations VALUES ('f43a5128-6594-4af5-95ad-49d2b89604b3', '074f4c4d6f85e1abcee9825481529ccdc7bc3c9db18c4bead81b724f19308bae', '2023-08-13 13:04:17.106968-03', '3_init', '', NULL, '2023-08-13 13:04:17.106968-03', 0);
INSERT INTO public._prisma_migrations VALUES ('d2a182f7-744c-4068-98e2-a742a26df055', 'c0f9115cb20db985a9c2920169aa591d8658b8cac500886063d826ccd799a7d6', '2023-08-13 13:10:52.751059-03', '4_init', '', NULL, '2023-08-13 13:10:52.751059-03', 0);
INSERT INTO public._prisma_migrations VALUES ('a9f4d694-add1-4c44-9fb2-6f3d185398d4', '0d763da6337670f2adfbea905cccb703da6e2d2a1dfa79f22be8d97b9fd5a2db', '2023-08-13 15:11:43.914155-03', '5_init', '', NULL, '2023-08-13 15:11:43.914155-03', 0);
INSERT INTO public._prisma_migrations VALUES ('4b68481e-1c5b-47db-a934-b4f513e385ee', '6baf7af46f894b071f32d53385793ed3be18657b9ebd65ab14f96b619582631c', '2023-08-13 16:16:31.277644-03', '6_init', '', NULL, '2023-08-13 16:16:31.277644-03', 0);
INSERT INTO public._prisma_migrations VALUES ('e5ebbb8d-fcb4-4f7c-8a11-4c5b414ec9d1', '2d80122a43697b07fbaf23cdeb3917ac4c1b6b8853c8ebf99b77c013c64e260b', '2023-08-13 16:19:53.202045-03', '7_init', '', NULL, '2023-08-13 16:19:53.202045-03', 0);
INSERT INTO public._prisma_migrations VALUES ('0b013cea-b1e0-48fe-8fda-1c56aaeb4163', '87a9af9dd6e156381b0c92ff84c3b72099ab159306598002bccc70f9ffd7ba63', '2023-08-13 16:22:20.832166-03', '8_init', '', NULL, '2023-08-13 16:22:20.832166-03', 0);
INSERT INTO public._prisma_migrations VALUES ('8a6cc9ed-e440-4e99-9b2f-068e2aa5a356', 'd5bf49df6bcc37a5b3762a6fed4d6f0bdaf8f4ce30f6e4068ebd38f7bfe12f9c', '2023-08-13 16:28:04.299177-03', '9_init', '', NULL, '2023-08-13 16:28:04.299177-03', 0);
INSERT INTO public._prisma_migrations VALUES ('0f741d72-1ec7-4f87-8555-fd2b49c7d15c', '25472e15dd9c1a7cb45eb2cd73e5b9812a77a0ce3e3c4252dba014316b2b835d', '2023-08-13 18:37:24.221042-03', '10_init', '', NULL, '2023-08-13 18:37:24.221042-03', 0);
INSERT INTO public._prisma_migrations VALUES ('0774a574-bf6a-43f8-bf2e-e6492be776ee', 'b2f97ff600034dae9d0ccb2b811284c738310eb793dbc778473167a569e62286', '2023-08-14 10:29:16.82565-03', '11_init', '', NULL, '2023-08-14 10:29:16.82565-03', 0);
INSERT INTO public._prisma_migrations VALUES ('9f0875da-13cb-40dd-aeea-28e6f97d4389', 'ecbfa34e3144fc83d9d1df8c027feb5c17ec6aa59965dca9bbf3a4e834f60c0b', '2023-08-14 11:17:18.608266-03', '2_deploy', '', NULL, '2023-08-14 11:17:18.608266-03', 0);
INSERT INTO public._prisma_migrations VALUES ('163889a5-a089-4bd8-bcc3-ca3fee876a7b', 'ecbfa34e3144fc83d9d1df8c027feb5c17ec6aa59965dca9bbf3a4e834f60c0b', '2023-08-14 11:25:51.373621-03', '3_deploy', '', NULL, '2023-08-14 11:25:51.373621-03', 0);
INSERT INTO public._prisma_migrations VALUES ('90f39579-ebb5-4c94-a0b2-1238f4d5b658', '71b50246ef22b8ec979e5751a73e25c2f52504841a96fc6b5dde97946c5c3a2c', '2023-08-14 11:29:11.456618-03', '4_deploy', '', NULL, '2023-08-14 11:29:11.456618-03', 0);
INSERT INTO public._prisma_migrations VALUES ('d8f71025-1b2f-4eff-b5a4-9041fbe80033', 'ecbfa34e3144fc83d9d1df8c027feb5c17ec6aa59965dca9bbf3a4e834f60c0b', NULL, '0_deploy', 'A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve

Migration name: 0_deploy

Database error code: 42P07

Database error:
ERROR: relation "apiCEP" already exists

DbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E42P07), message: "relation \"apiCEP\" already exists", detail: None, hint: None, position: None, where_: None, schema: None, table: None, column: None, datatype: None, constraint: None, file: Some("heap.c"), line: Some(1146), routine: Some("heap_create_with_catalog") }

   0: sql_schema_connector::apply_migration::apply_script
           with migration_name="0_deploy"
             at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:106
   1: schema_core::commands::apply_migrations::Applying migration
           with migration_name="0_deploy"
             at schema-engine/core/src/commands/apply_migrations.rs:91
   2: schema_core::state::ApplyMigrations
             at schema-engine/core/src/state.rs:201', NULL, '2023-08-14 11:32:53.291409-03', 0);


--
-- Data for Name: apiCEP; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: categoriasServicos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."categoriasServicos" VALUES (1, 'Alimentação', '<RestaurantOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (2, 'Automotivo', '<CarOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (3, 'Chaveiro', '<KeyOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (4, 'Cuidados especiais', '<LiaBabyCarriageSolid height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (5, 'Educação', '<BookOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (6, 'Jardinagem', '<PiPottedPlantThin height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (7, 'Laboratorial', '<FlaskOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (8, 'Marcenaria', '<GiHandSaw height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (9, 'Pet', '<PawOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (10, 'Saúde', '<FitnessOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (11, 'Serviços Domésticos', '<ConstructOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (12, 'Tecnologia', '<LaptopOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (13, 'Transporte', '<BusOutline height="0.8em" width="0.8em" />');
INSERT INTO public."categoriasServicos" VALUES (14, 'Viagens', '<IoAirplaneOutline height="0.8em" width="0.8em" />');


--
-- Data for Name: cidade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cidade VALUES (1, 'Afonso Cláudio', 8);
INSERT INTO public.cidade VALUES (2, 'Água Doce do Norte', 8);
INSERT INTO public.cidade VALUES (3, 'Águia Branca', 8);
INSERT INTO public.cidade VALUES (4, 'Alegre', 8);
INSERT INTO public.cidade VALUES (5, 'Alfredo Chaves', 8);
INSERT INTO public.cidade VALUES (6, 'Alto Rio Novo', 8);
INSERT INTO public.cidade VALUES (7, 'Anchieta', 8);
INSERT INTO public.cidade VALUES (8, 'Apiacá', 8);
INSERT INTO public.cidade VALUES (9, 'Aracruz', 8);
INSERT INTO public.cidade VALUES (10, 'Atilio Vivacqua', 8);
INSERT INTO public.cidade VALUES (11, 'Baixo Guandu', 8);
INSERT INTO public.cidade VALUES (12, 'Barra de São Francisco', 8);
INSERT INTO public.cidade VALUES (13, 'Boa Esperança', 8);
INSERT INTO public.cidade VALUES (14, 'Bom Jesus do Norte', 8);
INSERT INTO public.cidade VALUES (15, 'Brejetuba', 8);
INSERT INTO public.cidade VALUES (16, 'Cachoeiro de Itapemirim', 8);
INSERT INTO public.cidade VALUES (17, 'Cariacica', 8);
INSERT INTO public.cidade VALUES (18, 'Castelo', 8);
INSERT INTO public.cidade VALUES (19, 'Colatina', 8);
INSERT INTO public.cidade VALUES (20, 'Conceição da Barra', 8);
INSERT INTO public.cidade VALUES (21, 'Conceição do Castelo', 8);
INSERT INTO public.cidade VALUES (22, 'Divino de São Lourenço', 8);
INSERT INTO public.cidade VALUES (23, 'Domingos Martins', 8);
INSERT INTO public.cidade VALUES (24, 'Dores do Rio Preto', 8);
INSERT INTO public.cidade VALUES (25, 'Ecoporanga', 8);
INSERT INTO public.cidade VALUES (26, 'Fundão', 8);
INSERT INTO public.cidade VALUES (27, 'Governador Lindenberg', 8);
INSERT INTO public.cidade VALUES (28, 'Guaçuí', 8);
INSERT INTO public.cidade VALUES (29, 'Guarapari', 8);
INSERT INTO public.cidade VALUES (30, 'Ibatiba', 8);
INSERT INTO public.cidade VALUES (31, 'Ibiraçu', 8);
INSERT INTO public.cidade VALUES (32, 'Ibitirama', 8);
INSERT INTO public.cidade VALUES (33, 'Iconha', 8);
INSERT INTO public.cidade VALUES (34, 'Irupi', 8);
INSERT INTO public.cidade VALUES (35, 'Itaguaçu', 8);
INSERT INTO public.cidade VALUES (36, 'Itapemirim', 8);
INSERT INTO public.cidade VALUES (37, 'Itarana', 8);
INSERT INTO public.cidade VALUES (38, 'Iúna', 8);
INSERT INTO public.cidade VALUES (39, 'Jaguaré', 8);
INSERT INTO public.cidade VALUES (40, 'Jerônimo Monteiro', 8);
INSERT INTO public.cidade VALUES (41, 'João Neiva', 8);
INSERT INTO public.cidade VALUES (42, 'Laranja da Terra', 8);
INSERT INTO public.cidade VALUES (43, 'Linhares', 8);
INSERT INTO public.cidade VALUES (44, 'Mantenópolis', 8);
INSERT INTO public.cidade VALUES (45, 'Marataízes', 8);
INSERT INTO public.cidade VALUES (46, 'Marechal Floriano', 8);
INSERT INTO public.cidade VALUES (47, 'Marilândia', 8);
INSERT INTO public.cidade VALUES (48, 'Mimoso do Sul', 8);
INSERT INTO public.cidade VALUES (49, 'Montanha', 8);
INSERT INTO public.cidade VALUES (50, 'Mucurici', 8);
INSERT INTO public.cidade VALUES (51, 'Muniz Freire', 8);
INSERT INTO public.cidade VALUES (52, 'Muqui', 8);
INSERT INTO public.cidade VALUES (53, 'Nova Venécia', 8);
INSERT INTO public.cidade VALUES (54, 'Pancas', 8);
INSERT INTO public.cidade VALUES (55, 'Pedro Canário', 8);
INSERT INTO public.cidade VALUES (56, 'Pinheiros', 8);
INSERT INTO public.cidade VALUES (57, 'Piúma', 8);
INSERT INTO public.cidade VALUES (58, 'Ponto Belo', 8);
INSERT INTO public.cidade VALUES (59, 'Presidente Kennedy', 8);
INSERT INTO public.cidade VALUES (60, 'Rio Bananal', 8);
INSERT INTO public.cidade VALUES (61, 'Rio Novo do Sul', 8);
INSERT INTO public.cidade VALUES (62, 'Santa Leopoldina', 8);
INSERT INTO public.cidade VALUES (63, 'Santa Maria de Jetibá', 8);
INSERT INTO public.cidade VALUES (64, 'Santa Teresa', 8);
INSERT INTO public.cidade VALUES (65, 'São Domingos do Norte', 8);
INSERT INTO public.cidade VALUES (66, 'São Gabriel da Palha', 8);
INSERT INTO public.cidade VALUES (67, 'São José do Calçado', 8);
INSERT INTO public.cidade VALUES (68, 'São Mateus', 8);
INSERT INTO public.cidade VALUES (69, 'São Roque do Canaã', 8);
INSERT INTO public.cidade VALUES (70, 'Serra', 8);
INSERT INTO public.cidade VALUES (71, 'Sooretama', 8);
INSERT INTO public.cidade VALUES (72, 'Vargem Alta', 8);
INSERT INTO public.cidade VALUES (73, 'Venda Nova do Imigrante', 8);
INSERT INTO public.cidade VALUES (74, 'Viana', 8);
INSERT INTO public.cidade VALUES (75, 'Vila Pavão', 8);
INSERT INTO public.cidade VALUES (76, 'Vila Valério', 8);
INSERT INTO public.cidade VALUES (77, 'Vila Velha', 8);
INSERT INTO public.cidade VALUES (78, 'Vitória', 8);
INSERT INTO public.cidade VALUES (79, 'Acrelândia', 1);
INSERT INTO public.cidade VALUES (80, 'Assis Brasil', 1);
INSERT INTO public.cidade VALUES (81, 'Brasiléia', 1);
INSERT INTO public.cidade VALUES (82, 'Bujari', 1);
INSERT INTO public.cidade VALUES (83, 'Capixaba', 1);
INSERT INTO public.cidade VALUES (84, 'Cruzeiro do Sul', 1);
INSERT INTO public.cidade VALUES (85, 'Epitaciolândia', 1);
INSERT INTO public.cidade VALUES (86, 'Feijó', 1);
INSERT INTO public.cidade VALUES (87, 'Jordão', 1);
INSERT INTO public.cidade VALUES (88, 'Mâncio Lima', 1);
INSERT INTO public.cidade VALUES (89, 'Manoel Urbano', 1);
INSERT INTO public.cidade VALUES (90, 'Marechal Thaumaturgo', 1);
INSERT INTO public.cidade VALUES (91, 'Plácido de Castro', 1);
INSERT INTO public.cidade VALUES (92, 'Porto Acre', 1);
INSERT INTO public.cidade VALUES (93, 'Porto Walter', 1);
INSERT INTO public.cidade VALUES (94, 'Rio Branco', 1);
INSERT INTO public.cidade VALUES (95, 'Rodrigues Alves', 1);
INSERT INTO public.cidade VALUES (96, 'Santa Rosa do Purus', 1);
INSERT INTO public.cidade VALUES (97, 'Sena Madureira', 1);
INSERT INTO public.cidade VALUES (98, 'Senador Guiomard', 1);
INSERT INTO public.cidade VALUES (99, 'Tarauacá', 1);
INSERT INTO public.cidade VALUES (100, 'Xapuri', 1);
INSERT INTO public.cidade VALUES (101, 'Água Branca', 2);
INSERT INTO public.cidade VALUES (102, 'Anadia', 2);
INSERT INTO public.cidade VALUES (103, 'Arapiraca', 2);
INSERT INTO public.cidade VALUES (104, 'Atalaia', 2);
INSERT INTO public.cidade VALUES (105, 'Barra de Santo Antônio', 2);
INSERT INTO public.cidade VALUES (106, 'Barra de São Miguel', 2);
INSERT INTO public.cidade VALUES (107, 'Batalha', 2);
INSERT INTO public.cidade VALUES (108, 'Belém', 2);
INSERT INTO public.cidade VALUES (109, 'Belo Monte', 2);
INSERT INTO public.cidade VALUES (110, 'Boca da Mata', 2);
INSERT INTO public.cidade VALUES (111, 'Branquinha', 2);
INSERT INTO public.cidade VALUES (112, 'Cacimbinhas', 2);
INSERT INTO public.cidade VALUES (113, 'Cajueiro', 2);
INSERT INTO public.cidade VALUES (114, 'Campestre', 2);
INSERT INTO public.cidade VALUES (115, 'Campo Alegre', 2);
INSERT INTO public.cidade VALUES (116, 'Campo Grande', 2);
INSERT INTO public.cidade VALUES (117, 'Canapi', 2);
INSERT INTO public.cidade VALUES (118, 'Capela', 2);
INSERT INTO public.cidade VALUES (119, 'Carneiros', 2);
INSERT INTO public.cidade VALUES (120, 'Chã Preta', 2);
INSERT INTO public.cidade VALUES (121, 'Coité do Nóia', 2);
INSERT INTO public.cidade VALUES (122, 'Colônia Leopoldina', 2);
INSERT INTO public.cidade VALUES (123, 'Coqueiro Seco', 2);
INSERT INTO public.cidade VALUES (124, 'Coruripe', 2);
INSERT INTO public.cidade VALUES (125, 'Craíbas', 2);
INSERT INTO public.cidade VALUES (126, 'Delmiro Gouveia', 2);
INSERT INTO public.cidade VALUES (127, 'Dois Riachos', 2);
INSERT INTO public.cidade VALUES (128, 'Estrela de Alagoas', 2);
INSERT INTO public.cidade VALUES (129, 'Feira Grande', 2);
INSERT INTO public.cidade VALUES (130, 'Feliz Deserto', 2);
INSERT INTO public.cidade VALUES (131, 'Flexeiras', 2);
INSERT INTO public.cidade VALUES (132, 'Girau do Ponciano', 2);
INSERT INTO public.cidade VALUES (133, 'Ibateguara', 2);
INSERT INTO public.cidade VALUES (134, 'Igaci', 2);
INSERT INTO public.cidade VALUES (135, 'Igreja Nova', 2);
INSERT INTO public.cidade VALUES (136, 'Inhapi', 2);
INSERT INTO public.cidade VALUES (137, 'Jacaré dos Homens', 2);
INSERT INTO public.cidade VALUES (138, 'Jacuípe', 2);
INSERT INTO public.cidade VALUES (139, 'Japaratinga', 2);
INSERT INTO public.cidade VALUES (140, 'Jaramataia', 2);
INSERT INTO public.cidade VALUES (141, 'Jequiá da Praia', 2);
INSERT INTO public.cidade VALUES (142, 'Joaquim Gomes', 2);
INSERT INTO public.cidade VALUES (143, 'Jundiá', 2);
INSERT INTO public.cidade VALUES (144, 'Junqueiro', 2);
INSERT INTO public.cidade VALUES (145, 'Lagoa da Canoa', 2);
INSERT INTO public.cidade VALUES (146, 'Limoeiro de Anadia', 2);
INSERT INTO public.cidade VALUES (147, 'Maceió', 2);
INSERT INTO public.cidade VALUES (148, 'Major Isidoro', 2);
INSERT INTO public.cidade VALUES (149, 'Mar Vermelho', 2);
INSERT INTO public.cidade VALUES (150, 'Maragogi', 2);
INSERT INTO public.cidade VALUES (151, 'Maravilha', 2);
INSERT INTO public.cidade VALUES (152, 'Marechal Deodoro', 2);
INSERT INTO public.cidade VALUES (153, 'Maribondo', 2);
INSERT INTO public.cidade VALUES (154, 'Mata Grande', 2);
INSERT INTO public.cidade VALUES (155, 'Matriz de Camaragibe', 2);
INSERT INTO public.cidade VALUES (156, 'Messias', 2);
INSERT INTO public.cidade VALUES (157, 'Minador do Negrão', 2);
INSERT INTO public.cidade VALUES (158, 'Monteirópolis', 2);
INSERT INTO public.cidade VALUES (159, 'Murici', 2);
INSERT INTO public.cidade VALUES (160, 'Novo Lino', 2);
INSERT INTO public.cidade VALUES (161, 'Olho d`Água das Flores', 2);
INSERT INTO public.cidade VALUES (162, 'Olho d`Água do Casado', 2);
INSERT INTO public.cidade VALUES (163, 'Olho d`Água Grande', 2);
INSERT INTO public.cidade VALUES (164, 'Olivença', 2);
INSERT INTO public.cidade VALUES (165, 'Ouro Branco', 2);
INSERT INTO public.cidade VALUES (166, 'Palestina', 2);
INSERT INTO public.cidade VALUES (167, 'Palmeira dos Índios', 2);
INSERT INTO public.cidade VALUES (168, 'Pão de Açúcar', 2);
INSERT INTO public.cidade VALUES (169, 'Pariconha', 2);
INSERT INTO public.cidade VALUES (170, 'Paripueira', 2);
INSERT INTO public.cidade VALUES (171, 'Passo de Camaragibe', 2);
INSERT INTO public.cidade VALUES (172, 'Paulo Jacinto', 2);
INSERT INTO public.cidade VALUES (173, 'Penedo', 2);
INSERT INTO public.cidade VALUES (174, 'Piaçabuçu', 2);
INSERT INTO public.cidade VALUES (175, 'Pilar', 2);
INSERT INTO public.cidade VALUES (176, 'Pindoba', 2);
INSERT INTO public.cidade VALUES (177, 'Piranhas', 2);
INSERT INTO public.cidade VALUES (178, 'Poço das Trincheiras', 2);
INSERT INTO public.cidade VALUES (179, 'Porto Calvo', 2);
INSERT INTO public.cidade VALUES (180, 'Porto de Pedras', 2);
INSERT INTO public.cidade VALUES (181, 'Porto Real do Colégio', 2);
INSERT INTO public.cidade VALUES (182, 'Quebrangulo', 2);
INSERT INTO public.cidade VALUES (183, 'Rio Largo', 2);
INSERT INTO public.cidade VALUES (184, 'Roteiro', 2);
INSERT INTO public.cidade VALUES (185, 'Santa Luzia do Norte', 2);
INSERT INTO public.cidade VALUES (186, 'Santana do Ipanema', 2);
INSERT INTO public.cidade VALUES (187, 'Santana do Mundaú', 2);
INSERT INTO public.cidade VALUES (188, 'São Brás', 2);
INSERT INTO public.cidade VALUES (189, 'São José da Laje', 2);
INSERT INTO public.cidade VALUES (190, 'São José da Tapera', 2);
INSERT INTO public.cidade VALUES (191, 'São Luís do Quitunde', 2);
INSERT INTO public.cidade VALUES (192, 'São Miguel dos Campos', 2);
INSERT INTO public.cidade VALUES (193, 'São Miguel dos Milagres', 2);
INSERT INTO public.cidade VALUES (194, 'São Sebastião', 2);
INSERT INTO public.cidade VALUES (195, 'Satuba', 2);
INSERT INTO public.cidade VALUES (196, 'Senador Rui Palmeira', 2);
INSERT INTO public.cidade VALUES (197, 'Tanque d`Arca', 2);
INSERT INTO public.cidade VALUES (198, 'Taquarana', 2);
INSERT INTO public.cidade VALUES (199, 'Teotônio Vilela', 2);
INSERT INTO public.cidade VALUES (200, 'Traipu', 2);
INSERT INTO public.cidade VALUES (201, 'União dos Palmares', 2);
INSERT INTO public.cidade VALUES (202, 'Viçosa', 2);
INSERT INTO public.cidade VALUES (203, 'Amapá', 4);
INSERT INTO public.cidade VALUES (204, 'Calçoene', 4);
INSERT INTO public.cidade VALUES (205, 'Cutias', 4);
INSERT INTO public.cidade VALUES (206, 'Ferreira Gomes', 4);
INSERT INTO public.cidade VALUES (207, 'Itaubal', 4);
INSERT INTO public.cidade VALUES (208, 'Laranjal do Jari', 4);
INSERT INTO public.cidade VALUES (209, 'Macapá', 4);
INSERT INTO public.cidade VALUES (210, 'Mazagão', 4);
INSERT INTO public.cidade VALUES (211, 'Oiapoque', 4);
INSERT INTO public.cidade VALUES (212, 'Pedra Branca do Amaparí', 4);
INSERT INTO public.cidade VALUES (213, 'Porto Grande', 4);
INSERT INTO public.cidade VALUES (214, 'Pracuúba', 4);
INSERT INTO public.cidade VALUES (215, 'Santana', 4);
INSERT INTO public.cidade VALUES (216, 'Serra do Navio', 4);
INSERT INTO public.cidade VALUES (217, 'Tartarugalzinho', 4);
INSERT INTO public.cidade VALUES (218, 'Vitória do Jari', 4);
INSERT INTO public.cidade VALUES (219, 'Alvarães', 3);
INSERT INTO public.cidade VALUES (220, 'Amaturá', 3);
INSERT INTO public.cidade VALUES (221, 'Anamã', 3);
INSERT INTO public.cidade VALUES (222, 'Anori', 3);
INSERT INTO public.cidade VALUES (223, 'Apuí', 3);
INSERT INTO public.cidade VALUES (224, 'Atalaia do Norte', 3);
INSERT INTO public.cidade VALUES (225, 'Autazes', 3);
INSERT INTO public.cidade VALUES (226, 'Barcelos', 3);
INSERT INTO public.cidade VALUES (227, 'Barreirinha', 3);
INSERT INTO public.cidade VALUES (228, 'Benjamin Constant', 3);
INSERT INTO public.cidade VALUES (229, 'Beruri', 3);
INSERT INTO public.cidade VALUES (230, 'Boa Vista do Ramos', 3);
INSERT INTO public.cidade VALUES (231, 'Boca do Acre', 3);
INSERT INTO public.cidade VALUES (232, 'Borba', 3);
INSERT INTO public.cidade VALUES (233, 'Caapiranga', 3);
INSERT INTO public.cidade VALUES (234, 'Canutama', 3);
INSERT INTO public.cidade VALUES (235, 'Carauari', 3);
INSERT INTO public.cidade VALUES (236, 'Careiro', 3);
INSERT INTO public.cidade VALUES (237, 'Careiro da Várzea', 3);
INSERT INTO public.cidade VALUES (238, 'Coari', 3);
INSERT INTO public.cidade VALUES (239, 'Codajás', 3);
INSERT INTO public.cidade VALUES (240, 'Eirunepé', 3);
INSERT INTO public.cidade VALUES (241, 'Envira', 3);
INSERT INTO public.cidade VALUES (242, 'Fonte Boa', 3);
INSERT INTO public.cidade VALUES (243, 'Guajará', 3);
INSERT INTO public.cidade VALUES (244, 'Humaitá', 3);
INSERT INTO public.cidade VALUES (245, 'Ipixuna', 3);
INSERT INTO public.cidade VALUES (246, 'Iranduba', 3);
INSERT INTO public.cidade VALUES (247, 'Itacoatiara', 3);
INSERT INTO public.cidade VALUES (248, 'Itamarati', 3);
INSERT INTO public.cidade VALUES (249, 'Itapiranga', 3);
INSERT INTO public.cidade VALUES (250, 'Japurá', 3);
INSERT INTO public.cidade VALUES (251, 'Juruá', 3);
INSERT INTO public.cidade VALUES (252, 'Jutaí', 3);
INSERT INTO public.cidade VALUES (253, 'Lábrea', 3);
INSERT INTO public.cidade VALUES (254, 'Manacapuru', 3);
INSERT INTO public.cidade VALUES (255, 'Manaquiri', 3);
INSERT INTO public.cidade VALUES (256, 'Manaus', 3);
INSERT INTO public.cidade VALUES (257, 'Manicoré', 3);
INSERT INTO public.cidade VALUES (258, 'Maraã', 3);
INSERT INTO public.cidade VALUES (259, 'Maués', 3);
INSERT INTO public.cidade VALUES (260, 'Nhamundá', 3);
INSERT INTO public.cidade VALUES (261, 'Nova Olinda do Norte', 3);
INSERT INTO public.cidade VALUES (262, 'Novo Airão', 3);
INSERT INTO public.cidade VALUES (263, 'Novo Aripuanã', 3);
INSERT INTO public.cidade VALUES (264, 'Parintins', 3);
INSERT INTO public.cidade VALUES (265, 'Pauini', 3);
INSERT INTO public.cidade VALUES (266, 'Presidente Figueiredo', 3);
INSERT INTO public.cidade VALUES (267, 'Rio Preto da Eva', 3);
INSERT INTO public.cidade VALUES (268, 'Santa Isabel do Rio Negro', 3);
INSERT INTO public.cidade VALUES (269, 'Santo Antônio do Içá', 3);
INSERT INTO public.cidade VALUES (270, 'São Gabriel da Cachoeira', 3);
INSERT INTO public.cidade VALUES (271, 'São Paulo de Olivença', 3);
INSERT INTO public.cidade VALUES (272, 'São Sebastião do Uatumã', 3);
INSERT INTO public.cidade VALUES (273, 'Silves', 3);
INSERT INTO public.cidade VALUES (274, 'Tabatinga', 3);
INSERT INTO public.cidade VALUES (275, 'Tapauá', 3);
INSERT INTO public.cidade VALUES (276, 'Tefé', 3);
INSERT INTO public.cidade VALUES (277, 'Tonantins', 3);
INSERT INTO public.cidade VALUES (278, 'Uarini', 3);
INSERT INTO public.cidade VALUES (279, 'Urucará', 3);
INSERT INTO public.cidade VALUES (280, 'Urucurituba', 3);
INSERT INTO public.cidade VALUES (281, 'Abaíra', 5);
INSERT INTO public.cidade VALUES (282, 'Abaré', 5);
INSERT INTO public.cidade VALUES (283, 'Acajutiba', 5);
INSERT INTO public.cidade VALUES (284, 'Adustina', 5);
INSERT INTO public.cidade VALUES (285, 'Água Fria', 5);
INSERT INTO public.cidade VALUES (286, 'Aiquara', 5);
INSERT INTO public.cidade VALUES (287, 'Alagoinhas', 5);
INSERT INTO public.cidade VALUES (288, 'Alcobaça', 5);
INSERT INTO public.cidade VALUES (289, 'Almadina', 5);
INSERT INTO public.cidade VALUES (290, 'Amargosa', 5);
INSERT INTO public.cidade VALUES (291, 'Amélia Rodrigues', 5);
INSERT INTO public.cidade VALUES (292, 'América Dourada', 5);
INSERT INTO public.cidade VALUES (293, 'Anagé', 5);
INSERT INTO public.cidade VALUES (294, 'Andaraí', 5);
INSERT INTO public.cidade VALUES (295, 'Andorinha', 5);
INSERT INTO public.cidade VALUES (296, 'Angical', 5);
INSERT INTO public.cidade VALUES (297, 'Anguera', 5);
INSERT INTO public.cidade VALUES (298, 'Antas', 5);
INSERT INTO public.cidade VALUES (299, 'Antônio Cardoso', 5);
INSERT INTO public.cidade VALUES (300, 'Antônio Gonçalves', 5);
INSERT INTO public.cidade VALUES (301, 'Aporá', 5);
INSERT INTO public.cidade VALUES (302, 'Apuarema', 5);
INSERT INTO public.cidade VALUES (303, 'Araças', 5);
INSERT INTO public.cidade VALUES (304, 'Aracatu', 5);
INSERT INTO public.cidade VALUES (305, 'Araci', 5);
INSERT INTO public.cidade VALUES (306, 'Aramari', 5);
INSERT INTO public.cidade VALUES (307, 'Arataca', 5);
INSERT INTO public.cidade VALUES (308, 'Aratuípe', 5);
INSERT INTO public.cidade VALUES (309, 'Aurelino Leal', 5);
INSERT INTO public.cidade VALUES (310, 'Baianópolis', 5);
INSERT INTO public.cidade VALUES (311, 'Baixa Grande', 5);
INSERT INTO public.cidade VALUES (312, 'Banzaê', 5);
INSERT INTO public.cidade VALUES (313, 'Barra', 5);
INSERT INTO public.cidade VALUES (314, 'Barra da Estiva', 5);
INSERT INTO public.cidade VALUES (315, 'Barra do Choça', 5);
INSERT INTO public.cidade VALUES (316, 'Barra do Mendes', 5);
INSERT INTO public.cidade VALUES (317, 'Barra do Rocha', 5);
INSERT INTO public.cidade VALUES (318, 'Barreiras', 5);
INSERT INTO public.cidade VALUES (319, 'Barro Alto', 5);
INSERT INTO public.cidade VALUES (320, 'Barro Preto (antigo Gov. Lomanto Jr.)', 5);
INSERT INTO public.cidade VALUES (321, 'Barrocas', 5);
INSERT INTO public.cidade VALUES (322, 'Belmonte', 5);
INSERT INTO public.cidade VALUES (323, 'Belo Campo', 5);
INSERT INTO public.cidade VALUES (324, 'Biritinga', 5);
INSERT INTO public.cidade VALUES (325, 'Boa Nova', 5);
INSERT INTO public.cidade VALUES (326, 'Boa Vista do Tupim', 5);
INSERT INTO public.cidade VALUES (327, 'Bom Jesus da Lapa', 5);
INSERT INTO public.cidade VALUES (328, 'Bom Jesus da Serra', 5);
INSERT INTO public.cidade VALUES (329, 'Boninal', 5);
INSERT INTO public.cidade VALUES (330, 'Bonito', 5);
INSERT INTO public.cidade VALUES (331, 'Boquira', 5);
INSERT INTO public.cidade VALUES (332, 'Botuporã', 5);
INSERT INTO public.cidade VALUES (333, 'Brejões', 5);
INSERT INTO public.cidade VALUES (334, 'Brejolândia', 5);
INSERT INTO public.cidade VALUES (335, 'Brotas de Macaúbas', 5);
INSERT INTO public.cidade VALUES (336, 'Brumado', 5);
INSERT INTO public.cidade VALUES (337, 'Buerarema', 5);
INSERT INTO public.cidade VALUES (338, 'Buritirama', 5);
INSERT INTO public.cidade VALUES (339, 'Caatiba', 5);
INSERT INTO public.cidade VALUES (340, 'Cabaceiras do Paraguaçu', 5);
INSERT INTO public.cidade VALUES (341, 'Cachoeira', 5);
INSERT INTO public.cidade VALUES (342, 'Caculé', 5);
INSERT INTO public.cidade VALUES (343, 'Caém', 5);
INSERT INTO public.cidade VALUES (344, 'Caetanos', 5);
INSERT INTO public.cidade VALUES (345, 'Caetité', 5);
INSERT INTO public.cidade VALUES (346, 'Cafarnaum', 5);
INSERT INTO public.cidade VALUES (347, 'Cairu', 5);
INSERT INTO public.cidade VALUES (348, 'Caldeirão Grande', 5);
INSERT INTO public.cidade VALUES (349, 'Camacan', 5);
INSERT INTO public.cidade VALUES (350, 'Camaçari', 5);
INSERT INTO public.cidade VALUES (351, 'Camamu', 5);
INSERT INTO public.cidade VALUES (352, 'Campo Alegre de Lourdes', 5);
INSERT INTO public.cidade VALUES (353, 'Campo Formoso', 5);
INSERT INTO public.cidade VALUES (354, 'Canápolis', 5);
INSERT INTO public.cidade VALUES (355, 'Canarana', 5);
INSERT INTO public.cidade VALUES (356, 'Canavieiras', 5);
INSERT INTO public.cidade VALUES (357, 'Candeal', 5);
INSERT INTO public.cidade VALUES (358, 'Candeias', 5);
INSERT INTO public.cidade VALUES (359, 'Candiba', 5);
INSERT INTO public.cidade VALUES (360, 'Cândido Sales', 5);
INSERT INTO public.cidade VALUES (361, 'Cansanção', 5);
INSERT INTO public.cidade VALUES (362, 'Canudos', 5);
INSERT INTO public.cidade VALUES (363, 'Capela do Alto Alegre', 5);
INSERT INTO public.cidade VALUES (364, 'Capim Grosso', 5);
INSERT INTO public.cidade VALUES (365, 'Caraíbas', 5);
INSERT INTO public.cidade VALUES (366, 'Caravelas', 5);
INSERT INTO public.cidade VALUES (367, 'Cardeal da Silva', 5);
INSERT INTO public.cidade VALUES (368, 'Carinhanha', 5);
INSERT INTO public.cidade VALUES (369, 'Casa Nova', 5);
INSERT INTO public.cidade VALUES (370, 'Castro Alves', 5);
INSERT INTO public.cidade VALUES (371, 'Catolândia', 5);
INSERT INTO public.cidade VALUES (372, 'Catu', 5);
INSERT INTO public.cidade VALUES (373, 'Caturama', 5);
INSERT INTO public.cidade VALUES (374, 'Central', 5);
INSERT INTO public.cidade VALUES (375, 'Chorrochó', 5);
INSERT INTO public.cidade VALUES (376, 'Cícero Dantas', 5);
INSERT INTO public.cidade VALUES (377, 'Cipó', 5);
INSERT INTO public.cidade VALUES (378, 'Coaraci', 5);
INSERT INTO public.cidade VALUES (379, 'Cocos', 5);
INSERT INTO public.cidade VALUES (380, 'Conceição da Feira', 5);
INSERT INTO public.cidade VALUES (381, 'Conceição do Almeida', 5);
INSERT INTO public.cidade VALUES (382, 'Conceição do Coité', 5);
INSERT INTO public.cidade VALUES (383, 'Conceição do Jacuípe', 5);
INSERT INTO public.cidade VALUES (384, 'Conde', 5);
INSERT INTO public.cidade VALUES (385, 'Condeúba', 5);
INSERT INTO public.cidade VALUES (386, 'Contendas do Sincorá', 5);
INSERT INTO public.cidade VALUES (387, 'Coração de Maria', 5);
INSERT INTO public.cidade VALUES (388, 'Cordeiros', 5);
INSERT INTO public.cidade VALUES (389, 'Coribe', 5);
INSERT INTO public.cidade VALUES (390, 'Coronel João Sá', 5);
INSERT INTO public.cidade VALUES (391, 'Correntina', 5);
INSERT INTO public.cidade VALUES (392, 'Cotegipe', 5);
INSERT INTO public.cidade VALUES (393, 'Cravolândia', 5);
INSERT INTO public.cidade VALUES (394, 'Crisópolis', 5);
INSERT INTO public.cidade VALUES (395, 'Cristópolis', 5);
INSERT INTO public.cidade VALUES (396, 'Cruz das Almas', 5);
INSERT INTO public.cidade VALUES (397, 'Curaçá', 5);
INSERT INTO public.cidade VALUES (398, 'Dário Meira', 5);
INSERT INTO public.cidade VALUES (399, 'Dias d`Ávila', 5);
INSERT INTO public.cidade VALUES (400, 'Dom Basílio', 5);
INSERT INTO public.cidade VALUES (401, 'Dom Macedo Costa', 5);
INSERT INTO public.cidade VALUES (402, 'Elísio Medrado', 5);
INSERT INTO public.cidade VALUES (403, 'Encruzilhada', 5);
INSERT INTO public.cidade VALUES (404, 'Entre Rios', 5);
INSERT INTO public.cidade VALUES (405, 'Érico Cardoso', 5);
INSERT INTO public.cidade VALUES (406, 'Esplanada', 5);
INSERT INTO public.cidade VALUES (407, 'Euclides da Cunha', 5);
INSERT INTO public.cidade VALUES (408, 'Eunápolis', 5);
INSERT INTO public.cidade VALUES (409, 'Fátima', 5);
INSERT INTO public.cidade VALUES (410, 'Feira da Mata', 5);
INSERT INTO public.cidade VALUES (411, 'Feira de Santana', 5);
INSERT INTO public.cidade VALUES (412, 'Filadélfia', 5);
INSERT INTO public.cidade VALUES (413, 'Firmino Alves', 5);
INSERT INTO public.cidade VALUES (414, 'Floresta Azul', 5);
INSERT INTO public.cidade VALUES (415, 'Formosa do Rio Preto', 5);
INSERT INTO public.cidade VALUES (416, 'Gandu', 5);
INSERT INTO public.cidade VALUES (417, 'Gavião', 5);
INSERT INTO public.cidade VALUES (418, 'Gentio do Ouro', 5);
INSERT INTO public.cidade VALUES (419, 'Glória', 5);
INSERT INTO public.cidade VALUES (420, 'Gongogi', 5);
INSERT INTO public.cidade VALUES (421, 'Governador Mangabeira', 5);
INSERT INTO public.cidade VALUES (422, 'Guajeru', 5);
INSERT INTO public.cidade VALUES (423, 'Guanambi', 5);
INSERT INTO public.cidade VALUES (424, 'Guaratinga', 5);
INSERT INTO public.cidade VALUES (425, 'Heliópolis', 5);
INSERT INTO public.cidade VALUES (426, 'Iaçu', 5);
INSERT INTO public.cidade VALUES (427, 'Ibiassucê', 5);
INSERT INTO public.cidade VALUES (428, 'Ibicaraí', 5);
INSERT INTO public.cidade VALUES (429, 'Ibicoara', 5);
INSERT INTO public.cidade VALUES (430, 'Ibicuí', 5);
INSERT INTO public.cidade VALUES (431, 'Ibipeba', 5);
INSERT INTO public.cidade VALUES (432, 'Ibipitanga', 5);
INSERT INTO public.cidade VALUES (433, 'Ibiquera', 5);
INSERT INTO public.cidade VALUES (434, 'Ibirapitanga', 5);
INSERT INTO public.cidade VALUES (435, 'Ibirapuã', 5);
INSERT INTO public.cidade VALUES (436, 'Ibirataia', 5);
INSERT INTO public.cidade VALUES (437, 'Ibitiara', 5);
INSERT INTO public.cidade VALUES (438, 'Ibititá', 5);
INSERT INTO public.cidade VALUES (439, 'Ibotirama', 5);
INSERT INTO public.cidade VALUES (440, 'Ichu', 5);
INSERT INTO public.cidade VALUES (441, 'Igaporã', 5);
INSERT INTO public.cidade VALUES (442, 'Igrapiúna', 5);
INSERT INTO public.cidade VALUES (443, 'Iguaí', 5);
INSERT INTO public.cidade VALUES (444, 'Ilhéus', 5);
INSERT INTO public.cidade VALUES (445, 'Inhambupe', 5);
INSERT INTO public.cidade VALUES (446, 'Ipecaetá', 5);
INSERT INTO public.cidade VALUES (447, 'Ipiaú', 5);
INSERT INTO public.cidade VALUES (448, 'Ipirá', 5);
INSERT INTO public.cidade VALUES (449, 'Ipupiara', 5);
INSERT INTO public.cidade VALUES (450, 'Irajuba', 5);
INSERT INTO public.cidade VALUES (451, 'Iramaia', 5);
INSERT INTO public.cidade VALUES (452, 'Iraquara', 5);
INSERT INTO public.cidade VALUES (453, 'Irará', 5);
INSERT INTO public.cidade VALUES (454, 'Irecê', 5);
INSERT INTO public.cidade VALUES (455, 'Itabela', 5);
INSERT INTO public.cidade VALUES (456, 'Itaberaba', 5);
INSERT INTO public.cidade VALUES (457, 'Itabuna', 5);
INSERT INTO public.cidade VALUES (458, 'Itacaré', 5);
INSERT INTO public.cidade VALUES (459, 'Itaeté', 5);
INSERT INTO public.cidade VALUES (460, 'Itagi', 5);
INSERT INTO public.cidade VALUES (461, 'Itagibá', 5);
INSERT INTO public.cidade VALUES (462, 'Itagimirim', 5);
INSERT INTO public.cidade VALUES (463, 'Itaguaçu da Bahia', 5);
INSERT INTO public.cidade VALUES (464, 'Itaju do Colônia', 5);
INSERT INTO public.cidade VALUES (465, 'Itajuípe', 5);
INSERT INTO public.cidade VALUES (466, 'Itamaraju', 5);
INSERT INTO public.cidade VALUES (467, 'Itamari', 5);
INSERT INTO public.cidade VALUES (468, 'Itambé', 5);
INSERT INTO public.cidade VALUES (469, 'Itanagra', 5);
INSERT INTO public.cidade VALUES (470, 'Itanhém', 5);
INSERT INTO public.cidade VALUES (471, 'Itaparica', 5);
INSERT INTO public.cidade VALUES (472, 'Itapé', 5);
INSERT INTO public.cidade VALUES (473, 'Itapebi', 5);
INSERT INTO public.cidade VALUES (474, 'Itapetinga', 5);
INSERT INTO public.cidade VALUES (475, 'Itapicuru', 5);
INSERT INTO public.cidade VALUES (476, 'Itapitanga', 5);
INSERT INTO public.cidade VALUES (477, 'Itaquara', 5);
INSERT INTO public.cidade VALUES (478, 'Itarantim', 5);
INSERT INTO public.cidade VALUES (479, 'Itatim', 5);
INSERT INTO public.cidade VALUES (480, 'Itiruçu', 5);
INSERT INTO public.cidade VALUES (481, 'Itiúba', 5);
INSERT INTO public.cidade VALUES (482, 'Itororó', 5);
INSERT INTO public.cidade VALUES (483, 'Ituaçu', 5);
INSERT INTO public.cidade VALUES (484, 'Ituberá', 5);
INSERT INTO public.cidade VALUES (485, 'Iuiú', 5);
INSERT INTO public.cidade VALUES (486, 'Jaborandi', 5);
INSERT INTO public.cidade VALUES (487, 'Jacaraci', 5);
INSERT INTO public.cidade VALUES (488, 'Jacobina', 5);
INSERT INTO public.cidade VALUES (489, 'Jaguaquara', 5);
INSERT INTO public.cidade VALUES (490, 'Jaguarari', 5);
INSERT INTO public.cidade VALUES (491, 'Jaguaripe', 5);
INSERT INTO public.cidade VALUES (492, 'Jandaíra', 5);
INSERT INTO public.cidade VALUES (493, 'Jequié', 5);
INSERT INTO public.cidade VALUES (494, 'Jeremoabo', 5);
INSERT INTO public.cidade VALUES (495, 'Jiquiriçá', 5);
INSERT INTO public.cidade VALUES (496, 'Jitaúna', 5);
INSERT INTO public.cidade VALUES (497, 'João Dourado', 5);
INSERT INTO public.cidade VALUES (498, 'Juazeiro', 5);
INSERT INTO public.cidade VALUES (499, 'Jucuruçu', 5);
INSERT INTO public.cidade VALUES (500, 'Jussara', 5);
INSERT INTO public.cidade VALUES (501, 'Jussari', 5);
INSERT INTO public.cidade VALUES (502, 'Jussiape', 5);
INSERT INTO public.cidade VALUES (503, 'Lafaiete Coutinho', 5);
INSERT INTO public.cidade VALUES (504, 'Lagoa Real', 5);
INSERT INTO public.cidade VALUES (505, 'Laje', 5);
INSERT INTO public.cidade VALUES (506, 'Lajedão', 5);
INSERT INTO public.cidade VALUES (507, 'Lajedinho', 5);
INSERT INTO public.cidade VALUES (508, 'Lajedo do Tabocal', 5);
INSERT INTO public.cidade VALUES (509, 'Lamarão', 5);
INSERT INTO public.cidade VALUES (510, 'Lapão', 5);
INSERT INTO public.cidade VALUES (511, 'Lauro de Freitas', 5);
INSERT INTO public.cidade VALUES (512, 'Lençóis', 5);
INSERT INTO public.cidade VALUES (513, 'Licínio de Almeida', 5);
INSERT INTO public.cidade VALUES (514, 'Livramento de Nossa Senhora', 5);
INSERT INTO public.cidade VALUES (515, 'Luís Eduardo Magalhães', 5);
INSERT INTO public.cidade VALUES (516, 'Macajuba', 5);
INSERT INTO public.cidade VALUES (517, 'Macarani', 5);
INSERT INTO public.cidade VALUES (518, 'Macaúbas', 5);
INSERT INTO public.cidade VALUES (519, 'Macururé', 5);
INSERT INTO public.cidade VALUES (520, 'Madre de Deus', 5);
INSERT INTO public.cidade VALUES (521, 'Maetinga', 5);
INSERT INTO public.cidade VALUES (522, 'Maiquinique', 5);
INSERT INTO public.cidade VALUES (523, 'Mairi', 5);
INSERT INTO public.cidade VALUES (524, 'Malhada', 5);
INSERT INTO public.cidade VALUES (525, 'Malhada de Pedras', 5);
INSERT INTO public.cidade VALUES (526, 'Manoel Vitorino', 5);
INSERT INTO public.cidade VALUES (527, 'Mansidão', 5);
INSERT INTO public.cidade VALUES (528, 'Maracás', 5);
INSERT INTO public.cidade VALUES (529, 'Maragogipe', 5);
INSERT INTO public.cidade VALUES (530, 'Maraú', 5);
INSERT INTO public.cidade VALUES (531, 'Marcionílio Souza', 5);
INSERT INTO public.cidade VALUES (532, 'Mascote', 5);
INSERT INTO public.cidade VALUES (533, 'Mata de São João', 5);
INSERT INTO public.cidade VALUES (534, 'Matina', 5);
INSERT INTO public.cidade VALUES (535, 'Medeiros Neto', 5);
INSERT INTO public.cidade VALUES (536, 'Miguel Calmon', 5);
INSERT INTO public.cidade VALUES (537, 'Milagres', 5);
INSERT INTO public.cidade VALUES (538, 'Mirangaba', 5);
INSERT INTO public.cidade VALUES (539, 'Mirante', 5);
INSERT INTO public.cidade VALUES (540, 'Monte Santo', 5);
INSERT INTO public.cidade VALUES (541, 'Morpará', 5);
INSERT INTO public.cidade VALUES (542, 'Morro do Chapéu', 5);
INSERT INTO public.cidade VALUES (543, 'Mortugaba', 5);
INSERT INTO public.cidade VALUES (544, 'Mucugê', 5);
INSERT INTO public.cidade VALUES (545, 'Mucuri', 5);
INSERT INTO public.cidade VALUES (546, 'Mulungu do Morro', 5);
INSERT INTO public.cidade VALUES (547, 'Mundo Novo', 5);
INSERT INTO public.cidade VALUES (548, 'Muniz Ferreira', 5);
INSERT INTO public.cidade VALUES (549, 'Muquém de São Francisco', 5);
INSERT INTO public.cidade VALUES (550, 'Muritiba', 5);
INSERT INTO public.cidade VALUES (551, 'Mutuípe', 5);
INSERT INTO public.cidade VALUES (552, 'Nazaré', 5);
INSERT INTO public.cidade VALUES (553, 'Nilo Peçanha', 5);
INSERT INTO public.cidade VALUES (554, 'Nordestina', 5);
INSERT INTO public.cidade VALUES (555, 'Nova Canaã', 5);
INSERT INTO public.cidade VALUES (556, 'Nova Fátima', 5);
INSERT INTO public.cidade VALUES (557, 'Nova Ibiá', 5);
INSERT INTO public.cidade VALUES (558, 'Nova Itarana', 5);
INSERT INTO public.cidade VALUES (559, 'Nova Redenção', 5);
INSERT INTO public.cidade VALUES (560, 'Nova Soure', 5);
INSERT INTO public.cidade VALUES (561, 'Nova Viçosa', 5);
INSERT INTO public.cidade VALUES (562, 'Novo Horizonte', 5);
INSERT INTO public.cidade VALUES (563, 'Novo Triunfo', 5);
INSERT INTO public.cidade VALUES (564, 'Olindina', 5);
INSERT INTO public.cidade VALUES (565, 'Oliveira dos Brejinhos', 5);
INSERT INTO public.cidade VALUES (566, 'Ouriçangas', 5);
INSERT INTO public.cidade VALUES (567, 'Ourolândia', 5);
INSERT INTO public.cidade VALUES (568, 'Palmas de Monte Alto', 5);
INSERT INTO public.cidade VALUES (569, 'Palmeiras', 5);
INSERT INTO public.cidade VALUES (570, 'Paramirim', 5);
INSERT INTO public.cidade VALUES (571, 'Paratinga', 5);
INSERT INTO public.cidade VALUES (572, 'Paripiranga', 5);
INSERT INTO public.cidade VALUES (573, 'Pau Brasil', 5);
INSERT INTO public.cidade VALUES (574, 'Paulo Afonso', 5);
INSERT INTO public.cidade VALUES (575, 'Pé de Serra', 5);
INSERT INTO public.cidade VALUES (576, 'Pedrão', 5);
INSERT INTO public.cidade VALUES (577, 'Pedro Alexandre', 5);
INSERT INTO public.cidade VALUES (578, 'Piatã', 5);
INSERT INTO public.cidade VALUES (579, 'Pilão Arcado', 5);
INSERT INTO public.cidade VALUES (580, 'Pindaí', 5);
INSERT INTO public.cidade VALUES (581, 'Pindobaçu', 5);
INSERT INTO public.cidade VALUES (582, 'Pintadas', 5);
INSERT INTO public.cidade VALUES (583, 'Piraí do Norte', 5);
INSERT INTO public.cidade VALUES (584, 'Piripá', 5);
INSERT INTO public.cidade VALUES (585, 'Piritiba', 5);
INSERT INTO public.cidade VALUES (586, 'Planaltino', 5);
INSERT INTO public.cidade VALUES (587, 'Planalto', 5);
INSERT INTO public.cidade VALUES (588, 'Poções', 5);
INSERT INTO public.cidade VALUES (589, 'Pojuca', 5);
INSERT INTO public.cidade VALUES (590, 'Ponto Novo', 5);
INSERT INTO public.cidade VALUES (591, 'Porto Seguro', 5);
INSERT INTO public.cidade VALUES (592, 'Potiraguá', 5);
INSERT INTO public.cidade VALUES (593, 'Prado', 5);
INSERT INTO public.cidade VALUES (594, 'Presidente Dutra', 5);
INSERT INTO public.cidade VALUES (595, 'Presidente Jânio Quadros', 5);
INSERT INTO public.cidade VALUES (596, 'Presidente Tancredo Neves', 5);
INSERT INTO public.cidade VALUES (597, 'Queimadas', 5);
INSERT INTO public.cidade VALUES (598, 'Quijingue', 5);
INSERT INTO public.cidade VALUES (599, 'Quixabeira', 5);
INSERT INTO public.cidade VALUES (600, 'Rafael Jambeiro', 5);
INSERT INTO public.cidade VALUES (601, 'Remanso', 5);
INSERT INTO public.cidade VALUES (602, 'Retirolândia', 5);
INSERT INTO public.cidade VALUES (603, 'Riachão das Neves', 5);
INSERT INTO public.cidade VALUES (604, 'Riachão do Jacuípe', 5);
INSERT INTO public.cidade VALUES (605, 'Riacho de Santana', 5);
INSERT INTO public.cidade VALUES (606, 'Ribeira do Amparo', 5);
INSERT INTO public.cidade VALUES (607, 'Ribeira do Pombal', 5);
INSERT INTO public.cidade VALUES (608, 'Ribeirão do Largo', 5);
INSERT INTO public.cidade VALUES (609, 'Rio de Contas', 5);
INSERT INTO public.cidade VALUES (610, 'Rio do Antônio', 5);
INSERT INTO public.cidade VALUES (611, 'Rio do Pires', 5);
INSERT INTO public.cidade VALUES (612, 'Rio Real', 5);
INSERT INTO public.cidade VALUES (613, 'Rodelas', 5);
INSERT INTO public.cidade VALUES (614, 'Ruy Barbosa', 5);
INSERT INTO public.cidade VALUES (615, 'Salinas da Margarida', 5);
INSERT INTO public.cidade VALUES (616, 'Salvador', 5);
INSERT INTO public.cidade VALUES (617, 'Santa Bárbara', 5);
INSERT INTO public.cidade VALUES (618, 'Santa Brígida', 5);
INSERT INTO public.cidade VALUES (619, 'Santa Cruz Cabrália', 5);
INSERT INTO public.cidade VALUES (620, 'Santa Cruz da Vitória', 5);
INSERT INTO public.cidade VALUES (621, 'Santa Inês', 5);
INSERT INTO public.cidade VALUES (622, 'Santa Luzia', 5);
INSERT INTO public.cidade VALUES (623, 'Santa Maria da Vitória', 5);
INSERT INTO public.cidade VALUES (624, 'Santa Rita de Cássia', 5);
INSERT INTO public.cidade VALUES (625, 'Santa Teresinha', 5);
INSERT INTO public.cidade VALUES (626, 'Santaluz', 5);
INSERT INTO public.cidade VALUES (627, 'Santana', 5);
INSERT INTO public.cidade VALUES (628, 'Santanópolis', 5);
INSERT INTO public.cidade VALUES (629, 'Santo Amaro', 5);
INSERT INTO public.cidade VALUES (630, 'Santo Antônio de Jesus', 5);
INSERT INTO public.cidade VALUES (631, 'Santo Estêvão', 5);
INSERT INTO public.cidade VALUES (632, 'São Desidério', 5);
INSERT INTO public.cidade VALUES (633, 'São Domingos', 5);
INSERT INTO public.cidade VALUES (634, 'São Felipe', 5);
INSERT INTO public.cidade VALUES (635, 'São Félix', 5);
INSERT INTO public.cidade VALUES (636, 'São Félix do Coribe', 5);
INSERT INTO public.cidade VALUES (637, 'São Francisco do Conde', 5);
INSERT INTO public.cidade VALUES (638, 'São Gabriel', 5);
INSERT INTO public.cidade VALUES (639, 'São Gonçalo dos Campos', 5);
INSERT INTO public.cidade VALUES (640, 'São José da Vitória', 5);
INSERT INTO public.cidade VALUES (641, 'São José do Jacuípe', 5);
INSERT INTO public.cidade VALUES (642, 'São Miguel das Matas', 5);
INSERT INTO public.cidade VALUES (643, 'São Sebastião do Passé', 5);
INSERT INTO public.cidade VALUES (644, 'Sapeaçu', 5);
INSERT INTO public.cidade VALUES (645, 'Sátiro Dias', 5);
INSERT INTO public.cidade VALUES (646, 'Saubara', 5);
INSERT INTO public.cidade VALUES (647, 'Saúde', 5);
INSERT INTO public.cidade VALUES (648, 'Seabra', 5);
INSERT INTO public.cidade VALUES (649, 'Sebastião Laranjeiras', 5);
INSERT INTO public.cidade VALUES (650, 'Senhor do Bonfim', 5);
INSERT INTO public.cidade VALUES (651, 'Sento Sé', 5);
INSERT INTO public.cidade VALUES (652, 'Serra do Ramalho', 5);
INSERT INTO public.cidade VALUES (653, 'Serra Dourada', 5);
INSERT INTO public.cidade VALUES (654, 'Serra Preta', 5);
INSERT INTO public.cidade VALUES (655, 'Serrinha', 5);
INSERT INTO public.cidade VALUES (656, 'Serrolândia', 5);
INSERT INTO public.cidade VALUES (657, 'Simões Filho', 5);
INSERT INTO public.cidade VALUES (658, 'Sítio do Mato', 5);
INSERT INTO public.cidade VALUES (659, 'Sítio do Quinto', 5);
INSERT INTO public.cidade VALUES (660, 'Sobradinho', 5);
INSERT INTO public.cidade VALUES (661, 'Souto Soares', 5);
INSERT INTO public.cidade VALUES (662, 'Tabocas do Brejo Velho', 5);
INSERT INTO public.cidade VALUES (663, 'Tanhaçu', 5);
INSERT INTO public.cidade VALUES (664, 'Tanque Novo', 5);
INSERT INTO public.cidade VALUES (665, 'Tanquinho', 5);
INSERT INTO public.cidade VALUES (666, 'Taperoá', 5);
INSERT INTO public.cidade VALUES (667, 'Tapiramutá', 5);
INSERT INTO public.cidade VALUES (668, 'Teixeira de Freitas', 5);
INSERT INTO public.cidade VALUES (669, 'Teodoro Sampaio', 5);
INSERT INTO public.cidade VALUES (670, 'Teofilândia', 5);
INSERT INTO public.cidade VALUES (671, 'Teolândia', 5);
INSERT INTO public.cidade VALUES (672, 'Terra Nova', 5);
INSERT INTO public.cidade VALUES (673, 'Tremedal', 5);
INSERT INTO public.cidade VALUES (674, 'Tucano', 5);
INSERT INTO public.cidade VALUES (675, 'Uauá', 5);
INSERT INTO public.cidade VALUES (676, 'Ubaíra', 5);
INSERT INTO public.cidade VALUES (677, 'Ubaitaba', 5);
INSERT INTO public.cidade VALUES (678, 'Ubatã', 5);
INSERT INTO public.cidade VALUES (679, 'Uibaí', 5);
INSERT INTO public.cidade VALUES (680, 'Umburanas', 5);
INSERT INTO public.cidade VALUES (681, 'Una', 5);
INSERT INTO public.cidade VALUES (682, 'Urandi', 5);
INSERT INTO public.cidade VALUES (683, 'Uruçuca', 5);
INSERT INTO public.cidade VALUES (684, 'Utinga', 5);
INSERT INTO public.cidade VALUES (685, 'Valença', 5);
INSERT INTO public.cidade VALUES (686, 'Valente', 5);
INSERT INTO public.cidade VALUES (687, 'Várzea da Roça', 5);
INSERT INTO public.cidade VALUES (688, 'Várzea do Poço', 5);
INSERT INTO public.cidade VALUES (689, 'Várzea Nova', 5);
INSERT INTO public.cidade VALUES (690, 'Varzedo', 5);
INSERT INTO public.cidade VALUES (691, 'Vera Cruz', 5);
INSERT INTO public.cidade VALUES (692, 'Vereda', 5);
INSERT INTO public.cidade VALUES (693, 'Vitória da Conquista', 5);
INSERT INTO public.cidade VALUES (694, 'Wagner', 5);
INSERT INTO public.cidade VALUES (695, 'Wanderley', 5);
INSERT INTO public.cidade VALUES (696, 'Wenceslau Guimarães', 5);
INSERT INTO public.cidade VALUES (697, 'Xique-Xique', 5);
INSERT INTO public.cidade VALUES (698, 'Abaiara', 6);
INSERT INTO public.cidade VALUES (699, 'Acarape', 6);
INSERT INTO public.cidade VALUES (700, 'Acaraú', 6);
INSERT INTO public.cidade VALUES (701, 'Acopiara', 6);
INSERT INTO public.cidade VALUES (702, 'Aiuaba', 6);
INSERT INTO public.cidade VALUES (703, 'Alcântaras', 6);
INSERT INTO public.cidade VALUES (704, 'Altaneira', 6);
INSERT INTO public.cidade VALUES (705, 'Alto Santo', 6);
INSERT INTO public.cidade VALUES (706, 'Amontada', 6);
INSERT INTO public.cidade VALUES (707, 'Antonina do Norte', 6);
INSERT INTO public.cidade VALUES (708, 'Apuiarés', 6);
INSERT INTO public.cidade VALUES (709, 'Aquiraz', 6);
INSERT INTO public.cidade VALUES (710, 'Aracati', 6);
INSERT INTO public.cidade VALUES (711, 'Aracoiaba', 6);
INSERT INTO public.cidade VALUES (712, 'Ararendá', 6);
INSERT INTO public.cidade VALUES (713, 'Araripe', 6);
INSERT INTO public.cidade VALUES (714, 'Aratuba', 6);
INSERT INTO public.cidade VALUES (715, 'Arneiroz', 6);
INSERT INTO public.cidade VALUES (716, 'Assaré', 6);
INSERT INTO public.cidade VALUES (717, 'Aurora', 6);
INSERT INTO public.cidade VALUES (718, 'Baixio', 6);
INSERT INTO public.cidade VALUES (719, 'Banabuiú', 6);
INSERT INTO public.cidade VALUES (720, 'Barbalha', 6);
INSERT INTO public.cidade VALUES (721, 'Barreira', 6);
INSERT INTO public.cidade VALUES (722, 'Barro', 6);
INSERT INTO public.cidade VALUES (723, 'Barroquinha', 6);
INSERT INTO public.cidade VALUES (724, 'Baturité', 6);
INSERT INTO public.cidade VALUES (725, 'Beberibe', 6);
INSERT INTO public.cidade VALUES (726, 'Bela Cruz', 6);
INSERT INTO public.cidade VALUES (727, 'Boa Viagem', 6);
INSERT INTO public.cidade VALUES (728, 'Brejo Santo', 6);
INSERT INTO public.cidade VALUES (729, 'Camocim', 6);
INSERT INTO public.cidade VALUES (730, 'Campos Sales', 6);
INSERT INTO public.cidade VALUES (731, 'Canindé', 6);
INSERT INTO public.cidade VALUES (732, 'Capistrano', 6);
INSERT INTO public.cidade VALUES (733, 'Caridade', 6);
INSERT INTO public.cidade VALUES (734, 'Cariré', 6);
INSERT INTO public.cidade VALUES (735, 'Caririaçu', 6);
INSERT INTO public.cidade VALUES (736, 'Cariús', 6);
INSERT INTO public.cidade VALUES (737, 'Carnaubal', 6);
INSERT INTO public.cidade VALUES (738, 'Cascavel', 6);
INSERT INTO public.cidade VALUES (739, 'Catarina', 6);
INSERT INTO public.cidade VALUES (740, 'Catunda', 6);
INSERT INTO public.cidade VALUES (741, 'Caucaia', 6);
INSERT INTO public.cidade VALUES (742, 'Cedro', 6);
INSERT INTO public.cidade VALUES (743, 'Chaval', 6);
INSERT INTO public.cidade VALUES (744, 'Choró', 6);
INSERT INTO public.cidade VALUES (745, 'Chorozinho', 6);
INSERT INTO public.cidade VALUES (746, 'Coreaú', 6);
INSERT INTO public.cidade VALUES (747, 'Crateús', 6);
INSERT INTO public.cidade VALUES (748, 'Crato', 6);
INSERT INTO public.cidade VALUES (749, 'Croatá', 6);
INSERT INTO public.cidade VALUES (750, 'Cruz', 6);
INSERT INTO public.cidade VALUES (751, 'Deputado Irapuan Pinheiro', 6);
INSERT INTO public.cidade VALUES (752, 'Ererê', 6);
INSERT INTO public.cidade VALUES (753, 'Eusébio', 6);
INSERT INTO public.cidade VALUES (754, 'Farias Brito', 6);
INSERT INTO public.cidade VALUES (755, 'Forquilha', 6);
INSERT INTO public.cidade VALUES (756, 'Fortaleza', 6);
INSERT INTO public.cidade VALUES (757, 'Fortim', 6);
INSERT INTO public.cidade VALUES (758, 'Frecheirinha', 6);
INSERT INTO public.cidade VALUES (759, 'General Sampaio', 6);
INSERT INTO public.cidade VALUES (760, 'Graça', 6);
INSERT INTO public.cidade VALUES (761, 'Granja', 6);
INSERT INTO public.cidade VALUES (762, 'Granjeiro', 6);
INSERT INTO public.cidade VALUES (763, 'Groaíras', 6);
INSERT INTO public.cidade VALUES (764, 'Guaiúba', 6);
INSERT INTO public.cidade VALUES (765, 'Guaraciaba do Norte', 6);
INSERT INTO public.cidade VALUES (766, 'Guaramiranga', 6);
INSERT INTO public.cidade VALUES (767, 'Hidrolândia', 6);
INSERT INTO public.cidade VALUES (768, 'Horizonte', 6);
INSERT INTO public.cidade VALUES (769, 'Ibaretama', 6);
INSERT INTO public.cidade VALUES (770, 'Ibiapina', 6);
INSERT INTO public.cidade VALUES (771, 'Ibicuitinga', 6);
INSERT INTO public.cidade VALUES (772, 'Icapuí', 6);
INSERT INTO public.cidade VALUES (773, 'Icó', 6);
INSERT INTO public.cidade VALUES (774, 'Iguatu', 6);
INSERT INTO public.cidade VALUES (775, 'Independência', 6);
INSERT INTO public.cidade VALUES (776, 'Ipaporanga', 6);
INSERT INTO public.cidade VALUES (777, 'Ipaumirim', 6);
INSERT INTO public.cidade VALUES (778, 'Ipu', 6);
INSERT INTO public.cidade VALUES (779, 'Ipueiras', 6);
INSERT INTO public.cidade VALUES (780, 'Iracema', 6);
INSERT INTO public.cidade VALUES (781, 'Irauçuba', 6);
INSERT INTO public.cidade VALUES (782, 'Itaiçaba', 6);
INSERT INTO public.cidade VALUES (783, 'Itaitinga', 6);
INSERT INTO public.cidade VALUES (784, 'Itapagé', 6);
INSERT INTO public.cidade VALUES (785, 'Itapipoca', 6);
INSERT INTO public.cidade VALUES (786, 'Itapiúna', 6);
INSERT INTO public.cidade VALUES (787, 'Itarema', 6);
INSERT INTO public.cidade VALUES (788, 'Itatira', 6);
INSERT INTO public.cidade VALUES (789, 'Jaguaretama', 6);
INSERT INTO public.cidade VALUES (790, 'Jaguaribara', 6);
INSERT INTO public.cidade VALUES (791, 'Jaguaribe', 6);
INSERT INTO public.cidade VALUES (792, 'Jaguaruana', 6);
INSERT INTO public.cidade VALUES (793, 'Jardim', 6);
INSERT INTO public.cidade VALUES (794, 'Jati', 6);
INSERT INTO public.cidade VALUES (795, 'Jijoca de Jericoacoara', 6);
INSERT INTO public.cidade VALUES (796, 'Juazeiro do Norte', 6);
INSERT INTO public.cidade VALUES (797, 'Jucás', 6);
INSERT INTO public.cidade VALUES (798, 'Lavras da Mangabeira', 6);
INSERT INTO public.cidade VALUES (799, 'Limoeiro do Norte', 6);
INSERT INTO public.cidade VALUES (800, 'Madalena', 6);
INSERT INTO public.cidade VALUES (801, 'Maracanaú', 6);
INSERT INTO public.cidade VALUES (802, 'Maranguape', 6);
INSERT INTO public.cidade VALUES (803, 'Marco', 6);
INSERT INTO public.cidade VALUES (804, 'Martinópole', 6);
INSERT INTO public.cidade VALUES (805, 'Massapê', 6);
INSERT INTO public.cidade VALUES (806, 'Mauriti', 6);
INSERT INTO public.cidade VALUES (807, 'Meruoca', 6);
INSERT INTO public.cidade VALUES (808, 'Milagres', 6);
INSERT INTO public.cidade VALUES (809, 'Milhã', 6);
INSERT INTO public.cidade VALUES (810, 'Miraíma', 6);
INSERT INTO public.cidade VALUES (811, 'Missão Velha', 6);
INSERT INTO public.cidade VALUES (812, 'Mombaça', 6);
INSERT INTO public.cidade VALUES (813, 'Monsenhor Tabosa', 6);
INSERT INTO public.cidade VALUES (814, 'Morada Nova', 6);
INSERT INTO public.cidade VALUES (815, 'Moraújo', 6);
INSERT INTO public.cidade VALUES (816, 'Morrinhos', 6);
INSERT INTO public.cidade VALUES (817, 'Mucambo', 6);
INSERT INTO public.cidade VALUES (818, 'Mulungu', 6);
INSERT INTO public.cidade VALUES (819, 'Nova Olinda', 6);
INSERT INTO public.cidade VALUES (820, 'Nova Russas', 6);
INSERT INTO public.cidade VALUES (821, 'Novo Oriente', 6);
INSERT INTO public.cidade VALUES (822, 'Ocara', 6);
INSERT INTO public.cidade VALUES (823, 'Orós', 6);
INSERT INTO public.cidade VALUES (824, 'Pacajus', 6);
INSERT INTO public.cidade VALUES (825, 'Pacatuba', 6);
INSERT INTO public.cidade VALUES (826, 'Pacoti', 6);
INSERT INTO public.cidade VALUES (827, 'Pacujá', 6);
INSERT INTO public.cidade VALUES (828, 'Palhano', 6);
INSERT INTO public.cidade VALUES (829, 'Palmácia', 6);
INSERT INTO public.cidade VALUES (830, 'Paracuru', 6);
INSERT INTO public.cidade VALUES (831, 'Paraipaba', 6);
INSERT INTO public.cidade VALUES (832, 'Parambu', 6);
INSERT INTO public.cidade VALUES (833, 'Paramoti', 6);
INSERT INTO public.cidade VALUES (834, 'Pedra Branca', 6);
INSERT INTO public.cidade VALUES (835, 'Penaforte', 6);
INSERT INTO public.cidade VALUES (836, 'Pentecoste', 6);
INSERT INTO public.cidade VALUES (837, 'Pereiro', 6);
INSERT INTO public.cidade VALUES (838, 'Pindoretama', 6);
INSERT INTO public.cidade VALUES (839, 'Piquet Carneiro', 6);
INSERT INTO public.cidade VALUES (840, 'Pires Ferreira', 6);
INSERT INTO public.cidade VALUES (841, 'Poranga', 6);
INSERT INTO public.cidade VALUES (842, 'Porteiras', 6);
INSERT INTO public.cidade VALUES (843, 'Potengi', 6);
INSERT INTO public.cidade VALUES (844, 'Potiretama', 6);
INSERT INTO public.cidade VALUES (845, 'Quiterianópolis', 6);
INSERT INTO public.cidade VALUES (846, 'Quixadá', 6);
INSERT INTO public.cidade VALUES (847, 'Quixelô', 6);
INSERT INTO public.cidade VALUES (848, 'Quixeramobim', 6);
INSERT INTO public.cidade VALUES (849, 'Quixeré', 6);
INSERT INTO public.cidade VALUES (850, 'Redenção', 6);
INSERT INTO public.cidade VALUES (851, 'Reriutaba', 6);
INSERT INTO public.cidade VALUES (852, 'Russas', 6);
INSERT INTO public.cidade VALUES (853, 'Saboeiro', 6);
INSERT INTO public.cidade VALUES (854, 'Salitre', 6);
INSERT INTO public.cidade VALUES (855, 'Santa Quitéria', 6);
INSERT INTO public.cidade VALUES (856, 'Santana do Acaraú', 6);
INSERT INTO public.cidade VALUES (857, 'Santana do Cariri', 6);
INSERT INTO public.cidade VALUES (858, 'São Benedito', 6);
INSERT INTO public.cidade VALUES (859, 'São Gonçalo do Amarante', 6);
INSERT INTO public.cidade VALUES (860, 'São João do Jaguaribe', 6);
INSERT INTO public.cidade VALUES (861, 'São Luís do Curu', 6);
INSERT INTO public.cidade VALUES (862, 'Senador Pompeu', 6);
INSERT INTO public.cidade VALUES (863, 'Senador Sá', 6);
INSERT INTO public.cidade VALUES (864, 'Sobral', 6);
INSERT INTO public.cidade VALUES (865, 'Solonópole', 6);
INSERT INTO public.cidade VALUES (866, 'Tabuleiro do Norte', 6);
INSERT INTO public.cidade VALUES (867, 'Tamboril', 6);
INSERT INTO public.cidade VALUES (868, 'Tarrafas', 6);
INSERT INTO public.cidade VALUES (869, 'Tauá', 6);
INSERT INTO public.cidade VALUES (870, 'Tejuçuoca', 6);
INSERT INTO public.cidade VALUES (871, 'Tianguá', 6);
INSERT INTO public.cidade VALUES (872, 'Trairi', 6);
INSERT INTO public.cidade VALUES (873, 'Tururu', 6);
INSERT INTO public.cidade VALUES (874, 'Ubajara', 6);
INSERT INTO public.cidade VALUES (875, 'Umari', 6);
INSERT INTO public.cidade VALUES (876, 'Umirim', 6);
INSERT INTO public.cidade VALUES (877, 'Uruburetama', 6);
INSERT INTO public.cidade VALUES (878, 'Uruoca', 6);
INSERT INTO public.cidade VALUES (879, 'Varjota', 6);
INSERT INTO public.cidade VALUES (880, 'Várzea Alegre', 6);
INSERT INTO public.cidade VALUES (881, 'Viçosa do Ceará', 6);
INSERT INTO public.cidade VALUES (882, 'Brasília', 7);
INSERT INTO public.cidade VALUES (883, 'Abadia de Goiás', 9);
INSERT INTO public.cidade VALUES (884, 'Abadiânia', 9);
INSERT INTO public.cidade VALUES (885, 'Acreúna', 9);
INSERT INTO public.cidade VALUES (886, 'Adelândia', 9);
INSERT INTO public.cidade VALUES (887, 'Água Fria de Goiás', 9);
INSERT INTO public.cidade VALUES (888, 'Água Limpa', 9);
INSERT INTO public.cidade VALUES (889, 'Águas Lindas de Goiás', 9);
INSERT INTO public.cidade VALUES (890, 'Alexânia', 9);
INSERT INTO public.cidade VALUES (891, 'Aloândia', 9);
INSERT INTO public.cidade VALUES (892, 'Alto Horizonte', 9);
INSERT INTO public.cidade VALUES (893, 'Alto Paraíso de Goiás', 9);
INSERT INTO public.cidade VALUES (894, 'Alvorada do Norte', 9);
INSERT INTO public.cidade VALUES (895, 'Amaralina', 9);
INSERT INTO public.cidade VALUES (896, 'Americano do Brasil', 9);
INSERT INTO public.cidade VALUES (897, 'Amorinópolis', 9);
INSERT INTO public.cidade VALUES (898, 'Anápolis', 9);
INSERT INTO public.cidade VALUES (899, 'Anhanguera', 9);
INSERT INTO public.cidade VALUES (900, 'Anicuns', 9);
INSERT INTO public.cidade VALUES (901, 'Aparecida de Goiânia', 9);
INSERT INTO public.cidade VALUES (902, 'Aparecida do Rio Doce', 9);
INSERT INTO public.cidade VALUES (903, 'Aporé', 9);
INSERT INTO public.cidade VALUES (904, 'Araçu', 9);
INSERT INTO public.cidade VALUES (905, 'Aragarças', 9);
INSERT INTO public.cidade VALUES (906, 'Aragoiânia', 9);
INSERT INTO public.cidade VALUES (907, 'Araguapaz', 9);
INSERT INTO public.cidade VALUES (908, 'Arenópolis', 9);
INSERT INTO public.cidade VALUES (909, 'Aruanã', 9);
INSERT INTO public.cidade VALUES (910, 'Aurilândia', 9);
INSERT INTO public.cidade VALUES (911, 'Avelinópolis', 9);
INSERT INTO public.cidade VALUES (912, 'Baliza', 9);
INSERT INTO public.cidade VALUES (913, 'Barro Alto', 9);
INSERT INTO public.cidade VALUES (914, 'Bela Vista de Goiás', 9);
INSERT INTO public.cidade VALUES (915, 'Bom Jardim de Goiás', 9);
INSERT INTO public.cidade VALUES (916, 'Bom Jesus de Goiás', 9);
INSERT INTO public.cidade VALUES (917, 'Bonfinópolis', 9);
INSERT INTO public.cidade VALUES (918, 'Bonópolis', 9);
INSERT INTO public.cidade VALUES (919, 'Brazabrantes', 9);
INSERT INTO public.cidade VALUES (920, 'Britânia', 9);
INSERT INTO public.cidade VALUES (921, 'Buriti Alegre', 9);
INSERT INTO public.cidade VALUES (922, 'Buriti de Goiás', 9);
INSERT INTO public.cidade VALUES (923, 'Buritinópolis', 9);
INSERT INTO public.cidade VALUES (924, 'Cabeceiras', 9);
INSERT INTO public.cidade VALUES (925, 'Cachoeira Alta', 9);
INSERT INTO public.cidade VALUES (926, 'Cachoeira de Goiás', 9);
INSERT INTO public.cidade VALUES (927, 'Cachoeira Dourada', 9);
INSERT INTO public.cidade VALUES (928, 'Caçu', 9);
INSERT INTO public.cidade VALUES (929, 'Caiapônia', 9);
INSERT INTO public.cidade VALUES (930, 'Caldas Novas', 9);
INSERT INTO public.cidade VALUES (931, 'Caldazinha', 9);
INSERT INTO public.cidade VALUES (932, 'Campestre de Goiás', 9);
INSERT INTO public.cidade VALUES (933, 'Campinaçu', 9);
INSERT INTO public.cidade VALUES (934, 'Campinorte', 9);
INSERT INTO public.cidade VALUES (935, 'Campo Alegre de Goiás', 9);
INSERT INTO public.cidade VALUES (936, 'Campo Limpo de Goiás', 9);
INSERT INTO public.cidade VALUES (937, 'Campos Belos', 9);
INSERT INTO public.cidade VALUES (938, 'Campos Verdes', 9);
INSERT INTO public.cidade VALUES (939, 'Carmo do Rio Verde', 9);
INSERT INTO public.cidade VALUES (940, 'Castelândia', 9);
INSERT INTO public.cidade VALUES (941, 'Catalão', 9);
INSERT INTO public.cidade VALUES (942, 'Caturaí', 9);
INSERT INTO public.cidade VALUES (943, 'Cavalcante', 9);
INSERT INTO public.cidade VALUES (944, 'Ceres', 9);
INSERT INTO public.cidade VALUES (945, 'Cezarina', 9);
INSERT INTO public.cidade VALUES (946, 'Chapadão do Céu', 9);
INSERT INTO public.cidade VALUES (947, 'Cidade Ocidental', 9);
INSERT INTO public.cidade VALUES (948, 'Cocalzinho de Goiás', 9);
INSERT INTO public.cidade VALUES (949, 'Colinas do Sul', 9);
INSERT INTO public.cidade VALUES (950, 'Córrego do Ouro', 9);
INSERT INTO public.cidade VALUES (951, 'Corumbá de Goiás', 9);
INSERT INTO public.cidade VALUES (952, 'Corumbaíba', 9);
INSERT INTO public.cidade VALUES (953, 'Cristalina', 9);
INSERT INTO public.cidade VALUES (954, 'Cristianópolis', 9);
INSERT INTO public.cidade VALUES (955, 'Crixás', 9);
INSERT INTO public.cidade VALUES (956, 'Cromínia', 9);
INSERT INTO public.cidade VALUES (957, 'Cumari', 9);
INSERT INTO public.cidade VALUES (958, 'Damianópolis', 9);
INSERT INTO public.cidade VALUES (959, 'Damolândia', 9);
INSERT INTO public.cidade VALUES (960, 'Davinópolis', 9);
INSERT INTO public.cidade VALUES (961, 'Diorama', 9);
INSERT INTO public.cidade VALUES (962, 'Divinópolis de Goiás', 9);
INSERT INTO public.cidade VALUES (963, 'Doverlândia', 9);
INSERT INTO public.cidade VALUES (964, 'Edealina', 9);
INSERT INTO public.cidade VALUES (965, 'Edéia', 9);
INSERT INTO public.cidade VALUES (966, 'Estrela do Norte', 9);
INSERT INTO public.cidade VALUES (967, 'Faina', 9);
INSERT INTO public.cidade VALUES (968, 'Fazenda Nova', 9);
INSERT INTO public.cidade VALUES (969, 'Firminópolis', 9);
INSERT INTO public.cidade VALUES (970, 'Flores de Goiás', 9);
INSERT INTO public.cidade VALUES (971, 'Formosa', 9);
INSERT INTO public.cidade VALUES (972, 'Formoso', 9);
INSERT INTO public.cidade VALUES (973, 'Gameleira de Goiás', 9);
INSERT INTO public.cidade VALUES (974, 'Goianápolis', 9);
INSERT INTO public.cidade VALUES (975, 'Goiandira', 9);
INSERT INTO public.cidade VALUES (976, 'Goianésia', 9);
INSERT INTO public.cidade VALUES (977, 'Goiânia', 9);
INSERT INTO public.cidade VALUES (978, 'Goianira', 9);
INSERT INTO public.cidade VALUES (979, 'Goiás', 9);
INSERT INTO public.cidade VALUES (980, 'Goiatuba', 9);
INSERT INTO public.cidade VALUES (981, 'Gouvelândia', 9);
INSERT INTO public.cidade VALUES (982, 'Guapó', 9);
INSERT INTO public.cidade VALUES (983, 'Guaraíta', 9);
INSERT INTO public.cidade VALUES (984, 'Guarani de Goiás', 9);
INSERT INTO public.cidade VALUES (985, 'Guarinos', 9);
INSERT INTO public.cidade VALUES (986, 'Heitoraí', 9);
INSERT INTO public.cidade VALUES (987, 'Hidrolândia', 9);
INSERT INTO public.cidade VALUES (988, 'Hidrolina', 9);
INSERT INTO public.cidade VALUES (989, 'Iaciara', 9);
INSERT INTO public.cidade VALUES (990, 'Inaciolândia', 9);
INSERT INTO public.cidade VALUES (991, 'Indiara', 9);
INSERT INTO public.cidade VALUES (992, 'Inhumas', 9);
INSERT INTO public.cidade VALUES (993, 'Ipameri', 9);
INSERT INTO public.cidade VALUES (994, 'Ipiranga de Goiás', 9);
INSERT INTO public.cidade VALUES (995, 'Iporá', 9);
INSERT INTO public.cidade VALUES (996, 'Israelândia', 9);
INSERT INTO public.cidade VALUES (997, 'Itaberaí', 9);
INSERT INTO public.cidade VALUES (998, 'Itaguari', 9);
INSERT INTO public.cidade VALUES (999, 'Itaguaru', 9);
INSERT INTO public.cidade VALUES (1000, 'Itajá', 9);
INSERT INTO public.cidade VALUES (1001, 'Itapaci', 9);
INSERT INTO public.cidade VALUES (1002, 'Itapirapuã', 9);
INSERT INTO public.cidade VALUES (1003, 'Itapuranga', 9);
INSERT INTO public.cidade VALUES (1004, 'Itarumã', 9);
INSERT INTO public.cidade VALUES (1005, 'Itauçu', 9);
INSERT INTO public.cidade VALUES (1006, 'Itumbiara', 9);
INSERT INTO public.cidade VALUES (1007, 'Ivolândia', 9);
INSERT INTO public.cidade VALUES (1008, 'Jandaia', 9);
INSERT INTO public.cidade VALUES (1009, 'Jaraguá', 9);
INSERT INTO public.cidade VALUES (1010, 'Jataí', 9);
INSERT INTO public.cidade VALUES (1011, 'Jaupaci', 9);
INSERT INTO public.cidade VALUES (1012, 'Jesúpolis', 9);
INSERT INTO public.cidade VALUES (1013, 'Joviânia', 9);
INSERT INTO public.cidade VALUES (1014, 'Jussara', 9);
INSERT INTO public.cidade VALUES (1015, 'Lagoa Santa', 9);
INSERT INTO public.cidade VALUES (1016, 'Leopoldo de Bulhões', 9);
INSERT INTO public.cidade VALUES (1017, 'Luziânia', 9);
INSERT INTO public.cidade VALUES (1018, 'Mairipotaba', 9);
INSERT INTO public.cidade VALUES (1019, 'Mambaí', 9);
INSERT INTO public.cidade VALUES (1020, 'Mara Rosa', 9);
INSERT INTO public.cidade VALUES (1021, 'Marzagão', 9);
INSERT INTO public.cidade VALUES (1022, 'Matrinchã', 9);
INSERT INTO public.cidade VALUES (1023, 'Maurilândia', 9);
INSERT INTO public.cidade VALUES (1024, 'Mimoso de Goiás', 9);
INSERT INTO public.cidade VALUES (1025, 'Minaçu', 9);
INSERT INTO public.cidade VALUES (1026, 'Mineiros', 9);
INSERT INTO public.cidade VALUES (1027, 'Moiporá', 9);
INSERT INTO public.cidade VALUES (1028, 'Monte Alegre de Goiás', 9);
INSERT INTO public.cidade VALUES (1029, 'Montes Claros de Goiás', 9);
INSERT INTO public.cidade VALUES (1030, 'Montividiu', 9);
INSERT INTO public.cidade VALUES (1031, 'Montividiu do Norte', 9);
INSERT INTO public.cidade VALUES (1032, 'Morrinhos', 9);
INSERT INTO public.cidade VALUES (1033, 'Morro Agudo de Goiás', 9);
INSERT INTO public.cidade VALUES (1034, 'Mossâmedes', 9);
INSERT INTO public.cidade VALUES (1035, 'Mozarlândia', 9);
INSERT INTO public.cidade VALUES (1036, 'Mundo Novo', 9);
INSERT INTO public.cidade VALUES (1037, 'Mutunópolis', 9);
INSERT INTO public.cidade VALUES (1038, 'Nazário', 9);
INSERT INTO public.cidade VALUES (1039, 'Nerópolis', 9);
INSERT INTO public.cidade VALUES (1040, 'Niquelândia', 9);
INSERT INTO public.cidade VALUES (1041, 'Nova América', 9);
INSERT INTO public.cidade VALUES (1042, 'Nova Aurora', 9);
INSERT INTO public.cidade VALUES (1043, 'Nova Crixás', 9);
INSERT INTO public.cidade VALUES (1044, 'Nova Glória', 9);
INSERT INTO public.cidade VALUES (1045, 'Nova Iguaçu de Goiás', 9);
INSERT INTO public.cidade VALUES (1046, 'Nova Roma', 9);
INSERT INTO public.cidade VALUES (1047, 'Nova Veneza', 9);
INSERT INTO public.cidade VALUES (1048, 'Novo Brasil', 9);
INSERT INTO public.cidade VALUES (1049, 'Novo Gama', 9);
INSERT INTO public.cidade VALUES (1050, 'Novo Planalto', 9);
INSERT INTO public.cidade VALUES (1051, 'Orizona', 9);
INSERT INTO public.cidade VALUES (1052, 'Ouro Verde de Goiás', 9);
INSERT INTO public.cidade VALUES (1053, 'Ouvidor', 9);
INSERT INTO public.cidade VALUES (1054, 'Padre Bernardo', 9);
INSERT INTO public.cidade VALUES (1055, 'Palestina de Goiás', 9);
INSERT INTO public.cidade VALUES (1056, 'Palmeiras de Goiás', 9);
INSERT INTO public.cidade VALUES (1057, 'Palmelo', 9);
INSERT INTO public.cidade VALUES (1058, 'Palminópolis', 9);
INSERT INTO public.cidade VALUES (1059, 'Panamá', 9);
INSERT INTO public.cidade VALUES (1060, 'Paranaiguara', 9);
INSERT INTO public.cidade VALUES (1061, 'Paraúna', 9);
INSERT INTO public.cidade VALUES (1062, 'Perolândia', 9);
INSERT INTO public.cidade VALUES (1063, 'Petrolina de Goiás', 9);
INSERT INTO public.cidade VALUES (1064, 'Pilar de Goiás', 9);
INSERT INTO public.cidade VALUES (1065, 'Piracanjuba', 9);
INSERT INTO public.cidade VALUES (1066, 'Piranhas', 9);
INSERT INTO public.cidade VALUES (1067, 'Pirenópolis', 9);
INSERT INTO public.cidade VALUES (1068, 'Pires do Rio', 9);
INSERT INTO public.cidade VALUES (1069, 'Planaltina', 9);
INSERT INTO public.cidade VALUES (1070, 'Pontalina', 9);
INSERT INTO public.cidade VALUES (1071, 'Porangatu', 9);
INSERT INTO public.cidade VALUES (1072, 'Porteirão', 9);
INSERT INTO public.cidade VALUES (1073, 'Portelândia', 9);
INSERT INTO public.cidade VALUES (1074, 'Posse', 9);
INSERT INTO public.cidade VALUES (1075, 'Professor Jamil', 9);
INSERT INTO public.cidade VALUES (1076, 'Quirinópolis', 9);
INSERT INTO public.cidade VALUES (1077, 'Rialma', 9);
INSERT INTO public.cidade VALUES (1078, 'Rianápolis', 9);
INSERT INTO public.cidade VALUES (1079, 'Rio Quente', 9);
INSERT INTO public.cidade VALUES (1080, 'Rio Verde', 9);
INSERT INTO public.cidade VALUES (1081, 'Rubiataba', 9);
INSERT INTO public.cidade VALUES (1082, 'Sanclerlândia', 9);
INSERT INTO public.cidade VALUES (1083, 'Santa Bárbara de Goiás', 9);
INSERT INTO public.cidade VALUES (1084, 'Santa Cruz de Goiás', 9);
INSERT INTO public.cidade VALUES (1085, 'Santa Fé de Goiás', 9);
INSERT INTO public.cidade VALUES (1086, 'Santa Helena de Goiás', 9);
INSERT INTO public.cidade VALUES (1087, 'Santa Isabel', 9);
INSERT INTO public.cidade VALUES (1088, 'Santa Rita do Araguaia', 9);
INSERT INTO public.cidade VALUES (1089, 'Santa Rita do Novo Destino', 9);
INSERT INTO public.cidade VALUES (1090, 'Santa Rosa de Goiás', 9);
INSERT INTO public.cidade VALUES (1091, 'Santa Tereza de Goiás', 9);
INSERT INTO public.cidade VALUES (1092, 'Santa Terezinha de Goiás', 9);
INSERT INTO public.cidade VALUES (1093, 'Santo Antônio da Barra', 9);
INSERT INTO public.cidade VALUES (1094, 'Santo Antônio de Goiás', 9);
INSERT INTO public.cidade VALUES (1095, 'Santo Antônio do Descoberto', 9);
INSERT INTO public.cidade VALUES (1096, 'São Domingos', 9);
INSERT INTO public.cidade VALUES (1097, 'São Francisco de Goiás', 9);
INSERT INTO public.cidade VALUES (1098, 'São João d`Aliança', 9);
INSERT INTO public.cidade VALUES (1099, 'São João da Paraúna', 9);
INSERT INTO public.cidade VALUES (1100, 'São Luís de Montes Belos', 9);
INSERT INTO public.cidade VALUES (1101, 'São Luíz do Norte', 9);
INSERT INTO public.cidade VALUES (1102, 'São Miguel do Araguaia', 9);
INSERT INTO public.cidade VALUES (1103, 'São Miguel do Passa Quatro', 9);
INSERT INTO public.cidade VALUES (1104, 'São Patrício', 9);
INSERT INTO public.cidade VALUES (1105, 'São Simão', 9);
INSERT INTO public.cidade VALUES (1106, 'Senador Canedo', 9);
INSERT INTO public.cidade VALUES (1107, 'Serranópolis', 9);
INSERT INTO public.cidade VALUES (1108, 'Silvânia', 9);
INSERT INTO public.cidade VALUES (1109, 'Simolândia', 9);
INSERT INTO public.cidade VALUES (1110, 'Sítio d`Abadia', 9);
INSERT INTO public.cidade VALUES (1111, 'Taquaral de Goiás', 9);
INSERT INTO public.cidade VALUES (1112, 'Teresina de Goiás', 9);
INSERT INTO public.cidade VALUES (1113, 'Terezópolis de Goiás', 9);
INSERT INTO public.cidade VALUES (1114, 'Três Ranchos', 9);
INSERT INTO public.cidade VALUES (1115, 'Trindade', 9);
INSERT INTO public.cidade VALUES (1116, 'Trombas', 9);
INSERT INTO public.cidade VALUES (1117, 'Turvânia', 9);
INSERT INTO public.cidade VALUES (1118, 'Turvelândia', 9);
INSERT INTO public.cidade VALUES (1119, 'Uirapuru', 9);
INSERT INTO public.cidade VALUES (1120, 'Uruaçu', 9);
INSERT INTO public.cidade VALUES (1121, 'Uruana', 9);
INSERT INTO public.cidade VALUES (1122, 'Urutaí', 9);
INSERT INTO public.cidade VALUES (1123, 'Valparaíso de Goiás', 9);
INSERT INTO public.cidade VALUES (1124, 'Varjão', 9);
INSERT INTO public.cidade VALUES (1125, 'Vianópolis', 9);
INSERT INTO public.cidade VALUES (1126, 'Vicentinópolis', 9);
INSERT INTO public.cidade VALUES (1127, 'Vila Boa', 9);
INSERT INTO public.cidade VALUES (1128, 'Vila Propício', 9);
INSERT INTO public.cidade VALUES (1129, 'Açailândia', 10);
INSERT INTO public.cidade VALUES (1130, 'Afonso Cunha', 10);
INSERT INTO public.cidade VALUES (1131, 'Água Doce do Maranhão', 10);
INSERT INTO public.cidade VALUES (1132, 'Alcântara', 10);
INSERT INTO public.cidade VALUES (1133, 'Aldeias Altas', 10);
INSERT INTO public.cidade VALUES (1134, 'Altamira do Maranhão', 10);
INSERT INTO public.cidade VALUES (1135, 'Alto Alegre do Maranhão', 10);
INSERT INTO public.cidade VALUES (1136, 'Alto Alegre do Pindaré', 10);
INSERT INTO public.cidade VALUES (1137, 'Alto Parnaíba', 10);
INSERT INTO public.cidade VALUES (1138, 'Amapá do Maranhão', 10);
INSERT INTO public.cidade VALUES (1139, 'Amarante do Maranhão', 10);
INSERT INTO public.cidade VALUES (1140, 'Anajatuba', 10);
INSERT INTO public.cidade VALUES (1141, 'Anapurus', 10);
INSERT INTO public.cidade VALUES (1142, 'Apicum-Açu', 10);
INSERT INTO public.cidade VALUES (1143, 'Araguanã', 10);
INSERT INTO public.cidade VALUES (1144, 'Araioses', 10);
INSERT INTO public.cidade VALUES (1145, 'Arame', 10);
INSERT INTO public.cidade VALUES (1146, 'Arari', 10);
INSERT INTO public.cidade VALUES (1147, 'Axixá', 10);
INSERT INTO public.cidade VALUES (1148, 'Bacabal', 10);
INSERT INTO public.cidade VALUES (1149, 'Bacabeira', 10);
INSERT INTO public.cidade VALUES (1150, 'Bacuri', 10);
INSERT INTO public.cidade VALUES (1151, 'Bacurituba', 10);
INSERT INTO public.cidade VALUES (1152, 'Balsas', 10);
INSERT INTO public.cidade VALUES (1153, 'Barão de Grajaú', 10);
INSERT INTO public.cidade VALUES (1154, 'Barra do Corda', 10);
INSERT INTO public.cidade VALUES (1155, 'Barreirinhas', 10);
INSERT INTO public.cidade VALUES (1156, 'Bela Vista do Maranhão', 10);
INSERT INTO public.cidade VALUES (1157, 'Belágua', 10);
INSERT INTO public.cidade VALUES (1158, 'Benedito Leite', 10);
INSERT INTO public.cidade VALUES (1159, 'Bequimão', 10);
INSERT INTO public.cidade VALUES (1160, 'Bernardo do Mearim', 10);
INSERT INTO public.cidade VALUES (1161, 'Boa Vista do Gurupi', 10);
INSERT INTO public.cidade VALUES (1162, 'Bom Jardim', 10);
INSERT INTO public.cidade VALUES (1163, 'Bom Jesus das Selvas', 10);
INSERT INTO public.cidade VALUES (1164, 'Bom Lugar', 10);
INSERT INTO public.cidade VALUES (1165, 'Brejo', 10);
INSERT INTO public.cidade VALUES (1166, 'Brejo de Areia', 10);
INSERT INTO public.cidade VALUES (1167, 'Buriti', 10);
INSERT INTO public.cidade VALUES (1168, 'Buriti Bravo', 10);
INSERT INTO public.cidade VALUES (1169, 'Buriticupu', 10);
INSERT INTO public.cidade VALUES (1170, 'Buritirana', 10);
INSERT INTO public.cidade VALUES (1171, 'Cachoeira Grande', 10);
INSERT INTO public.cidade VALUES (1172, 'Cajapió', 10);
INSERT INTO public.cidade VALUES (1173, 'Cajari', 10);
INSERT INTO public.cidade VALUES (1174, 'Campestre do Maranhão', 10);
INSERT INTO public.cidade VALUES (1175, 'Cândido Mendes', 10);
INSERT INTO public.cidade VALUES (1176, 'Cantanhede', 10);
INSERT INTO public.cidade VALUES (1177, 'Capinzal do Norte', 10);
INSERT INTO public.cidade VALUES (1178, 'Carolina', 10);
INSERT INTO public.cidade VALUES (1179, 'Carutapera', 10);
INSERT INTO public.cidade VALUES (1180, 'Caxias', 10);
INSERT INTO public.cidade VALUES (1181, 'Cedral', 10);
INSERT INTO public.cidade VALUES (1182, 'Central do Maranhão', 10);
INSERT INTO public.cidade VALUES (1183, 'Centro do Guilherme', 10);
INSERT INTO public.cidade VALUES (1184, 'Centro Novo do Maranhão', 10);
INSERT INTO public.cidade VALUES (1185, 'Chapadinha', 10);
INSERT INTO public.cidade VALUES (1186, 'Cidelândia', 10);
INSERT INTO public.cidade VALUES (1187, 'Codó', 10);
INSERT INTO public.cidade VALUES (1188, 'Coelho Neto', 10);
INSERT INTO public.cidade VALUES (1189, 'Colinas', 10);
INSERT INTO public.cidade VALUES (1190, 'Conceição do Lago-Açu', 10);
INSERT INTO public.cidade VALUES (1191, 'Coroatá', 10);
INSERT INTO public.cidade VALUES (1192, 'Cururupu', 10);
INSERT INTO public.cidade VALUES (1193, 'Davinópolis', 10);
INSERT INTO public.cidade VALUES (1194, 'Dom Pedro', 10);
INSERT INTO public.cidade VALUES (1195, 'Duque Bacelar', 10);
INSERT INTO public.cidade VALUES (1196, 'Esperantinópolis', 10);
INSERT INTO public.cidade VALUES (1197, 'Estreito', 10);
INSERT INTO public.cidade VALUES (1198, 'Feira Nova do Maranhão', 10);
INSERT INTO public.cidade VALUES (1199, 'Fernando Falcão', 10);
INSERT INTO public.cidade VALUES (1200, 'Formosa da Serra Negra', 10);
INSERT INTO public.cidade VALUES (1201, 'Fortaleza dos Nogueiras', 10);
INSERT INTO public.cidade VALUES (1202, 'Fortuna', 10);
INSERT INTO public.cidade VALUES (1203, 'Godofredo Viana', 10);
INSERT INTO public.cidade VALUES (1204, 'Gonçalves Dias', 10);
INSERT INTO public.cidade VALUES (1205, 'Governador Archer', 10);
INSERT INTO public.cidade VALUES (1206, 'Governador Edison Lobão', 10);
INSERT INTO public.cidade VALUES (1207, 'Governador Eugênio Barros', 10);
INSERT INTO public.cidade VALUES (1208, 'Governador Luiz Rocha', 10);
INSERT INTO public.cidade VALUES (1209, 'Governador Newton Bello', 10);
INSERT INTO public.cidade VALUES (1210, 'Governador Nunes Freire', 10);
INSERT INTO public.cidade VALUES (1211, 'Graça Aranha', 10);
INSERT INTO public.cidade VALUES (1212, 'Grajaú', 10);
INSERT INTO public.cidade VALUES (1213, 'Guimarães', 10);
INSERT INTO public.cidade VALUES (1214, 'Humberto de Campos', 10);
INSERT INTO public.cidade VALUES (1215, 'Icatu', 10);
INSERT INTO public.cidade VALUES (1216, 'Igarapé do Meio', 10);
INSERT INTO public.cidade VALUES (1217, 'Igarapé Grande', 10);
INSERT INTO public.cidade VALUES (1218, 'Imperatriz', 10);
INSERT INTO public.cidade VALUES (1219, 'Itaipava do Grajaú', 10);
INSERT INTO public.cidade VALUES (1220, 'Itapecuru Mirim', 10);
INSERT INTO public.cidade VALUES (1221, 'Itinga do Maranhão', 10);
INSERT INTO public.cidade VALUES (1222, 'Jatobá', 10);
INSERT INTO public.cidade VALUES (1223, 'Jenipapo dos Vieiras', 10);
INSERT INTO public.cidade VALUES (1224, 'João Lisboa', 10);
INSERT INTO public.cidade VALUES (1225, 'Joselândia', 10);
INSERT INTO public.cidade VALUES (1226, 'Junco do Maranhão', 10);
INSERT INTO public.cidade VALUES (1227, 'Lago da Pedra', 10);
INSERT INTO public.cidade VALUES (1228, 'Lago do Junco', 10);
INSERT INTO public.cidade VALUES (1229, 'Lago dos Rodrigues', 10);
INSERT INTO public.cidade VALUES (1230, 'Lago Verde', 10);
INSERT INTO public.cidade VALUES (1231, 'Lagoa do Mato', 10);
INSERT INTO public.cidade VALUES (1232, 'Lagoa Grande do Maranhão', 10);
INSERT INTO public.cidade VALUES (1233, 'Lajeado Novo', 10);
INSERT INTO public.cidade VALUES (1234, 'Lima Campos', 10);
INSERT INTO public.cidade VALUES (1235, 'Loreto', 10);
INSERT INTO public.cidade VALUES (1236, 'Luís Domingues', 10);
INSERT INTO public.cidade VALUES (1237, 'Magalhães de Almeida', 10);
INSERT INTO public.cidade VALUES (1238, 'Maracaçumé', 10);
INSERT INTO public.cidade VALUES (1239, 'Marajá do Sena', 10);
INSERT INTO public.cidade VALUES (1240, 'Maranhãozinho', 10);
INSERT INTO public.cidade VALUES (1241, 'Mata Roma', 10);
INSERT INTO public.cidade VALUES (1242, 'Matinha', 10);
INSERT INTO public.cidade VALUES (1243, 'Matões', 10);
INSERT INTO public.cidade VALUES (1244, 'Matões do Norte', 10);
INSERT INTO public.cidade VALUES (1245, 'Milagres do Maranhão', 10);
INSERT INTO public.cidade VALUES (1246, 'Mirador', 10);
INSERT INTO public.cidade VALUES (1247, 'Miranda do Norte', 10);
INSERT INTO public.cidade VALUES (1248, 'Mirinzal', 10);
INSERT INTO public.cidade VALUES (1249, 'Monção', 10);
INSERT INTO public.cidade VALUES (1250, 'Montes Altos', 10);
INSERT INTO public.cidade VALUES (1251, 'Morros', 10);
INSERT INTO public.cidade VALUES (1252, 'Nina Rodrigues', 10);
INSERT INTO public.cidade VALUES (1253, 'Nova Colinas', 10);
INSERT INTO public.cidade VALUES (1254, 'Nova Iorque', 10);
INSERT INTO public.cidade VALUES (1255, 'Nova Olinda do Maranhão', 10);
INSERT INTO public.cidade VALUES (1256, 'Olho d`Água das Cunhãs', 10);
INSERT INTO public.cidade VALUES (1257, 'Olinda Nova do Maranhão', 10);
INSERT INTO public.cidade VALUES (1258, 'Paço do Lumiar', 10);
INSERT INTO public.cidade VALUES (1259, 'Palmeirândia', 10);
INSERT INTO public.cidade VALUES (1260, 'Paraibano', 10);
INSERT INTO public.cidade VALUES (1261, 'Parnarama', 10);
INSERT INTO public.cidade VALUES (1262, 'Passagem Franca', 10);
INSERT INTO public.cidade VALUES (1263, 'Pastos Bons', 10);
INSERT INTO public.cidade VALUES (1264, 'Paulino Neves', 10);
INSERT INTO public.cidade VALUES (1265, 'Paulo Ramos', 10);
INSERT INTO public.cidade VALUES (1266, 'Pedreiras', 10);
INSERT INTO public.cidade VALUES (1267, 'Pedro do Rosário', 10);
INSERT INTO public.cidade VALUES (1268, 'Penalva', 10);
INSERT INTO public.cidade VALUES (1269, 'Peri Mirim', 10);
INSERT INTO public.cidade VALUES (1270, 'Peritoró', 10);
INSERT INTO public.cidade VALUES (1271, 'Pindaré-Mirim', 10);
INSERT INTO public.cidade VALUES (1272, 'Pinheiro', 10);
INSERT INTO public.cidade VALUES (1273, 'Pio XII', 10);
INSERT INTO public.cidade VALUES (1274, 'Pirapemas', 10);
INSERT INTO public.cidade VALUES (1275, 'Poção de Pedras', 10);
INSERT INTO public.cidade VALUES (1276, 'Porto Franco', 10);
INSERT INTO public.cidade VALUES (1277, 'Porto Rico do Maranhão', 10);
INSERT INTO public.cidade VALUES (1278, 'Presidente Dutra', 10);
INSERT INTO public.cidade VALUES (1279, 'Presidente Juscelino', 10);
INSERT INTO public.cidade VALUES (1280, 'Presidente Médici', 10);
INSERT INTO public.cidade VALUES (1281, 'Presidente Sarney', 10);
INSERT INTO public.cidade VALUES (1282, 'Presidente Vargas', 10);
INSERT INTO public.cidade VALUES (1283, 'Primeira Cruz', 10);
INSERT INTO public.cidade VALUES (1284, 'Raposa', 10);
INSERT INTO public.cidade VALUES (1285, 'Riachão', 10);
INSERT INTO public.cidade VALUES (1286, 'Ribamar Fiquene', 10);
INSERT INTO public.cidade VALUES (1287, 'Rosário', 10);
INSERT INTO public.cidade VALUES (1288, 'Sambaíba', 10);
INSERT INTO public.cidade VALUES (1289, 'Santa Filomena do Maranhão', 10);
INSERT INTO public.cidade VALUES (1290, 'Santa Helena', 10);
INSERT INTO public.cidade VALUES (1291, 'Santa Inês', 10);
INSERT INTO public.cidade VALUES (1292, 'Santa Luzia', 10);
INSERT INTO public.cidade VALUES (1293, 'Santa Luzia do Paruá', 10);
INSERT INTO public.cidade VALUES (1294, 'Santa Quitéria do Maranhão', 10);
INSERT INTO public.cidade VALUES (1295, 'Santa Rita', 10);
INSERT INTO public.cidade VALUES (1296, 'Santana do Maranhão', 10);
INSERT INTO public.cidade VALUES (1297, 'Santo Amaro do Maranhão', 10);
INSERT INTO public.cidade VALUES (1298, 'Santo Antônio dos Lopes', 10);
INSERT INTO public.cidade VALUES (1299, 'São Benedito do Rio Preto', 10);
INSERT INTO public.cidade VALUES (1300, 'São Bento', 10);
INSERT INTO public.cidade VALUES (1301, 'São Bernardo', 10);
INSERT INTO public.cidade VALUES (1302, 'São Domingos do Azeitão', 10);
INSERT INTO public.cidade VALUES (1303, 'São Domingos do Maranhão', 10);
INSERT INTO public.cidade VALUES (1304, 'São Félix de Balsas', 10);
INSERT INTO public.cidade VALUES (1305, 'São Francisco do Brejão', 10);
INSERT INTO public.cidade VALUES (1306, 'São Francisco do Maranhão', 10);
INSERT INTO public.cidade VALUES (1307, 'São João Batista', 10);
INSERT INTO public.cidade VALUES (1308, 'São João do Carú', 10);
INSERT INTO public.cidade VALUES (1309, 'São João do Paraíso', 10);
INSERT INTO public.cidade VALUES (1310, 'São João do Soter', 10);
INSERT INTO public.cidade VALUES (1311, 'São João dos Patos', 10);
INSERT INTO public.cidade VALUES (1312, 'São José de Ribamar', 10);
INSERT INTO public.cidade VALUES (1313, 'São José dos Basílios', 10);
INSERT INTO public.cidade VALUES (1314, 'São Luís', 10);
INSERT INTO public.cidade VALUES (1315, 'São Luís Gonzaga do Maranhão', 10);
INSERT INTO public.cidade VALUES (1316, 'São Mateus do Maranhão', 10);
INSERT INTO public.cidade VALUES (1317, 'São Pedro da Água Branca', 10);
INSERT INTO public.cidade VALUES (1318, 'São Pedro dos Crentes', 10);
INSERT INTO public.cidade VALUES (1319, 'São Raimundo das Mangabeiras', 10);
INSERT INTO public.cidade VALUES (1320, 'São Raimundo do Doca Bezerra', 10);
INSERT INTO public.cidade VALUES (1321, 'São Roberto', 10);
INSERT INTO public.cidade VALUES (1322, 'São Vicente Ferrer', 10);
INSERT INTO public.cidade VALUES (1323, 'Satubinha', 10);
INSERT INTO public.cidade VALUES (1324, 'Senador Alexandre Costa', 10);
INSERT INTO public.cidade VALUES (1325, 'Senador La Rocque', 10);
INSERT INTO public.cidade VALUES (1326, 'Serrano do Maranhão', 10);
INSERT INTO public.cidade VALUES (1327, 'Sítio Novo', 10);
INSERT INTO public.cidade VALUES (1328, 'Sucupira do Norte', 10);
INSERT INTO public.cidade VALUES (1329, 'Sucupira do Riachão', 10);
INSERT INTO public.cidade VALUES (1330, 'Tasso Fragoso', 10);
INSERT INTO public.cidade VALUES (1331, 'Timbiras', 10);
INSERT INTO public.cidade VALUES (1332, 'Timon', 10);
INSERT INTO public.cidade VALUES (1333, 'Trizidela do Vale', 10);
INSERT INTO public.cidade VALUES (1334, 'Tufilândia', 10);
INSERT INTO public.cidade VALUES (1335, 'Tuntum', 10);
INSERT INTO public.cidade VALUES (1336, 'Turiaçu', 10);
INSERT INTO public.cidade VALUES (1337, 'Turilândia', 10);
INSERT INTO public.cidade VALUES (1338, 'Tutóia', 10);
INSERT INTO public.cidade VALUES (1339, 'Urbano Santos', 10);
INSERT INTO public.cidade VALUES (1340, 'Vargem Grande', 10);
INSERT INTO public.cidade VALUES (1341, 'Viana', 10);
INSERT INTO public.cidade VALUES (1342, 'Vila Nova dos Martírios', 10);
INSERT INTO public.cidade VALUES (1343, 'Vitória do Mearim', 10);
INSERT INTO public.cidade VALUES (1344, 'Vitorino Freire', 10);
INSERT INTO public.cidade VALUES (1345, 'Zé Doca', 10);
INSERT INTO public.cidade VALUES (1346, 'Acorizal', 13);
INSERT INTO public.cidade VALUES (1347, 'Água Boa', 13);
INSERT INTO public.cidade VALUES (1348, 'Alta Floresta', 13);
INSERT INTO public.cidade VALUES (1349, 'Alto Araguaia', 13);
INSERT INTO public.cidade VALUES (1350, 'Alto Boa Vista', 13);
INSERT INTO public.cidade VALUES (1351, 'Alto Garças', 13);
INSERT INTO public.cidade VALUES (1352, 'Alto Paraguai', 13);
INSERT INTO public.cidade VALUES (1353, 'Alto Taquari', 13);
INSERT INTO public.cidade VALUES (1354, 'Apiacás', 13);
INSERT INTO public.cidade VALUES (1355, 'Araguaiana', 13);
INSERT INTO public.cidade VALUES (1356, 'Araguainha', 13);
INSERT INTO public.cidade VALUES (1357, 'Araputanga', 13);
INSERT INTO public.cidade VALUES (1358, 'Arenápolis', 13);
INSERT INTO public.cidade VALUES (1359, 'Aripuanã', 13);
INSERT INTO public.cidade VALUES (1360, 'Barão de Melgaço', 13);
INSERT INTO public.cidade VALUES (1361, 'Barra do Bugres', 13);
INSERT INTO public.cidade VALUES (1362, 'Barra do Garças', 13);
INSERT INTO public.cidade VALUES (1363, 'Bom Jesus do Araguaia', 13);
INSERT INTO public.cidade VALUES (1364, 'Brasnorte', 13);
INSERT INTO public.cidade VALUES (1365, 'Cáceres', 13);
INSERT INTO public.cidade VALUES (1366, 'Campinápolis', 13);
INSERT INTO public.cidade VALUES (1367, 'Campo Novo do Parecis', 13);
INSERT INTO public.cidade VALUES (1368, 'Campo Verde', 13);
INSERT INTO public.cidade VALUES (1369, 'Campos de Júlio', 13);
INSERT INTO public.cidade VALUES (1370, 'Canabrava do Norte', 13);
INSERT INTO public.cidade VALUES (1371, 'Canarana', 13);
INSERT INTO public.cidade VALUES (1372, 'Carlinda', 13);
INSERT INTO public.cidade VALUES (1373, 'Castanheira', 13);
INSERT INTO public.cidade VALUES (1374, 'Chapada dos Guimarães', 13);
INSERT INTO public.cidade VALUES (1375, 'Cláudia', 13);
INSERT INTO public.cidade VALUES (1376, 'Cocalinho', 13);
INSERT INTO public.cidade VALUES (1377, 'Colíder', 13);
INSERT INTO public.cidade VALUES (1378, 'Colniza', 13);
INSERT INTO public.cidade VALUES (1379, 'Comodoro', 13);
INSERT INTO public.cidade VALUES (1380, 'Confresa', 13);
INSERT INTO public.cidade VALUES (1381, 'Conquista d`Oeste', 13);
INSERT INTO public.cidade VALUES (1382, 'Cotriguaçu', 13);
INSERT INTO public.cidade VALUES (1383, 'Cuiabá', 13);
INSERT INTO public.cidade VALUES (1384, 'Curvelândia', 13);
INSERT INTO public.cidade VALUES (1386, 'Denise', 13);
INSERT INTO public.cidade VALUES (1387, 'Diamantino', 13);
INSERT INTO public.cidade VALUES (1388, 'Dom Aquino', 13);
INSERT INTO public.cidade VALUES (1389, 'Feliz Natal', 13);
INSERT INTO public.cidade VALUES (1390, 'Figueirópolis d`Oeste', 13);
INSERT INTO public.cidade VALUES (1391, 'Gaúcha do Norte', 13);
INSERT INTO public.cidade VALUES (1392, 'General Carneiro', 13);
INSERT INTO public.cidade VALUES (1393, 'Glória d`Oeste', 13);
INSERT INTO public.cidade VALUES (1394, 'Guarantã do Norte', 13);
INSERT INTO public.cidade VALUES (1395, 'Guiratinga', 13);
INSERT INTO public.cidade VALUES (1396, 'Indiavaí', 13);
INSERT INTO public.cidade VALUES (1397, 'Ipiranga do Norte', 13);
INSERT INTO public.cidade VALUES (1398, 'Itanhangá', 13);
INSERT INTO public.cidade VALUES (1399, 'Itaúba', 13);
INSERT INTO public.cidade VALUES (1400, 'Itiquira', 13);
INSERT INTO public.cidade VALUES (1401, 'Jaciara', 13);
INSERT INTO public.cidade VALUES (1402, 'Jangada', 13);
INSERT INTO public.cidade VALUES (1403, 'Jauru', 13);
INSERT INTO public.cidade VALUES (1404, 'Juara', 13);
INSERT INTO public.cidade VALUES (1405, 'Juína', 13);
INSERT INTO public.cidade VALUES (1406, 'Juruena', 13);
INSERT INTO public.cidade VALUES (1407, 'Juscimeira', 13);
INSERT INTO public.cidade VALUES (1408, 'Lambari d`Oeste', 13);
INSERT INTO public.cidade VALUES (1409, 'Lucas do Rio Verde', 13);
INSERT INTO public.cidade VALUES (1410, 'Luciára', 13);
INSERT INTO public.cidade VALUES (1411, 'Marcelândia', 13);
INSERT INTO public.cidade VALUES (1412, 'Matupá', 13);
INSERT INTO public.cidade VALUES (1413, 'Mirassol d`Oeste', 13);
INSERT INTO public.cidade VALUES (1414, 'Nobres', 13);
INSERT INTO public.cidade VALUES (1415, 'Nortelândia', 13);
INSERT INTO public.cidade VALUES (1416, 'Nossa Senhora do Livramento', 13);
INSERT INTO public.cidade VALUES (1417, 'Nova Bandeirantes', 13);
INSERT INTO public.cidade VALUES (1418, 'Nova Brasilândia', 13);
INSERT INTO public.cidade VALUES (1419, 'Nova Canaã do Norte', 13);
INSERT INTO public.cidade VALUES (1420, 'Nova Guarita', 13);
INSERT INTO public.cidade VALUES (1421, 'Nova Lacerda', 13);
INSERT INTO public.cidade VALUES (1422, 'Nova Marilândia', 13);
INSERT INTO public.cidade VALUES (1423, 'Nova Maringá', 13);
INSERT INTO public.cidade VALUES (1424, 'Nova Monte verde', 13);
INSERT INTO public.cidade VALUES (1425, 'Nova Mutum', 13);
INSERT INTO public.cidade VALUES (1426, 'Nova Olímpia', 13);
INSERT INTO public.cidade VALUES (1427, 'Nova Santa Helena', 13);
INSERT INTO public.cidade VALUES (1428, 'Nova Ubiratã', 13);
INSERT INTO public.cidade VALUES (1429, 'Nova Xavantina', 13);
INSERT INTO public.cidade VALUES (1430, 'Novo Horizonte do Norte', 13);
INSERT INTO public.cidade VALUES (1431, 'Novo Mundo', 13);
INSERT INTO public.cidade VALUES (1432, 'Novo Santo Antônio', 13);
INSERT INTO public.cidade VALUES (1433, 'Novo São Joaquim', 13);
INSERT INTO public.cidade VALUES (1434, 'Paranaíta', 13);
INSERT INTO public.cidade VALUES (1435, 'Paranatinga', 13);
INSERT INTO public.cidade VALUES (1436, 'Pedra Preta', 13);
INSERT INTO public.cidade VALUES (1437, 'Peixoto de Azevedo', 13);
INSERT INTO public.cidade VALUES (1438, 'Planalto da Serra', 13);
INSERT INTO public.cidade VALUES (1439, 'Poconé', 13);
INSERT INTO public.cidade VALUES (1440, 'Pontal do Araguaia', 13);
INSERT INTO public.cidade VALUES (1441, 'Ponte Branca', 13);
INSERT INTO public.cidade VALUES (1442, 'Pontes e Lacerda', 13);
INSERT INTO public.cidade VALUES (1443, 'Porto Alegre do Norte', 13);
INSERT INTO public.cidade VALUES (1444, 'Porto dos Gaúchos', 13);
INSERT INTO public.cidade VALUES (1445, 'Porto Esperidião', 13);
INSERT INTO public.cidade VALUES (1446, 'Porto Estrela', 13);
INSERT INTO public.cidade VALUES (1447, 'Poxoréo', 13);
INSERT INTO public.cidade VALUES (1448, 'Primavera do Leste', 13);
INSERT INTO public.cidade VALUES (1449, 'Querência', 13);
INSERT INTO public.cidade VALUES (1450, 'Reserva do Cabaçal', 13);
INSERT INTO public.cidade VALUES (1451, 'Ribeirão Cascalheira', 13);
INSERT INTO public.cidade VALUES (1452, 'Ribeirãozinho', 13);
INSERT INTO public.cidade VALUES (1453, 'Rio Branco', 13);
INSERT INTO public.cidade VALUES (1454, 'Rondolândia', 13);
INSERT INTO public.cidade VALUES (1455, 'Rondonópolis', 13);
INSERT INTO public.cidade VALUES (1456, 'Rosário Oeste', 13);
INSERT INTO public.cidade VALUES (1457, 'Salto do Céu', 13);
INSERT INTO public.cidade VALUES (1458, 'Santa Carmem', 13);
INSERT INTO public.cidade VALUES (1459, 'Santa Cruz do Xingu', 13);
INSERT INTO public.cidade VALUES (1460, 'Santa Rita do Trivelato', 13);
INSERT INTO public.cidade VALUES (1461, 'Santa Terezinha', 13);
INSERT INTO public.cidade VALUES (1462, 'Santo Afonso', 13);
INSERT INTO public.cidade VALUES (1463, 'Santo Antônio do Leste', 13);
INSERT INTO public.cidade VALUES (1464, 'Santo Antônio do Leverger', 13);
INSERT INTO public.cidade VALUES (1465, 'São Félix do Araguaia', 13);
INSERT INTO public.cidade VALUES (1466, 'São José do Povo', 13);
INSERT INTO public.cidade VALUES (1467, 'São José do Rio Claro', 13);
INSERT INTO public.cidade VALUES (1468, 'São José do Xingu', 13);
INSERT INTO public.cidade VALUES (1469, 'São José dos Quatro Marcos', 13);
INSERT INTO public.cidade VALUES (1470, 'São Pedro da Cipa', 13);
INSERT INTO public.cidade VALUES (1471, 'Sapezal', 13);
INSERT INTO public.cidade VALUES (1472, 'Serra Nova Dourada', 13);
INSERT INTO public.cidade VALUES (1473, 'Sinop', 13);
INSERT INTO public.cidade VALUES (1474, 'Sorriso', 13);
INSERT INTO public.cidade VALUES (1475, 'Tabaporã', 13);
INSERT INTO public.cidade VALUES (1476, 'Tangará da Serra', 13);
INSERT INTO public.cidade VALUES (1477, 'Tapurah', 13);
INSERT INTO public.cidade VALUES (1478, 'Terra Nova do Norte', 13);
INSERT INTO public.cidade VALUES (1479, 'Tesouro', 13);
INSERT INTO public.cidade VALUES (1480, 'Torixoréu', 13);
INSERT INTO public.cidade VALUES (1481, 'União do Sul', 13);
INSERT INTO public.cidade VALUES (1482, 'Vale de São Domingos', 13);
INSERT INTO public.cidade VALUES (1483, 'Várzea Grande', 13);
INSERT INTO public.cidade VALUES (1484, 'Vera', 13);
INSERT INTO public.cidade VALUES (1485, 'Vila Bela da Santíssima Trindade', 13);
INSERT INTO public.cidade VALUES (1486, 'Vila Rica', 13);
INSERT INTO public.cidade VALUES (1487, 'Água Clara', 12);
INSERT INTO public.cidade VALUES (1488, 'Alcinópolis', 12);
INSERT INTO public.cidade VALUES (1489, 'Amambaí', 12);
INSERT INTO public.cidade VALUES (1490, 'Anastácio', 12);
INSERT INTO public.cidade VALUES (1491, 'Anaurilândia', 12);
INSERT INTO public.cidade VALUES (1492, 'Angélica', 12);
INSERT INTO public.cidade VALUES (1493, 'Antônio João', 12);
INSERT INTO public.cidade VALUES (1494, 'Aparecida do Taboado', 12);
INSERT INTO public.cidade VALUES (1495, 'Aquidauana', 12);
INSERT INTO public.cidade VALUES (1496, 'Aral Moreira', 12);
INSERT INTO public.cidade VALUES (1497, 'Bandeirantes', 12);
INSERT INTO public.cidade VALUES (1498, 'Bataguassu', 12);
INSERT INTO public.cidade VALUES (1500, 'Bela Vista', 12);
INSERT INTO public.cidade VALUES (1501, 'Bodoquena', 12);
INSERT INTO public.cidade VALUES (1502, 'Bonito', 12);
INSERT INTO public.cidade VALUES (1503, 'Brasilândia', 12);
INSERT INTO public.cidade VALUES (1504, 'Caarapó', 12);
INSERT INTO public.cidade VALUES (1505, 'Camapuã', 12);
INSERT INTO public.cidade VALUES (1506, 'Campo Grande', 12);
INSERT INTO public.cidade VALUES (1507, 'Caracol', 12);
INSERT INTO public.cidade VALUES (1508, 'Cassilândia', 12);
INSERT INTO public.cidade VALUES (1509, 'Chapadão do Sul', 12);
INSERT INTO public.cidade VALUES (1510, 'Corguinho', 12);
INSERT INTO public.cidade VALUES (1511, 'Coronel Sapucaia', 12);
INSERT INTO public.cidade VALUES (1512, 'Corumbá', 12);
INSERT INTO public.cidade VALUES (1513, 'Costa Rica', 12);
INSERT INTO public.cidade VALUES (1514, 'Coxim', 12);
INSERT INTO public.cidade VALUES (1515, 'Deodápolis', 12);
INSERT INTO public.cidade VALUES (1516, 'Dois Irmãos do Buriti', 12);
INSERT INTO public.cidade VALUES (1517, 'Douradina', 12);
INSERT INTO public.cidade VALUES (1518, 'Dourados', 12);
INSERT INTO public.cidade VALUES (1519, 'Eldorado', 12);
INSERT INTO public.cidade VALUES (1520, 'Fátima do Sul', 12);
INSERT INTO public.cidade VALUES (1521, 'Figueirão', 12);
INSERT INTO public.cidade VALUES (1522, 'Glória de Dourados', 12);
INSERT INTO public.cidade VALUES (1523, 'Guia Lopes da Laguna', 12);
INSERT INTO public.cidade VALUES (1524, 'Iguatemi', 12);
INSERT INTO public.cidade VALUES (1525, 'Inocência', 12);
INSERT INTO public.cidade VALUES (1526, 'Itaporã', 12);
INSERT INTO public.cidade VALUES (1527, 'Itaquiraí', 12);
INSERT INTO public.cidade VALUES (1528, 'Ivinhema', 12);
INSERT INTO public.cidade VALUES (1529, 'Japorã', 12);
INSERT INTO public.cidade VALUES (1530, 'Jaraguari', 12);
INSERT INTO public.cidade VALUES (1531, 'Jardim', 12);
INSERT INTO public.cidade VALUES (1532, 'Jateí', 12);
INSERT INTO public.cidade VALUES (1533, 'Juti', 12);
INSERT INTO public.cidade VALUES (1534, 'Ladário', 12);
INSERT INTO public.cidade VALUES (1535, 'Laguna Carapã', 12);
INSERT INTO public.cidade VALUES (1536, 'Maracaju', 12);
INSERT INTO public.cidade VALUES (1537, 'Miranda', 12);
INSERT INTO public.cidade VALUES (1538, 'Mundo Novo', 12);
INSERT INTO public.cidade VALUES (1539, 'Naviraí', 12);
INSERT INTO public.cidade VALUES (1540, 'Nioaque', 12);
INSERT INTO public.cidade VALUES (1541, 'Nova Alvorada do Sul', 12);
INSERT INTO public.cidade VALUES (1542, 'Nova Andradina', 12);
INSERT INTO public.cidade VALUES (1543, 'Novo Horizonte do Sul', 12);
INSERT INTO public.cidade VALUES (1544, 'Paranaíba', 12);
INSERT INTO public.cidade VALUES (1545, 'Paranhos', 12);
INSERT INTO public.cidade VALUES (1546, 'Pedro Gomes', 12);
INSERT INTO public.cidade VALUES (1547, 'Ponta Porã', 12);
INSERT INTO public.cidade VALUES (1548, 'Porto Murtinho', 12);
INSERT INTO public.cidade VALUES (1549, 'Ribas do Rio Pardo', 12);
INSERT INTO public.cidade VALUES (1550, 'Rio Brilhante', 12);
INSERT INTO public.cidade VALUES (1551, 'Rio Negro', 12);
INSERT INTO public.cidade VALUES (1552, 'Rio Verde de Mato Grosso', 12);
INSERT INTO public.cidade VALUES (1553, 'Rochedo', 12);
INSERT INTO public.cidade VALUES (1554, 'Santa Rita do Pardo', 12);
INSERT INTO public.cidade VALUES (1555, 'São Gabriel do Oeste', 12);
INSERT INTO public.cidade VALUES (1556, 'Selvíria', 12);
INSERT INTO public.cidade VALUES (1557, 'Sete Quedas', 12);
INSERT INTO public.cidade VALUES (1558, 'Sidrolândia', 12);
INSERT INTO public.cidade VALUES (1559, 'Sonora', 12);
INSERT INTO public.cidade VALUES (1560, 'Tacuru', 12);
INSERT INTO public.cidade VALUES (1561, 'Taquarussu', 12);
INSERT INTO public.cidade VALUES (1562, 'Terenos', 12);
INSERT INTO public.cidade VALUES (1563, 'Três Lagoas', 12);
INSERT INTO public.cidade VALUES (1564, 'Vicentina', 12);
INSERT INTO public.cidade VALUES (1565, 'Abadia dos Dourados', 11);
INSERT INTO public.cidade VALUES (1566, 'Abaeté', 11);
INSERT INTO public.cidade VALUES (1567, 'Abre Campo', 11);
INSERT INTO public.cidade VALUES (1568, 'Acaiaca', 11);
INSERT INTO public.cidade VALUES (1569, 'Açucena', 11);
INSERT INTO public.cidade VALUES (1570, 'Água Boa', 11);
INSERT INTO public.cidade VALUES (1571, 'Água Comprida', 11);
INSERT INTO public.cidade VALUES (1572, 'Aguanil', 11);
INSERT INTO public.cidade VALUES (1573, 'Águas Formosas', 11);
INSERT INTO public.cidade VALUES (1574, 'Águas Vermelhas', 11);
INSERT INTO public.cidade VALUES (1575, 'Aimorés', 11);
INSERT INTO public.cidade VALUES (1576, 'Aiuruoca', 11);
INSERT INTO public.cidade VALUES (1577, 'Alagoa', 11);
INSERT INTO public.cidade VALUES (1578, 'Albertina', 11);
INSERT INTO public.cidade VALUES (1579, 'Além Paraíba', 11);
INSERT INTO public.cidade VALUES (1580, 'Alfenas', 11);
INSERT INTO public.cidade VALUES (1581, 'Alfredo Vasconcelos', 11);
INSERT INTO public.cidade VALUES (1582, 'Almenara', 11);
INSERT INTO public.cidade VALUES (1583, 'Alpercata', 11);
INSERT INTO public.cidade VALUES (1584, 'Alpinópolis', 11);
INSERT INTO public.cidade VALUES (1585, 'Alterosa', 11);
INSERT INTO public.cidade VALUES (1586, 'Alto Caparaó', 11);
INSERT INTO public.cidade VALUES (1587, 'Alto Jequitibá', 11);
INSERT INTO public.cidade VALUES (1588, 'Alto Rio Doce', 11);
INSERT INTO public.cidade VALUES (1589, 'Alvarenga', 11);
INSERT INTO public.cidade VALUES (1590, 'Alvinópolis', 11);
INSERT INTO public.cidade VALUES (1591, 'Alvorada de Minas', 11);
INSERT INTO public.cidade VALUES (1592, 'Amparo do Serra', 11);
INSERT INTO public.cidade VALUES (1593, 'Andradas', 11);
INSERT INTO public.cidade VALUES (1594, 'Andrelândia', 11);
INSERT INTO public.cidade VALUES (1595, 'Angelândia', 11);
INSERT INTO public.cidade VALUES (1596, 'Antônio Carlos', 11);
INSERT INTO public.cidade VALUES (1597, 'Antônio Dias', 11);
INSERT INTO public.cidade VALUES (1598, 'Antônio Prado de Minas', 11);
INSERT INTO public.cidade VALUES (1599, 'Araçaí', 11);
INSERT INTO public.cidade VALUES (1600, 'Aracitaba', 11);
INSERT INTO public.cidade VALUES (1601, 'Araçuaí', 11);
INSERT INTO public.cidade VALUES (1602, 'Araguari', 11);
INSERT INTO public.cidade VALUES (1603, 'Arantina', 11);
INSERT INTO public.cidade VALUES (1604, 'Araponga', 11);
INSERT INTO public.cidade VALUES (1605, 'Araporã', 11);
INSERT INTO public.cidade VALUES (1606, 'Arapuá', 11);
INSERT INTO public.cidade VALUES (1607, 'Araújos', 11);
INSERT INTO public.cidade VALUES (1608, 'Araxá', 11);
INSERT INTO public.cidade VALUES (1609, 'Arceburgo', 11);
INSERT INTO public.cidade VALUES (1610, 'Arcos', 11);
INSERT INTO public.cidade VALUES (1611, 'Areado', 11);
INSERT INTO public.cidade VALUES (1612, 'Argirita', 11);
INSERT INTO public.cidade VALUES (1613, 'Aricanduva', 11);
INSERT INTO public.cidade VALUES (1614, 'Arinos', 11);
INSERT INTO public.cidade VALUES (1615, 'Astolfo Dutra', 11);
INSERT INTO public.cidade VALUES (1616, 'Ataléia', 11);
INSERT INTO public.cidade VALUES (1617, 'Augusto de Lima', 11);
INSERT INTO public.cidade VALUES (1618, 'Baependi', 11);
INSERT INTO public.cidade VALUES (1619, 'Baldim', 11);
INSERT INTO public.cidade VALUES (1620, 'Bambuí', 11);
INSERT INTO public.cidade VALUES (1621, 'Bandeira', 11);
INSERT INTO public.cidade VALUES (1622, 'Bandeira do Sul', 11);
INSERT INTO public.cidade VALUES (1623, 'Barão de Cocais', 11);
INSERT INTO public.cidade VALUES (1624, 'Barão de Monte Alto', 11);
INSERT INTO public.cidade VALUES (1625, 'Barbacena', 11);
INSERT INTO public.cidade VALUES (1626, 'Barra Longa', 11);
INSERT INTO public.cidade VALUES (1627, 'Barroso', 11);
INSERT INTO public.cidade VALUES (1628, 'Bela Vista de Minas', 11);
INSERT INTO public.cidade VALUES (1629, 'Belmiro Braga', 11);
INSERT INTO public.cidade VALUES (1630, 'Belo Horizonte', 11);
INSERT INTO public.cidade VALUES (1631, 'Belo Oriente', 11);
INSERT INTO public.cidade VALUES (1632, 'Belo Vale', 11);
INSERT INTO public.cidade VALUES (1633, 'Berilo', 11);
INSERT INTO public.cidade VALUES (1634, 'Berizal', 11);
INSERT INTO public.cidade VALUES (1635, 'Bertópolis', 11);
INSERT INTO public.cidade VALUES (1636, 'Betim', 11);
INSERT INTO public.cidade VALUES (1637, 'Bias Fortes', 11);
INSERT INTO public.cidade VALUES (1638, 'Bicas', 11);
INSERT INTO public.cidade VALUES (1639, 'Biquinhas', 11);
INSERT INTO public.cidade VALUES (1640, 'Boa Esperança', 11);
INSERT INTO public.cidade VALUES (1641, 'Bocaina de Minas', 11);
INSERT INTO public.cidade VALUES (1642, 'Bocaiúva', 11);
INSERT INTO public.cidade VALUES (1643, 'Bom Despacho', 11);
INSERT INTO public.cidade VALUES (1644, 'Bom Jardim de Minas', 11);
INSERT INTO public.cidade VALUES (1645, 'Bom Jesus da Penha', 11);
INSERT INTO public.cidade VALUES (1646, 'Bom Jesus do Amparo', 11);
INSERT INTO public.cidade VALUES (1647, 'Bom Jesus do Galho', 11);
INSERT INTO public.cidade VALUES (1648, 'Bom Repouso', 11);
INSERT INTO public.cidade VALUES (1649, 'Bom Sucesso', 11);
INSERT INTO public.cidade VALUES (1650, 'Bonfim', 11);
INSERT INTO public.cidade VALUES (1651, 'Bonfinópolis de Minas', 11);
INSERT INTO public.cidade VALUES (1652, 'Bonito de Minas', 11);
INSERT INTO public.cidade VALUES (1653, 'Borda da Mata', 11);
INSERT INTO public.cidade VALUES (1654, 'Botelhos', 11);
INSERT INTO public.cidade VALUES (1655, 'Botumirim', 11);
INSERT INTO public.cidade VALUES (1656, 'Brás Pires', 11);
INSERT INTO public.cidade VALUES (1657, 'Brasilândia de Minas', 11);
INSERT INTO public.cidade VALUES (1658, 'Brasília de Minas', 11);
INSERT INTO public.cidade VALUES (1659, 'Brasópolis', 11);
INSERT INTO public.cidade VALUES (1660, 'Braúnas', 11);
INSERT INTO public.cidade VALUES (1661, 'Brumadinho', 11);
INSERT INTO public.cidade VALUES (1662, 'Bueno Brandão', 11);
INSERT INTO public.cidade VALUES (1663, 'Buenópolis', 11);
INSERT INTO public.cidade VALUES (1664, 'Bugre', 11);
INSERT INTO public.cidade VALUES (1665, 'Buritis', 11);
INSERT INTO public.cidade VALUES (1666, 'Buritizeiro', 11);
INSERT INTO public.cidade VALUES (1667, 'Cabeceira Grande', 11);
INSERT INTO public.cidade VALUES (1668, 'Cabo Verde', 11);
INSERT INTO public.cidade VALUES (1669, 'Cachoeira da Prata', 11);
INSERT INTO public.cidade VALUES (1670, 'Cachoeira de Minas', 11);
INSERT INTO public.cidade VALUES (1671, 'Cachoeira de Pajeú', 11);
INSERT INTO public.cidade VALUES (1672, 'Cachoeira Dourada', 11);
INSERT INTO public.cidade VALUES (1673, 'Caetanópolis', 11);
INSERT INTO public.cidade VALUES (1674, 'Caeté', 11);
INSERT INTO public.cidade VALUES (1675, 'Caiana', 11);
INSERT INTO public.cidade VALUES (1676, 'Cajuri', 11);
INSERT INTO public.cidade VALUES (1677, 'Caldas', 11);
INSERT INTO public.cidade VALUES (1678, 'Camacho', 11);
INSERT INTO public.cidade VALUES (1679, 'Camanducaia', 11);
INSERT INTO public.cidade VALUES (1680, 'Cambuí', 11);
INSERT INTO public.cidade VALUES (1681, 'Cambuquira', 11);
INSERT INTO public.cidade VALUES (1682, 'Campanário', 11);
INSERT INTO public.cidade VALUES (1683, 'Campanha', 11);
INSERT INTO public.cidade VALUES (1684, 'Campestre', 11);
INSERT INTO public.cidade VALUES (1685, 'Campina Verde', 11);
INSERT INTO public.cidade VALUES (1686, 'Campo Azul', 11);
INSERT INTO public.cidade VALUES (1687, 'Campo Belo', 11);
INSERT INTO public.cidade VALUES (1688, 'Campo do Meio', 11);
INSERT INTO public.cidade VALUES (1689, 'Campo Florido', 11);
INSERT INTO public.cidade VALUES (1690, 'Campos Altos', 11);
INSERT INTO public.cidade VALUES (1691, 'Campos Gerais', 11);
INSERT INTO public.cidade VALUES (1692, 'Cana Verde', 11);
INSERT INTO public.cidade VALUES (1693, 'Canaã', 11);
INSERT INTO public.cidade VALUES (1694, 'Canápolis', 11);
INSERT INTO public.cidade VALUES (1695, 'Candeias', 11);
INSERT INTO public.cidade VALUES (1696, 'Cantagalo', 11);
INSERT INTO public.cidade VALUES (1697, 'Caparaó', 11);
INSERT INTO public.cidade VALUES (1698, 'Capela Nova', 11);
INSERT INTO public.cidade VALUES (1699, 'Capelinha', 11);
INSERT INTO public.cidade VALUES (1700, 'Capetinga', 11);
INSERT INTO public.cidade VALUES (1701, 'Capim Branco', 11);
INSERT INTO public.cidade VALUES (1702, 'Capinópolis', 11);
INSERT INTO public.cidade VALUES (1703, 'Capitão Andrade', 11);
INSERT INTO public.cidade VALUES (1704, 'Capitão Enéas', 11);
INSERT INTO public.cidade VALUES (1705, 'Capitólio', 11);
INSERT INTO public.cidade VALUES (1706, 'Caputira', 11);
INSERT INTO public.cidade VALUES (1707, 'Caraí', 11);
INSERT INTO public.cidade VALUES (1708, 'Caranaíba', 11);
INSERT INTO public.cidade VALUES (1709, 'Carandaí', 11);
INSERT INTO public.cidade VALUES (1710, 'Carangola', 11);
INSERT INTO public.cidade VALUES (1711, 'Caratinga', 11);
INSERT INTO public.cidade VALUES (1712, 'Carbonita', 11);
INSERT INTO public.cidade VALUES (1713, 'Careaçu', 11);
INSERT INTO public.cidade VALUES (1714, 'Carlos Chagas', 11);
INSERT INTO public.cidade VALUES (1715, 'Carmésia', 11);
INSERT INTO public.cidade VALUES (1716, 'Carmo da Cachoeira', 11);
INSERT INTO public.cidade VALUES (1717, 'Carmo da Mata', 11);
INSERT INTO public.cidade VALUES (1718, 'Carmo de Minas', 11);
INSERT INTO public.cidade VALUES (1719, 'Carmo do Cajuru', 11);
INSERT INTO public.cidade VALUES (1720, 'Carmo do Paranaíba', 11);
INSERT INTO public.cidade VALUES (1721, 'Carmo do Rio Claro', 11);
INSERT INTO public.cidade VALUES (1722, 'Carmópolis de Minas', 11);
INSERT INTO public.cidade VALUES (1723, 'Carneirinho', 11);
INSERT INTO public.cidade VALUES (1724, 'Carrancas', 11);
INSERT INTO public.cidade VALUES (1725, 'Carvalhópolis', 11);
INSERT INTO public.cidade VALUES (1726, 'Carvalhos', 11);
INSERT INTO public.cidade VALUES (1727, 'Casa Grande', 11);
INSERT INTO public.cidade VALUES (1728, 'Cascalho Rico', 11);
INSERT INTO public.cidade VALUES (1729, 'Cássia', 11);
INSERT INTO public.cidade VALUES (1730, 'Cataguases', 11);
INSERT INTO public.cidade VALUES (1731, 'Catas Altas', 11);
INSERT INTO public.cidade VALUES (1732, 'Catas Altas da Noruega', 11);
INSERT INTO public.cidade VALUES (1733, 'Catuji', 11);
INSERT INTO public.cidade VALUES (1734, 'Catuti', 11);
INSERT INTO public.cidade VALUES (1735, 'Caxambu', 11);
INSERT INTO public.cidade VALUES (1736, 'Cedro do Abaeté', 11);
INSERT INTO public.cidade VALUES (1737, 'Central de Minas', 11);
INSERT INTO public.cidade VALUES (1738, 'Centralina', 11);
INSERT INTO public.cidade VALUES (1739, 'Chácara', 11);
INSERT INTO public.cidade VALUES (1740, 'Chalé', 11);
INSERT INTO public.cidade VALUES (1741, 'Chapada do Norte', 11);
INSERT INTO public.cidade VALUES (1742, 'Chapada Gaúcha', 11);
INSERT INTO public.cidade VALUES (1743, 'Chiador', 11);
INSERT INTO public.cidade VALUES (1744, 'Cipotânea', 11);
INSERT INTO public.cidade VALUES (1745, 'Claraval', 11);
INSERT INTO public.cidade VALUES (1746, 'Claro dos Poções', 11);
INSERT INTO public.cidade VALUES (1747, 'Cláudio', 11);
INSERT INTO public.cidade VALUES (1748, 'Coimbra', 11);
INSERT INTO public.cidade VALUES (1749, 'Coluna', 11);
INSERT INTO public.cidade VALUES (1750, 'Comendador Gomes', 11);
INSERT INTO public.cidade VALUES (1751, 'Comercinho', 11);
INSERT INTO public.cidade VALUES (1752, 'Conceição da Aparecida', 11);
INSERT INTO public.cidade VALUES (1753, 'Conceição da Barra de Minas', 11);
INSERT INTO public.cidade VALUES (1754, 'Conceição das Alagoas', 11);
INSERT INTO public.cidade VALUES (1755, 'Conceição das Pedras', 11);
INSERT INTO public.cidade VALUES (1756, 'Conceição de Ipanema', 11);
INSERT INTO public.cidade VALUES (1757, 'Conceição do Mato Dentro', 11);
INSERT INTO public.cidade VALUES (1758, 'Conceição do Pará', 11);
INSERT INTO public.cidade VALUES (1759, 'Conceição do Rio Verde', 11);
INSERT INTO public.cidade VALUES (1760, 'Conceição dos Ouros', 11);
INSERT INTO public.cidade VALUES (1761, 'Cônego Marinho', 11);
INSERT INTO public.cidade VALUES (1762, 'Confins', 11);
INSERT INTO public.cidade VALUES (1763, 'Congonhal', 11);
INSERT INTO public.cidade VALUES (1764, 'Congonhas', 11);
INSERT INTO public.cidade VALUES (1765, 'Congonhas do Norte', 11);
INSERT INTO public.cidade VALUES (1766, 'Conquista', 11);
INSERT INTO public.cidade VALUES (1767, 'Conselheiro Lafaiete', 11);
INSERT INTO public.cidade VALUES (1768, 'Conselheiro Pena', 11);
INSERT INTO public.cidade VALUES (1769, 'Consolação', 11);
INSERT INTO public.cidade VALUES (1770, 'Contagem', 11);
INSERT INTO public.cidade VALUES (1771, 'Coqueiral', 11);
INSERT INTO public.cidade VALUES (1772, 'Coração de Jesus', 11);
INSERT INTO public.cidade VALUES (1773, 'Cordisburgo', 11);
INSERT INTO public.cidade VALUES (1774, 'Cordislândia', 11);
INSERT INTO public.cidade VALUES (1775, 'Corinto', 11);
INSERT INTO public.cidade VALUES (1776, 'Coroaci', 11);
INSERT INTO public.cidade VALUES (1777, 'Coromandel', 11);
INSERT INTO public.cidade VALUES (1778, 'Coronel Fabriciano', 11);
INSERT INTO public.cidade VALUES (1779, 'Coronel Murta', 11);
INSERT INTO public.cidade VALUES (1780, 'Coronel Pacheco', 11);
INSERT INTO public.cidade VALUES (1781, 'Coronel Xavier Chaves', 11);
INSERT INTO public.cidade VALUES (1782, 'Córrego Danta', 11);
INSERT INTO public.cidade VALUES (1783, 'Córrego do Bom Jesus', 11);
INSERT INTO public.cidade VALUES (1784, 'Córrego Fundo', 11);
INSERT INTO public.cidade VALUES (1785, 'Córrego Novo', 11);
INSERT INTO public.cidade VALUES (1786, 'Couto de Magalhães de Minas', 11);
INSERT INTO public.cidade VALUES (1787, 'Crisólita', 11);
INSERT INTO public.cidade VALUES (1788, 'Cristais', 11);
INSERT INTO public.cidade VALUES (1789, 'Cristália', 11);
INSERT INTO public.cidade VALUES (1790, 'Cristiano Otoni', 11);
INSERT INTO public.cidade VALUES (1791, 'Cristina', 11);
INSERT INTO public.cidade VALUES (1792, 'Crucilândia', 11);
INSERT INTO public.cidade VALUES (1793, 'Cruzeiro da Fortaleza', 11);
INSERT INTO public.cidade VALUES (1794, 'Cruzília', 11);
INSERT INTO public.cidade VALUES (1795, 'Cuparaque', 11);
INSERT INTO public.cidade VALUES (1796, 'Curral de Dentro', 11);
INSERT INTO public.cidade VALUES (1797, 'Curvelo', 11);
INSERT INTO public.cidade VALUES (1798, 'Datas', 11);
INSERT INTO public.cidade VALUES (1799, 'Delfim Moreira', 11);
INSERT INTO public.cidade VALUES (1800, 'Delfinópolis', 11);
INSERT INTO public.cidade VALUES (1801, 'Delta', 11);
INSERT INTO public.cidade VALUES (1802, 'Descoberto', 11);
INSERT INTO public.cidade VALUES (1803, 'Desterro de Entre Rios', 11);
INSERT INTO public.cidade VALUES (1804, 'Desterro do Melo', 11);
INSERT INTO public.cidade VALUES (1805, 'Diamantina', 11);
INSERT INTO public.cidade VALUES (1806, 'Diogo de Vasconcelos', 11);
INSERT INTO public.cidade VALUES (1807, 'Dionísio', 11);
INSERT INTO public.cidade VALUES (1808, 'Divinésia', 11);
INSERT INTO public.cidade VALUES (1809, 'Divino', 11);
INSERT INTO public.cidade VALUES (1810, 'Divino das Laranjeiras', 11);
INSERT INTO public.cidade VALUES (1811, 'Divinolândia de Minas', 11);
INSERT INTO public.cidade VALUES (1812, 'Divinópolis', 11);
INSERT INTO public.cidade VALUES (1813, 'Divisa Alegre', 11);
INSERT INTO public.cidade VALUES (1814, 'Divisa Nova', 11);
INSERT INTO public.cidade VALUES (1815, 'Divisópolis', 11);
INSERT INTO public.cidade VALUES (1816, 'Dom Bosco', 11);
INSERT INTO public.cidade VALUES (1817, 'Dom Cavati', 11);
INSERT INTO public.cidade VALUES (1818, 'Dom Joaquim', 11);
INSERT INTO public.cidade VALUES (1819, 'Dom Silvério', 11);
INSERT INTO public.cidade VALUES (1820, 'Dom Viçoso', 11);
INSERT INTO public.cidade VALUES (1821, 'Dona Eusébia', 11);
INSERT INTO public.cidade VALUES (1822, 'Dores de Campos', 11);
INSERT INTO public.cidade VALUES (1823, 'Dores de Guanhães', 11);
INSERT INTO public.cidade VALUES (1824, 'Dores do Indaiá', 11);
INSERT INTO public.cidade VALUES (1825, 'Dores do Turvo', 11);
INSERT INTO public.cidade VALUES (1826, 'Doresópolis', 11);
INSERT INTO public.cidade VALUES (1827, 'Douradoquara', 11);
INSERT INTO public.cidade VALUES (1828, 'Durandé', 11);
INSERT INTO public.cidade VALUES (1829, 'Elói Mendes', 11);
INSERT INTO public.cidade VALUES (1830, 'Engenheiro Caldas', 11);
INSERT INTO public.cidade VALUES (1831, 'Engenheiro Navarro', 11);
INSERT INTO public.cidade VALUES (1832, 'Entre Folhas', 11);
INSERT INTO public.cidade VALUES (1833, 'Entre Rios de Minas', 11);
INSERT INTO public.cidade VALUES (1834, 'Ervália', 11);
INSERT INTO public.cidade VALUES (1835, 'Esmeraldas', 11);
INSERT INTO public.cidade VALUES (1836, 'Espera Feliz', 11);
INSERT INTO public.cidade VALUES (1837, 'Espinosa', 11);
INSERT INTO public.cidade VALUES (1838, 'Espírito Santo do Dourado', 11);
INSERT INTO public.cidade VALUES (1839, 'Estiva', 11);
INSERT INTO public.cidade VALUES (1840, 'Estrela Dalva', 11);
INSERT INTO public.cidade VALUES (1841, 'Estrela do Indaiá', 11);
INSERT INTO public.cidade VALUES (1842, 'Estrela do Sul', 11);
INSERT INTO public.cidade VALUES (1843, 'Eugenópolis', 11);
INSERT INTO public.cidade VALUES (1844, 'Ewbank da Câmara', 11);
INSERT INTO public.cidade VALUES (1845, 'Extrema', 11);
INSERT INTO public.cidade VALUES (1846, 'Fama', 11);
INSERT INTO public.cidade VALUES (1847, 'Faria Lemos', 11);
INSERT INTO public.cidade VALUES (1848, 'Felício dos Santos', 11);
INSERT INTO public.cidade VALUES (1849, 'Felisburgo', 11);
INSERT INTO public.cidade VALUES (1850, 'Felixlândia', 11);
INSERT INTO public.cidade VALUES (1851, 'Fernandes Tourinho', 11);
INSERT INTO public.cidade VALUES (1852, 'Ferros', 11);
INSERT INTO public.cidade VALUES (1853, 'Fervedouro', 11);
INSERT INTO public.cidade VALUES (1854, 'Florestal', 11);
INSERT INTO public.cidade VALUES (1855, 'Formiga', 11);
INSERT INTO public.cidade VALUES (1856, 'Formoso', 11);
INSERT INTO public.cidade VALUES (1857, 'Fortaleza de Minas', 11);
INSERT INTO public.cidade VALUES (1858, 'Fortuna de Minas', 11);
INSERT INTO public.cidade VALUES (1859, 'Francisco Badaró', 11);
INSERT INTO public.cidade VALUES (1860, 'Francisco Dumont', 11);
INSERT INTO public.cidade VALUES (1861, 'Francisco Sá', 11);
INSERT INTO public.cidade VALUES (1862, 'Franciscópolis', 11);
INSERT INTO public.cidade VALUES (1863, 'Frei Gaspar', 11);
INSERT INTO public.cidade VALUES (1864, 'Frei Inocêncio', 11);
INSERT INTO public.cidade VALUES (1865, 'Frei Lagonegro', 11);
INSERT INTO public.cidade VALUES (1866, 'Fronteira', 11);
INSERT INTO public.cidade VALUES (1867, 'Fronteira dos Vales', 11);
INSERT INTO public.cidade VALUES (1868, 'Fruta de Leite', 11);
INSERT INTO public.cidade VALUES (1869, 'Frutal', 11);
INSERT INTO public.cidade VALUES (1870, 'Funilândia', 11);
INSERT INTO public.cidade VALUES (1871, 'Galiléia', 11);
INSERT INTO public.cidade VALUES (1872, 'Gameleiras', 11);
INSERT INTO public.cidade VALUES (1873, 'Glaucilândia', 11);
INSERT INTO public.cidade VALUES (1874, 'Goiabeira', 11);
INSERT INTO public.cidade VALUES (1875, 'Goianá', 11);
INSERT INTO public.cidade VALUES (1876, 'Gonçalves', 11);
INSERT INTO public.cidade VALUES (1877, 'Gonzaga', 11);
INSERT INTO public.cidade VALUES (1878, 'Gouveia', 11);
INSERT INTO public.cidade VALUES (1879, 'Governador Valadares', 11);
INSERT INTO public.cidade VALUES (1880, 'Grão Mogol', 11);
INSERT INTO public.cidade VALUES (1881, 'Grupiara', 11);
INSERT INTO public.cidade VALUES (1882, 'Guanhães', 11);
INSERT INTO public.cidade VALUES (1883, 'Guapé', 11);
INSERT INTO public.cidade VALUES (1884, 'Guaraciaba', 11);
INSERT INTO public.cidade VALUES (1885, 'Guaraciama', 11);
INSERT INTO public.cidade VALUES (1886, 'Guaranésia', 11);
INSERT INTO public.cidade VALUES (1887, 'Guarani', 11);
INSERT INTO public.cidade VALUES (1888, 'Guarará', 11);
INSERT INTO public.cidade VALUES (1889, 'Guarda-Mor', 11);
INSERT INTO public.cidade VALUES (1890, 'Guaxupé', 11);
INSERT INTO public.cidade VALUES (1891, 'Guidoval', 11);
INSERT INTO public.cidade VALUES (1892, 'Guimarânia', 11);
INSERT INTO public.cidade VALUES (1893, 'Guiricema', 11);
INSERT INTO public.cidade VALUES (1894, 'Gurinhatã', 11);
INSERT INTO public.cidade VALUES (1895, 'Heliodora', 11);
INSERT INTO public.cidade VALUES (1896, 'Iapu', 11);
INSERT INTO public.cidade VALUES (1897, 'Ibertioga', 11);
INSERT INTO public.cidade VALUES (1898, 'Ibiá', 11);
INSERT INTO public.cidade VALUES (1899, 'Ibiaí', 11);
INSERT INTO public.cidade VALUES (1900, 'Ibiracatu', 11);
INSERT INTO public.cidade VALUES (1901, 'Ibiraci', 11);
INSERT INTO public.cidade VALUES (1902, 'Ibirité', 11);
INSERT INTO public.cidade VALUES (1903, 'Ibitiúra de Minas', 11);
INSERT INTO public.cidade VALUES (1904, 'Ibituruna', 11);
INSERT INTO public.cidade VALUES (1905, 'Icaraí de Minas', 11);
INSERT INTO public.cidade VALUES (1906, 'Igarapé', 11);
INSERT INTO public.cidade VALUES (1907, 'Igaratinga', 11);
INSERT INTO public.cidade VALUES (1908, 'Iguatama', 11);
INSERT INTO public.cidade VALUES (1909, 'Ijaci', 11);
INSERT INTO public.cidade VALUES (1910, 'Ilicínea', 11);
INSERT INTO public.cidade VALUES (1911, 'Imbé de Minas', 11);
INSERT INTO public.cidade VALUES (1912, 'Inconfidentes', 11);
INSERT INTO public.cidade VALUES (1913, 'Indaiabira', 11);
INSERT INTO public.cidade VALUES (1914, 'Indianópolis', 11);
INSERT INTO public.cidade VALUES (1915, 'Ingaí', 11);
INSERT INTO public.cidade VALUES (1916, 'Inhapim', 11);
INSERT INTO public.cidade VALUES (1917, 'Inhaúma', 11);
INSERT INTO public.cidade VALUES (1918, 'Inimutaba', 11);
INSERT INTO public.cidade VALUES (1919, 'Ipaba', 11);
INSERT INTO public.cidade VALUES (1920, 'Ipanema', 11);
INSERT INTO public.cidade VALUES (1921, 'Ipatinga', 11);
INSERT INTO public.cidade VALUES (1922, 'Ipiaçu', 11);
INSERT INTO public.cidade VALUES (1923, 'Ipuiúna', 11);
INSERT INTO public.cidade VALUES (1924, 'Iraí de Minas', 11);
INSERT INTO public.cidade VALUES (1925, 'Itabira', 11);
INSERT INTO public.cidade VALUES (1927, 'Itabirito', 11);
INSERT INTO public.cidade VALUES (1928, 'Itacambira', 11);
INSERT INTO public.cidade VALUES (1929, 'Itacarambi', 11);
INSERT INTO public.cidade VALUES (1930, 'Itaguara', 11);
INSERT INTO public.cidade VALUES (1931, 'Itaipé', 11);
INSERT INTO public.cidade VALUES (1932, 'Itajubá', 11);
INSERT INTO public.cidade VALUES (1933, 'Itamarandiba', 11);
INSERT INTO public.cidade VALUES (1934, 'Itamarati de Minas', 11);
INSERT INTO public.cidade VALUES (1935, 'Itambacuri', 11);
INSERT INTO public.cidade VALUES (1936, 'Itambé do Mato Dentro', 11);
INSERT INTO public.cidade VALUES (1937, 'Itamogi', 11);
INSERT INTO public.cidade VALUES (1938, 'Itamonte', 11);
INSERT INTO public.cidade VALUES (1939, 'Itanhandu', 11);
INSERT INTO public.cidade VALUES (1940, 'Itanhomi', 11);
INSERT INTO public.cidade VALUES (1941, 'Itaobim', 11);
INSERT INTO public.cidade VALUES (1942, 'Itapagipe', 11);
INSERT INTO public.cidade VALUES (1943, 'Itapecerica', 11);
INSERT INTO public.cidade VALUES (1944, 'Itapeva', 11);
INSERT INTO public.cidade VALUES (1945, 'Itatiaiuçu', 11);
INSERT INTO public.cidade VALUES (1946, 'Itaú de Minas', 11);
INSERT INTO public.cidade VALUES (1947, 'Itaúna', 11);
INSERT INTO public.cidade VALUES (1948, 'Itaverava', 11);
INSERT INTO public.cidade VALUES (1949, 'Itinga', 11);
INSERT INTO public.cidade VALUES (1950, 'Itueta', 11);
INSERT INTO public.cidade VALUES (1951, 'Ituiutaba', 11);
INSERT INTO public.cidade VALUES (1952, 'Itumirim', 11);
INSERT INTO public.cidade VALUES (1953, 'Iturama', 11);
INSERT INTO public.cidade VALUES (1954, 'Itutinga', 11);
INSERT INTO public.cidade VALUES (1955, 'Jaboticatubas', 11);
INSERT INTO public.cidade VALUES (1956, 'Jacinto', 11);
INSERT INTO public.cidade VALUES (1957, 'Jacuí', 11);
INSERT INTO public.cidade VALUES (1958, 'Jacutinga', 11);
INSERT INTO public.cidade VALUES (1959, 'Jaguaraçu', 11);
INSERT INTO public.cidade VALUES (1960, 'Jaíba', 11);
INSERT INTO public.cidade VALUES (1961, 'Jampruca', 11);
INSERT INTO public.cidade VALUES (1962, 'Janaúba', 11);
INSERT INTO public.cidade VALUES (1963, 'Januária', 11);
INSERT INTO public.cidade VALUES (1964, 'Japaraíba', 11);
INSERT INTO public.cidade VALUES (1965, 'Japonvar', 11);
INSERT INTO public.cidade VALUES (1966, 'Jeceaba', 11);
INSERT INTO public.cidade VALUES (1967, 'Jenipapo de Minas', 11);
INSERT INTO public.cidade VALUES (1968, 'Jequeri', 11);
INSERT INTO public.cidade VALUES (1969, 'Jequitaí', 11);
INSERT INTO public.cidade VALUES (1970, 'Jequitibá', 11);
INSERT INTO public.cidade VALUES (1971, 'Jequitinhonha', 11);
INSERT INTO public.cidade VALUES (1972, 'Jesuânia', 11);
INSERT INTO public.cidade VALUES (1973, 'Joaíma', 11);
INSERT INTO public.cidade VALUES (1974, 'Joanésia', 11);
INSERT INTO public.cidade VALUES (1975, 'João Monlevade', 11);
INSERT INTO public.cidade VALUES (1976, 'João Pinheiro', 11);
INSERT INTO public.cidade VALUES (1977, 'Joaquim Felício', 11);
INSERT INTO public.cidade VALUES (1978, 'Jordânia', 11);
INSERT INTO public.cidade VALUES (1979, 'José Gonçalves de Minas', 11);
INSERT INTO public.cidade VALUES (1980, 'José Raydan', 11);
INSERT INTO public.cidade VALUES (1981, 'Josenópolis', 11);
INSERT INTO public.cidade VALUES (1982, 'Juatuba', 11);
INSERT INTO public.cidade VALUES (1983, 'Juiz de Fora', 11);
INSERT INTO public.cidade VALUES (1984, 'Juramento', 11);
INSERT INTO public.cidade VALUES (1985, 'Juruaia', 11);
INSERT INTO public.cidade VALUES (1986, 'Juvenília', 11);
INSERT INTO public.cidade VALUES (1987, 'Ladainha', 11);
INSERT INTO public.cidade VALUES (1988, 'Lagamar', 11);
INSERT INTO public.cidade VALUES (1989, 'Lagoa da Prata', 11);
INSERT INTO public.cidade VALUES (1990, 'Lagoa dos Patos', 11);
INSERT INTO public.cidade VALUES (1991, 'Lagoa Dourada', 11);
INSERT INTO public.cidade VALUES (1992, 'Lagoa Formosa', 11);
INSERT INTO public.cidade VALUES (1993, 'Lagoa Grande', 11);
INSERT INTO public.cidade VALUES (1994, 'Lagoa Santa', 11);
INSERT INTO public.cidade VALUES (1995, 'Lajinha', 11);
INSERT INTO public.cidade VALUES (1996, 'Lambari', 11);
INSERT INTO public.cidade VALUES (1997, 'Lamim', 11);
INSERT INTO public.cidade VALUES (1998, 'Laranjal', 11);
INSERT INTO public.cidade VALUES (1999, 'Lassance', 11);
INSERT INTO public.cidade VALUES (2000, 'Lavras', 11);
INSERT INTO public.cidade VALUES (2001, 'Leandro Ferreira', 11);
INSERT INTO public.cidade VALUES (2002, 'Leme do Prado', 11);
INSERT INTO public.cidade VALUES (2003, 'Leopoldina', 11);
INSERT INTO public.cidade VALUES (2004, 'Liberdade', 11);
INSERT INTO public.cidade VALUES (2005, 'Lima Duarte', 11);
INSERT INTO public.cidade VALUES (2006, 'Limeira do Oeste', 11);
INSERT INTO public.cidade VALUES (2007, 'Lontra', 11);
INSERT INTO public.cidade VALUES (2008, 'Luisburgo', 11);
INSERT INTO public.cidade VALUES (2009, 'Luislândia', 11);
INSERT INTO public.cidade VALUES (2010, 'Luminárias', 11);
INSERT INTO public.cidade VALUES (2011, 'Luz', 11);
INSERT INTO public.cidade VALUES (2012, 'Machacalis', 11);
INSERT INTO public.cidade VALUES (2013, 'Machado', 11);
INSERT INTO public.cidade VALUES (2014, 'Madre de Deus de Minas', 11);
INSERT INTO public.cidade VALUES (2015, 'Malacacheta', 11);
INSERT INTO public.cidade VALUES (2016, 'Mamonas', 11);
INSERT INTO public.cidade VALUES (2017, 'Manga', 11);
INSERT INTO public.cidade VALUES (2018, 'Manhuaçu', 11);
INSERT INTO public.cidade VALUES (2019, 'Manhumirim', 11);
INSERT INTO public.cidade VALUES (2020, 'Mantena', 11);
INSERT INTO public.cidade VALUES (2021, 'Mar de Espanha', 11);
INSERT INTO public.cidade VALUES (2022, 'Maravilhas', 11);
INSERT INTO public.cidade VALUES (2023, 'Maria da Fé', 11);
INSERT INTO public.cidade VALUES (2024, 'Mariana', 11);
INSERT INTO public.cidade VALUES (2025, 'Marilac', 11);
INSERT INTO public.cidade VALUES (2026, 'Mário Campos', 11);
INSERT INTO public.cidade VALUES (2027, 'Maripá de Minas', 11);
INSERT INTO public.cidade VALUES (2028, 'Marliéria', 11);
INSERT INTO public.cidade VALUES (2029, 'Marmelópolis', 11);
INSERT INTO public.cidade VALUES (2030, 'Martinho Campos', 11);
INSERT INTO public.cidade VALUES (2031, 'Martins Soares', 11);
INSERT INTO public.cidade VALUES (2032, 'Mata Verde', 11);
INSERT INTO public.cidade VALUES (2033, 'Materlândia', 11);
INSERT INTO public.cidade VALUES (2034, 'Mateus Leme', 11);
INSERT INTO public.cidade VALUES (2035, 'Mathias Lobato', 11);
INSERT INTO public.cidade VALUES (2036, 'Matias Barbosa', 11);
INSERT INTO public.cidade VALUES (2037, 'Matias Cardoso', 11);
INSERT INTO public.cidade VALUES (2038, 'Matipó', 11);
INSERT INTO public.cidade VALUES (2039, 'Mato Verde', 11);
INSERT INTO public.cidade VALUES (2040, 'Matozinhos', 11);
INSERT INTO public.cidade VALUES (2041, 'Matutina', 11);
INSERT INTO public.cidade VALUES (2042, 'Medeiros', 11);
INSERT INTO public.cidade VALUES (2043, 'Medina', 11);
INSERT INTO public.cidade VALUES (2044, 'Mendes Pimentel', 11);
INSERT INTO public.cidade VALUES (2045, 'Mercês', 11);
INSERT INTO public.cidade VALUES (2046, 'Mesquita', 11);
INSERT INTO public.cidade VALUES (2047, 'Minas Novas', 11);
INSERT INTO public.cidade VALUES (2048, 'Minduri', 11);
INSERT INTO public.cidade VALUES (2049, 'Mirabela', 11);
INSERT INTO public.cidade VALUES (2050, 'Miradouro', 11);
INSERT INTO public.cidade VALUES (2051, 'Miraí', 11);
INSERT INTO public.cidade VALUES (2052, 'Miravânia', 11);
INSERT INTO public.cidade VALUES (2053, 'Moeda', 11);
INSERT INTO public.cidade VALUES (2054, 'Moema', 11);
INSERT INTO public.cidade VALUES (2055, 'Monjolos', 11);
INSERT INTO public.cidade VALUES (2056, 'Monsenhor Paulo', 11);
INSERT INTO public.cidade VALUES (2057, 'Montalvânia', 11);
INSERT INTO public.cidade VALUES (2058, 'Monte Alegre de Minas', 11);
INSERT INTO public.cidade VALUES (2059, 'Monte Azul', 11);
INSERT INTO public.cidade VALUES (2060, 'Monte Belo', 11);
INSERT INTO public.cidade VALUES (2061, 'Monte Carmelo', 11);
INSERT INTO public.cidade VALUES (2062, 'Monte Formoso', 11);
INSERT INTO public.cidade VALUES (2063, 'Monte Santo de Minas', 11);
INSERT INTO public.cidade VALUES (2064, 'Monte Sião', 11);
INSERT INTO public.cidade VALUES (2065, 'Montes Claros', 11);
INSERT INTO public.cidade VALUES (2066, 'Montezuma', 11);
INSERT INTO public.cidade VALUES (2067, 'Morada Nova de Minas', 11);
INSERT INTO public.cidade VALUES (2068, 'Morro da Garça', 11);
INSERT INTO public.cidade VALUES (2069, 'Morro do Pilar', 11);
INSERT INTO public.cidade VALUES (2070, 'Munhoz', 11);
INSERT INTO public.cidade VALUES (2071, 'Muriaé', 11);
INSERT INTO public.cidade VALUES (2072, 'Mutum', 11);
INSERT INTO public.cidade VALUES (2073, 'Muzambinho', 11);
INSERT INTO public.cidade VALUES (2074, 'Nacip Raydan', 11);
INSERT INTO public.cidade VALUES (2075, 'Nanuque', 11);
INSERT INTO public.cidade VALUES (2076, 'Naque', 11);
INSERT INTO public.cidade VALUES (2077, 'Natalândia', 11);
INSERT INTO public.cidade VALUES (2078, 'Natércia', 11);
INSERT INTO public.cidade VALUES (2079, 'Nazareno', 11);
INSERT INTO public.cidade VALUES (2080, 'Nepomuceno', 11);
INSERT INTO public.cidade VALUES (2081, 'Ninheira', 11);
INSERT INTO public.cidade VALUES (2082, 'Nova Belém', 11);
INSERT INTO public.cidade VALUES (2083, 'Nova Era', 11);
INSERT INTO public.cidade VALUES (2084, 'Nova Lima', 11);
INSERT INTO public.cidade VALUES (2085, 'Nova Módica', 11);
INSERT INTO public.cidade VALUES (2086, 'Nova Ponte', 11);
INSERT INTO public.cidade VALUES (2087, 'Nova Porteirinha', 11);
INSERT INTO public.cidade VALUES (2088, 'Nova Resende', 11);
INSERT INTO public.cidade VALUES (2089, 'Nova Serrana', 11);
INSERT INTO public.cidade VALUES (2090, 'Nova União', 11);
INSERT INTO public.cidade VALUES (2091, 'Novo Cruzeiro', 11);
INSERT INTO public.cidade VALUES (2092, 'Novo Oriente de Minas', 11);
INSERT INTO public.cidade VALUES (2093, 'Novorizonte', 11);
INSERT INTO public.cidade VALUES (2094, 'Olaria', 11);
INSERT INTO public.cidade VALUES (2095, 'Olhos-d`Água', 11);
INSERT INTO public.cidade VALUES (2096, 'Olímpio Noronha', 11);
INSERT INTO public.cidade VALUES (2097, 'Oliveira', 11);
INSERT INTO public.cidade VALUES (2098, 'Oliveira Fortes', 11);
INSERT INTO public.cidade VALUES (2099, 'Onça de Pitangui', 11);
INSERT INTO public.cidade VALUES (2100, 'Oratórios', 11);
INSERT INTO public.cidade VALUES (2101, 'Orizânia', 11);
INSERT INTO public.cidade VALUES (2102, 'Ouro Branco', 11);
INSERT INTO public.cidade VALUES (2103, 'Ouro Fino', 11);
INSERT INTO public.cidade VALUES (2104, 'Ouro Preto', 11);
INSERT INTO public.cidade VALUES (2105, 'Ouro Verde de Minas', 11);
INSERT INTO public.cidade VALUES (2106, 'Padre Carvalho', 11);
INSERT INTO public.cidade VALUES (2107, 'Padre Paraíso', 11);
INSERT INTO public.cidade VALUES (2108, 'Pai Pedro', 11);
INSERT INTO public.cidade VALUES (2109, 'Paineiras', 11);
INSERT INTO public.cidade VALUES (2110, 'Pains', 11);
INSERT INTO public.cidade VALUES (2111, 'Paiva', 11);
INSERT INTO public.cidade VALUES (2112, 'Palma', 11);
INSERT INTO public.cidade VALUES (2113, 'Palmópolis', 11);
INSERT INTO public.cidade VALUES (2114, 'Papagaios', 11);
INSERT INTO public.cidade VALUES (2115, 'Pará de Minas', 11);
INSERT INTO public.cidade VALUES (2116, 'Paracatu', 11);
INSERT INTO public.cidade VALUES (2117, 'Paraguaçu', 11);
INSERT INTO public.cidade VALUES (2118, 'Paraisópolis', 11);
INSERT INTO public.cidade VALUES (2119, 'Paraopeba', 11);
INSERT INTO public.cidade VALUES (2120, 'Passa Quatro', 11);
INSERT INTO public.cidade VALUES (2121, 'Passa Tempo', 11);
INSERT INTO public.cidade VALUES (2122, 'Passabém', 11);
INSERT INTO public.cidade VALUES (2123, 'Passa-Vinte', 11);
INSERT INTO public.cidade VALUES (2124, 'Passos', 11);
INSERT INTO public.cidade VALUES (2125, 'Patis', 11);
INSERT INTO public.cidade VALUES (2126, 'Patos de Minas', 11);
INSERT INTO public.cidade VALUES (2127, 'Patrocínio', 11);
INSERT INTO public.cidade VALUES (2128, 'Patrocínio do Muriaé', 11);
INSERT INTO public.cidade VALUES (2129, 'Paula Cândido', 11);
INSERT INTO public.cidade VALUES (2130, 'Paulistas', 11);
INSERT INTO public.cidade VALUES (2131, 'Pavão', 11);
INSERT INTO public.cidade VALUES (2132, 'Peçanha', 11);
INSERT INTO public.cidade VALUES (2133, 'Pedra Azul', 11);
INSERT INTO public.cidade VALUES (2134, 'Pedra Bonita', 11);
INSERT INTO public.cidade VALUES (2135, 'Pedra do Anta', 11);
INSERT INTO public.cidade VALUES (2136, 'Pedra do Indaiá', 11);
INSERT INTO public.cidade VALUES (2137, 'Pedra Dourada', 11);
INSERT INTO public.cidade VALUES (2138, 'Pedralva', 11);
INSERT INTO public.cidade VALUES (2139, 'Pedras de Maria da Cruz', 11);
INSERT INTO public.cidade VALUES (2140, 'Pedrinópolis', 11);
INSERT INTO public.cidade VALUES (2141, 'Pedro Leopoldo', 11);
INSERT INTO public.cidade VALUES (2142, 'Pedro Teixeira', 11);
INSERT INTO public.cidade VALUES (2143, 'Pequeri', 11);
INSERT INTO public.cidade VALUES (2144, 'Pequi', 11);
INSERT INTO public.cidade VALUES (2145, 'Perdigão', 11);
INSERT INTO public.cidade VALUES (2146, 'Perdizes', 11);
INSERT INTO public.cidade VALUES (2147, 'Perdões', 11);
INSERT INTO public.cidade VALUES (2148, 'Periquito', 11);
INSERT INTO public.cidade VALUES (2149, 'Pescador', 11);
INSERT INTO public.cidade VALUES (2150, 'Piau', 11);
INSERT INTO public.cidade VALUES (2151, 'Piedade de Caratinga', 11);
INSERT INTO public.cidade VALUES (2152, 'Piedade de Ponte Nova', 11);
INSERT INTO public.cidade VALUES (2153, 'Piedade do Rio Grande', 11);
INSERT INTO public.cidade VALUES (2154, 'Piedade dos Gerais', 11);
INSERT INTO public.cidade VALUES (2155, 'Pimenta', 11);
INSERT INTO public.cidade VALUES (2156, 'Pingo-d`Água', 11);
INSERT INTO public.cidade VALUES (2157, 'Pintópolis', 11);
INSERT INTO public.cidade VALUES (2158, 'Piracema', 11);
INSERT INTO public.cidade VALUES (2159, 'Pirajuba', 11);
INSERT INTO public.cidade VALUES (2160, 'Piranga', 11);
INSERT INTO public.cidade VALUES (2161, 'Piranguçu', 11);
INSERT INTO public.cidade VALUES (2162, 'Piranguinho', 11);
INSERT INTO public.cidade VALUES (2163, 'Pirapetinga', 11);
INSERT INTO public.cidade VALUES (2164, 'Pirapora', 11);
INSERT INTO public.cidade VALUES (2165, 'Piraúba', 11);
INSERT INTO public.cidade VALUES (2166, 'Pitangui', 11);
INSERT INTO public.cidade VALUES (2167, 'Piumhi', 11);
INSERT INTO public.cidade VALUES (2168, 'Planura', 11);
INSERT INTO public.cidade VALUES (2169, 'Poço Fundo', 11);
INSERT INTO public.cidade VALUES (2170, 'Poços de Caldas', 11);
INSERT INTO public.cidade VALUES (2171, 'Pocrane', 11);
INSERT INTO public.cidade VALUES (2172, 'Pompéu', 11);
INSERT INTO public.cidade VALUES (2173, 'Ponte Nova', 11);
INSERT INTO public.cidade VALUES (2174, 'Ponto Chique', 11);
INSERT INTO public.cidade VALUES (2175, 'Ponto dos Volantes', 11);
INSERT INTO public.cidade VALUES (2176, 'Porteirinha', 11);
INSERT INTO public.cidade VALUES (2177, 'Porto Firme', 11);
INSERT INTO public.cidade VALUES (2178, 'Poté', 11);
INSERT INTO public.cidade VALUES (2179, 'Pouso Alegre', 11);
INSERT INTO public.cidade VALUES (2180, 'Pouso Alto', 11);
INSERT INTO public.cidade VALUES (2181, 'Prados', 11);
INSERT INTO public.cidade VALUES (2182, 'Prata', 11);
INSERT INTO public.cidade VALUES (2183, 'Pratápolis', 11);
INSERT INTO public.cidade VALUES (2184, 'Pratinha', 11);
INSERT INTO public.cidade VALUES (2185, 'Presidente Bernardes', 11);
INSERT INTO public.cidade VALUES (2186, 'Presidente Juscelino', 11);
INSERT INTO public.cidade VALUES (2187, 'Presidente Kubitschek', 11);
INSERT INTO public.cidade VALUES (2188, 'Presidente Olegário', 11);
INSERT INTO public.cidade VALUES (2189, 'Prudente de Morais', 11);
INSERT INTO public.cidade VALUES (2190, 'Quartel Geral', 11);
INSERT INTO public.cidade VALUES (2191, 'Queluzito', 11);
INSERT INTO public.cidade VALUES (2192, 'Raposos', 11);
INSERT INTO public.cidade VALUES (2193, 'Raul Soares', 11);
INSERT INTO public.cidade VALUES (2194, 'Recreio', 11);
INSERT INTO public.cidade VALUES (2195, 'Reduto', 11);
INSERT INTO public.cidade VALUES (2196, 'Resende Costa', 11);
INSERT INTO public.cidade VALUES (2197, 'Resplendor', 11);
INSERT INTO public.cidade VALUES (2198, 'Ressaquinha', 11);
INSERT INTO public.cidade VALUES (2199, 'Riachinho', 11);
INSERT INTO public.cidade VALUES (2200, 'Riacho dos Machados', 11);
INSERT INTO public.cidade VALUES (2201, 'Ribeirão das Neves', 11);
INSERT INTO public.cidade VALUES (2202, 'Ribeirão Vermelho', 11);
INSERT INTO public.cidade VALUES (2203, 'Rio Acima', 11);
INSERT INTO public.cidade VALUES (2204, 'Rio Casca', 11);
INSERT INTO public.cidade VALUES (2205, 'Rio do Prado', 11);
INSERT INTO public.cidade VALUES (2206, 'Rio Doce', 11);
INSERT INTO public.cidade VALUES (2207, 'Rio Espera', 11);
INSERT INTO public.cidade VALUES (2208, 'Rio Manso', 11);
INSERT INTO public.cidade VALUES (2209, 'Rio Novo', 11);
INSERT INTO public.cidade VALUES (2210, 'Rio Paranaíba', 11);
INSERT INTO public.cidade VALUES (2211, 'Rio Pardo de Minas', 11);
INSERT INTO public.cidade VALUES (2212, 'Rio Piracicaba', 11);
INSERT INTO public.cidade VALUES (2213, 'Rio Pomba', 11);
INSERT INTO public.cidade VALUES (2214, 'Rio Preto', 11);
INSERT INTO public.cidade VALUES (2215, 'Rio Vermelho', 11);
INSERT INTO public.cidade VALUES (2216, 'Ritápolis', 11);
INSERT INTO public.cidade VALUES (2217, 'Rochedo de Minas', 11);
INSERT INTO public.cidade VALUES (2218, 'Rodeiro', 11);
INSERT INTO public.cidade VALUES (2219, 'Romaria', 11);
INSERT INTO public.cidade VALUES (2220, 'Rosário da Limeira', 11);
INSERT INTO public.cidade VALUES (2221, 'Rubelita', 11);
INSERT INTO public.cidade VALUES (2222, 'Rubim', 11);
INSERT INTO public.cidade VALUES (2223, 'Sabará', 11);
INSERT INTO public.cidade VALUES (2224, 'Sabinópolis', 11);
INSERT INTO public.cidade VALUES (2225, 'Sacramento', 11);
INSERT INTO public.cidade VALUES (2226, 'Salinas', 11);
INSERT INTO public.cidade VALUES (2227, 'Salto da Divisa', 11);
INSERT INTO public.cidade VALUES (2228, 'Santa Bárbara', 11);
INSERT INTO public.cidade VALUES (2229, 'Santa Bárbara do Leste', 11);
INSERT INTO public.cidade VALUES (2230, 'Santa Bárbara do Monte Verde', 11);
INSERT INTO public.cidade VALUES (2231, 'Santa Bárbara do Tugúrio', 11);
INSERT INTO public.cidade VALUES (2232, 'Santa Cruz de Minas', 11);
INSERT INTO public.cidade VALUES (2233, 'Santa Cruz de Salinas', 11);
INSERT INTO public.cidade VALUES (2234, 'Santa Cruz do Escalvado', 11);
INSERT INTO public.cidade VALUES (2235, 'Santa Efigênia de Minas', 11);
INSERT INTO public.cidade VALUES (2236, 'Santa Fé de Minas', 11);
INSERT INTO public.cidade VALUES (2237, 'Santa Helena de Minas', 11);
INSERT INTO public.cidade VALUES (2238, 'Santa Juliana', 11);
INSERT INTO public.cidade VALUES (2239, 'Santa Luzia', 11);
INSERT INTO public.cidade VALUES (2240, 'Santa Margarida', 11);
INSERT INTO public.cidade VALUES (2241, 'Santa Maria de Itabira', 11);
INSERT INTO public.cidade VALUES (2242, 'Santa Maria do Salto', 11);
INSERT INTO public.cidade VALUES (2243, 'Santa Maria do Suaçuí', 11);
INSERT INTO public.cidade VALUES (2244, 'Santa Rita de Caldas', 11);
INSERT INTO public.cidade VALUES (2245, 'Santa Rita de Ibitipoca', 11);
INSERT INTO public.cidade VALUES (2246, 'Santa Rita de Jacutinga', 11);
INSERT INTO public.cidade VALUES (2247, 'Santa Rita de Minas', 11);
INSERT INTO public.cidade VALUES (2248, 'Santa Rita do Itueto', 11);
INSERT INTO public.cidade VALUES (2249, 'Santa Rita do Sapucaí', 11);
INSERT INTO public.cidade VALUES (2250, 'Santa Rosa da Serra', 11);
INSERT INTO public.cidade VALUES (2251, 'Santa Vitória', 11);
INSERT INTO public.cidade VALUES (2252, 'Santana da Vargem', 11);
INSERT INTO public.cidade VALUES (2253, 'Santana de Cataguases', 11);
INSERT INTO public.cidade VALUES (2254, 'Santana de Pirapama', 11);
INSERT INTO public.cidade VALUES (2255, 'Santana do Deserto', 11);
INSERT INTO public.cidade VALUES (2256, 'Santana do Garambéu', 11);
INSERT INTO public.cidade VALUES (2257, 'Santana do Jacaré', 11);
INSERT INTO public.cidade VALUES (2258, 'Santana do Manhuaçu', 11);
INSERT INTO public.cidade VALUES (2259, 'Santana do Paraíso', 11);
INSERT INTO public.cidade VALUES (2260, 'Santana do Riacho', 11);
INSERT INTO public.cidade VALUES (2261, 'Santana dos Montes', 11);
INSERT INTO public.cidade VALUES (2262, 'Santo Antônio do Amparo', 11);
INSERT INTO public.cidade VALUES (2263, 'Santo Antônio do Aventureiro', 11);
INSERT INTO public.cidade VALUES (2264, 'Santo Antônio do Grama', 11);
INSERT INTO public.cidade VALUES (2265, 'Santo Antônio do Itambé', 11);
INSERT INTO public.cidade VALUES (2266, 'Santo Antônio do Jacinto', 11);
INSERT INTO public.cidade VALUES (2267, 'Santo Antônio do Monte', 11);
INSERT INTO public.cidade VALUES (2268, 'Santo Antônio do Retiro', 11);
INSERT INTO public.cidade VALUES (2269, 'Santo Antônio do Rio Abaixo', 11);
INSERT INTO public.cidade VALUES (2270, 'Santo Hipólito', 11);
INSERT INTO public.cidade VALUES (2271, 'Santos Dumont', 11);
INSERT INTO public.cidade VALUES (2272, 'São Bento Abade', 11);
INSERT INTO public.cidade VALUES (2273, 'São Brás do Suaçuí', 11);
INSERT INTO public.cidade VALUES (2274, 'São Domingos das Dores', 11);
INSERT INTO public.cidade VALUES (2275, 'São Domingos do Prata', 11);
INSERT INTO public.cidade VALUES (2276, 'São Félix de Minas', 11);
INSERT INTO public.cidade VALUES (2277, 'São Francisco', 11);
INSERT INTO public.cidade VALUES (2278, 'São Francisco de Paula', 11);
INSERT INTO public.cidade VALUES (2279, 'São Francisco de Sales', 11);
INSERT INTO public.cidade VALUES (2280, 'São Francisco do Glória', 11);
INSERT INTO public.cidade VALUES (2281, 'São Geraldo', 11);
INSERT INTO public.cidade VALUES (2282, 'São Geraldo da Piedade', 11);
INSERT INTO public.cidade VALUES (2283, 'São Geraldo do Baixio', 11);
INSERT INTO public.cidade VALUES (2284, 'São Gonçalo do Abaeté', 11);
INSERT INTO public.cidade VALUES (2285, 'São Gonçalo do Pará', 11);
INSERT INTO public.cidade VALUES (2286, 'São Gonçalo do Rio Abaixo', 11);
INSERT INTO public.cidade VALUES (2287, 'São Gonçalo do Rio Preto', 11);
INSERT INTO public.cidade VALUES (2288, 'São Gonçalo do Sapucaí', 11);
INSERT INTO public.cidade VALUES (2289, 'São Gotardo', 11);
INSERT INTO public.cidade VALUES (2290, 'São João Batista do Glória', 11);
INSERT INTO public.cidade VALUES (2291, 'São João da Lagoa', 11);
INSERT INTO public.cidade VALUES (2292, 'São João da Mata', 11);
INSERT INTO public.cidade VALUES (2293, 'São João da Ponte', 11);
INSERT INTO public.cidade VALUES (2294, 'São João das Missões', 11);
INSERT INTO public.cidade VALUES (2295, 'São João del Rei', 11);
INSERT INTO public.cidade VALUES (2296, 'São João do Manhuaçu', 11);
INSERT INTO public.cidade VALUES (2297, 'São João do Manteninha', 11);
INSERT INTO public.cidade VALUES (2298, 'São João do Oriente', 11);
INSERT INTO public.cidade VALUES (2299, 'São João do Pacuí', 11);
INSERT INTO public.cidade VALUES (2300, 'São João do Paraíso', 11);
INSERT INTO public.cidade VALUES (2301, 'São João Evangelista', 11);
INSERT INTO public.cidade VALUES (2302, 'São João Nepomuceno', 11);
INSERT INTO public.cidade VALUES (2303, 'São Joaquim de Bicas', 11);
INSERT INTO public.cidade VALUES (2304, 'São José da Barra', 11);
INSERT INTO public.cidade VALUES (2305, 'São José da Lapa', 11);
INSERT INTO public.cidade VALUES (2306, 'São José da Safira', 11);
INSERT INTO public.cidade VALUES (2307, 'São José da Varginha', 11);
INSERT INTO public.cidade VALUES (2308, 'São José do Alegre', 11);
INSERT INTO public.cidade VALUES (2309, 'São José do Divino', 11);
INSERT INTO public.cidade VALUES (2310, 'São José do Goiabal', 11);
INSERT INTO public.cidade VALUES (2311, 'São José do Jacuri', 11);
INSERT INTO public.cidade VALUES (2312, 'São José do Mantimento', 11);
INSERT INTO public.cidade VALUES (2313, 'São Lourenço', 11);
INSERT INTO public.cidade VALUES (2314, 'São Miguel do Anta', 11);
INSERT INTO public.cidade VALUES (2315, 'São Pedro da União', 11);
INSERT INTO public.cidade VALUES (2316, 'São Pedro do Suaçuí', 11);
INSERT INTO public.cidade VALUES (2317, 'São Pedro dos Ferros', 11);
INSERT INTO public.cidade VALUES (2318, 'São Romão', 11);
INSERT INTO public.cidade VALUES (2319, 'São Roque de Minas', 11);
INSERT INTO public.cidade VALUES (2320, 'São Sebastião da Bela Vista', 11);
INSERT INTO public.cidade VALUES (2321, 'São Sebastião da Vargem Alegre', 11);
INSERT INTO public.cidade VALUES (2322, 'São Sebastião do Anta', 11);
INSERT INTO public.cidade VALUES (2323, 'São Sebastião do Maranhão', 11);
INSERT INTO public.cidade VALUES (2324, 'São Sebastião do Oeste', 11);
INSERT INTO public.cidade VALUES (2325, 'São Sebastião do Paraíso', 11);
INSERT INTO public.cidade VALUES (2326, 'São Sebastião do Rio Preto', 11);
INSERT INTO public.cidade VALUES (2327, 'São Sebastião do Rio Verde', 11);
INSERT INTO public.cidade VALUES (2328, 'São Thomé das Letras', 11);
INSERT INTO public.cidade VALUES (2329, 'São Tiago', 11);
INSERT INTO public.cidade VALUES (2330, 'São Tomás de Aquino', 11);
INSERT INTO public.cidade VALUES (2331, 'São Vicente de Minas', 11);
INSERT INTO public.cidade VALUES (2332, 'Sapucaí-Mirim', 11);
INSERT INTO public.cidade VALUES (2333, 'Sardoá', 11);
INSERT INTO public.cidade VALUES (2334, 'Sarzedo', 11);
INSERT INTO public.cidade VALUES (2335, 'Sem-Peixe', 11);
INSERT INTO public.cidade VALUES (2336, 'Senador Amaral', 11);
INSERT INTO public.cidade VALUES (2337, 'Senador Cortes', 11);
INSERT INTO public.cidade VALUES (2338, 'Senador Firmino', 11);
INSERT INTO public.cidade VALUES (2339, 'Senador José Bento', 11);
INSERT INTO public.cidade VALUES (2340, 'Senador Modestino Gonçalves', 11);
INSERT INTO public.cidade VALUES (2341, 'Senhora de Oliveira', 11);
INSERT INTO public.cidade VALUES (2342, 'Senhora do Porto', 11);
INSERT INTO public.cidade VALUES (2343, 'Senhora dos Remédios', 11);
INSERT INTO public.cidade VALUES (2344, 'Sericita', 11);
INSERT INTO public.cidade VALUES (2345, 'Seritinga', 11);
INSERT INTO public.cidade VALUES (2346, 'Serra Azul de Minas', 11);
INSERT INTO public.cidade VALUES (2347, 'Serra da Saudade', 11);
INSERT INTO public.cidade VALUES (2348, 'Serra do Salitre', 11);
INSERT INTO public.cidade VALUES (2349, 'Serra dos Aimorés', 11);
INSERT INTO public.cidade VALUES (2350, 'Serrania', 11);
INSERT INTO public.cidade VALUES (2351, 'Serranópolis de Minas', 11);
INSERT INTO public.cidade VALUES (2352, 'Serranos', 11);
INSERT INTO public.cidade VALUES (2353, 'Serro', 11);
INSERT INTO public.cidade VALUES (2354, 'Sete Lagoas', 11);
INSERT INTO public.cidade VALUES (2355, 'Setubinha', 11);
INSERT INTO public.cidade VALUES (2356, 'Silveirânia', 11);
INSERT INTO public.cidade VALUES (2357, 'Silvianópolis', 11);
INSERT INTO public.cidade VALUES (2358, 'Simão Pereira', 11);
INSERT INTO public.cidade VALUES (2359, 'Simonésia', 11);
INSERT INTO public.cidade VALUES (2360, 'Sobrália', 11);
INSERT INTO public.cidade VALUES (2361, 'Soledade de Minas', 11);
INSERT INTO public.cidade VALUES (2362, 'Tabuleiro', 11);
INSERT INTO public.cidade VALUES (2363, 'Taiobeiras', 11);
INSERT INTO public.cidade VALUES (2364, 'Taparuba', 11);
INSERT INTO public.cidade VALUES (2365, 'Tapira', 11);
INSERT INTO public.cidade VALUES (2366, 'Tapiraí', 11);
INSERT INTO public.cidade VALUES (2367, 'Taquaraçu de Minas', 11);
INSERT INTO public.cidade VALUES (2368, 'Tarumirim', 11);
INSERT INTO public.cidade VALUES (2369, 'Teixeiras', 11);
INSERT INTO public.cidade VALUES (2370, 'Teófilo Otoni', 11);
INSERT INTO public.cidade VALUES (2371, 'Timóteo', 11);
INSERT INTO public.cidade VALUES (2372, 'Tiradentes', 11);
INSERT INTO public.cidade VALUES (2373, 'Tiros', 11);
INSERT INTO public.cidade VALUES (2374, 'Tocantins', 11);
INSERT INTO public.cidade VALUES (2375, 'Tocos do Moji', 11);
INSERT INTO public.cidade VALUES (2376, 'Toledo', 11);
INSERT INTO public.cidade VALUES (2377, 'Tombos', 11);
INSERT INTO public.cidade VALUES (2378, 'Três Corações', 11);
INSERT INTO public.cidade VALUES (2379, 'Três Marias', 11);
INSERT INTO public.cidade VALUES (2380, 'Três Pontas', 11);
INSERT INTO public.cidade VALUES (2381, 'Tumiritinga', 11);
INSERT INTO public.cidade VALUES (2382, 'Tupaciguara', 11);
INSERT INTO public.cidade VALUES (2383, 'Turmalina', 11);
INSERT INTO public.cidade VALUES (2384, 'Turvolândia', 11);
INSERT INTO public.cidade VALUES (2385, 'Ubá', 11);
INSERT INTO public.cidade VALUES (2386, 'Ubaí', 11);
INSERT INTO public.cidade VALUES (2387, 'Ubaporanga', 11);
INSERT INTO public.cidade VALUES (2388, 'Uberaba', 11);
INSERT INTO public.cidade VALUES (2389, 'Uberlândia', 11);
INSERT INTO public.cidade VALUES (2390, 'Umburatiba', 11);
INSERT INTO public.cidade VALUES (2391, 'Unaí', 11);
INSERT INTO public.cidade VALUES (2392, 'União de Minas', 11);
INSERT INTO public.cidade VALUES (2393, 'Uruana de Minas', 11);
INSERT INTO public.cidade VALUES (2394, 'Urucânia', 11);
INSERT INTO public.cidade VALUES (2395, 'Urucuia', 11);
INSERT INTO public.cidade VALUES (2396, 'Vargem Alegre', 11);
INSERT INTO public.cidade VALUES (2397, 'Vargem Bonita', 11);
INSERT INTO public.cidade VALUES (2398, 'Vargem Grande do Rio Pardo', 11);
INSERT INTO public.cidade VALUES (2399, 'Varginha', 11);
INSERT INTO public.cidade VALUES (2400, 'Varjão de Minas', 11);
INSERT INTO public.cidade VALUES (2401, 'Várzea da Palma', 11);
INSERT INTO public.cidade VALUES (2402, 'Varzelândia', 11);
INSERT INTO public.cidade VALUES (2403, 'Vazante', 11);
INSERT INTO public.cidade VALUES (2404, 'Verdelândia', 11);
INSERT INTO public.cidade VALUES (2405, 'Veredinha', 11);
INSERT INTO public.cidade VALUES (2406, 'Veríssimo', 11);
INSERT INTO public.cidade VALUES (2407, 'Vermelho Novo', 11);
INSERT INTO public.cidade VALUES (2408, 'Vespasiano', 11);
INSERT INTO public.cidade VALUES (2409, 'Viçosa', 11);
INSERT INTO public.cidade VALUES (2410, 'Vieiras', 11);
INSERT INTO public.cidade VALUES (2411, 'Virgem da Lapa', 11);
INSERT INTO public.cidade VALUES (2412, 'Virgínia', 11);
INSERT INTO public.cidade VALUES (2413, 'Virginópolis', 11);
INSERT INTO public.cidade VALUES (2414, 'Virgolândia', 11);
INSERT INTO public.cidade VALUES (2415, 'Visconde do Rio Branco', 11);
INSERT INTO public.cidade VALUES (2416, 'Volta Grande', 11);
INSERT INTO public.cidade VALUES (2417, 'Wenceslau Braz', 11);
INSERT INTO public.cidade VALUES (2418, 'Abaetetuba', 14);
INSERT INTO public.cidade VALUES (2419, 'Abel Figueiredo', 14);
INSERT INTO public.cidade VALUES (2420, 'Acará', 14);
INSERT INTO public.cidade VALUES (2421, 'Afuá', 14);
INSERT INTO public.cidade VALUES (2422, 'Água Azul do Norte', 14);
INSERT INTO public.cidade VALUES (2423, 'Alenquer', 14);
INSERT INTO public.cidade VALUES (2424, 'Almeirim', 14);
INSERT INTO public.cidade VALUES (2425, 'Altamira', 14);
INSERT INTO public.cidade VALUES (2426, 'Anajás', 14);
INSERT INTO public.cidade VALUES (2427, 'Ananindeua', 14);
INSERT INTO public.cidade VALUES (2428, 'Anapu', 14);
INSERT INTO public.cidade VALUES (2429, 'Augusto Corrêa', 14);
INSERT INTO public.cidade VALUES (2430, 'Aurora do Pará', 14);
INSERT INTO public.cidade VALUES (2431, 'Aveiro', 14);
INSERT INTO public.cidade VALUES (2432, 'Bagre', 14);
INSERT INTO public.cidade VALUES (2433, 'Baião', 14);
INSERT INTO public.cidade VALUES (2434, 'Bannach', 14);
INSERT INTO public.cidade VALUES (2435, 'Barcarena', 14);
INSERT INTO public.cidade VALUES (2436, 'Belém', 14);
INSERT INTO public.cidade VALUES (2437, 'Belterra', 14);
INSERT INTO public.cidade VALUES (2438, 'Benevides', 14);
INSERT INTO public.cidade VALUES (2439, 'Bom Jesus do Tocantins', 14);
INSERT INTO public.cidade VALUES (2440, 'Bonito', 14);
INSERT INTO public.cidade VALUES (2441, 'Bragança', 14);
INSERT INTO public.cidade VALUES (2442, 'Brasil Novo', 14);
INSERT INTO public.cidade VALUES (2443, 'Brejo Grande do Araguaia', 14);
INSERT INTO public.cidade VALUES (2444, 'Breu Branco', 14);
INSERT INTO public.cidade VALUES (2445, 'Breves', 14);
INSERT INTO public.cidade VALUES (2446, 'Bujaru', 14);
INSERT INTO public.cidade VALUES (2447, 'Cachoeira do Arari', 14);
INSERT INTO public.cidade VALUES (2448, 'Cachoeira do Piriá', 14);
INSERT INTO public.cidade VALUES (2449, 'Cametá', 14);
INSERT INTO public.cidade VALUES (2450, 'Canaã dos Carajás', 14);
INSERT INTO public.cidade VALUES (2451, 'Capanema', 14);
INSERT INTO public.cidade VALUES (2452, 'Capitão Poço', 14);
INSERT INTO public.cidade VALUES (2453, 'Castanhal', 14);
INSERT INTO public.cidade VALUES (2454, 'Chaves', 14);
INSERT INTO public.cidade VALUES (2455, 'Colares', 14);
INSERT INTO public.cidade VALUES (2456, 'Conceição do Araguaia', 14);
INSERT INTO public.cidade VALUES (2457, 'Concórdia do Pará', 14);
INSERT INTO public.cidade VALUES (2458, 'Cumaru do Norte', 14);
INSERT INTO public.cidade VALUES (2459, 'Curionópolis', 14);
INSERT INTO public.cidade VALUES (2460, 'Curralinho', 14);
INSERT INTO public.cidade VALUES (2461, 'Curuá', 14);
INSERT INTO public.cidade VALUES (2462, 'Curuçá', 14);
INSERT INTO public.cidade VALUES (2463, 'Dom Eliseu', 14);
INSERT INTO public.cidade VALUES (2464, 'Eldorado dos Carajás', 14);
INSERT INTO public.cidade VALUES (2465, 'Faro', 14);
INSERT INTO public.cidade VALUES (2466, 'Floresta do Araguaia', 14);
INSERT INTO public.cidade VALUES (2467, 'Garrafão do Norte', 14);
INSERT INTO public.cidade VALUES (2468, 'Goianésia do Pará', 14);
INSERT INTO public.cidade VALUES (2469, 'Gurupá', 14);
INSERT INTO public.cidade VALUES (2470, 'Igarapé-Açu', 14);
INSERT INTO public.cidade VALUES (2471, 'Igarapé-Miri', 14);
INSERT INTO public.cidade VALUES (2472, 'Inhangapi', 14);
INSERT INTO public.cidade VALUES (2473, 'Ipixuna do Pará', 14);
INSERT INTO public.cidade VALUES (2474, 'Irituia', 14);
INSERT INTO public.cidade VALUES (2475, 'Itaituba', 14);
INSERT INTO public.cidade VALUES (2476, 'Itupiranga', 14);
INSERT INTO public.cidade VALUES (2477, 'Jacareacanga', 14);
INSERT INTO public.cidade VALUES (2478, 'Jacundá', 14);
INSERT INTO public.cidade VALUES (2479, 'Juruti', 14);
INSERT INTO public.cidade VALUES (2480, 'Limoeiro do Ajuru', 14);
INSERT INTO public.cidade VALUES (2481, 'Mãe do Rio', 14);
INSERT INTO public.cidade VALUES (2482, 'Magalhães Barata', 14);
INSERT INTO public.cidade VALUES (2483, 'Marabá', 14);
INSERT INTO public.cidade VALUES (2484, 'Maracanã', 14);
INSERT INTO public.cidade VALUES (2485, 'Marapanim', 14);
INSERT INTO public.cidade VALUES (2486, 'Marituba', 14);
INSERT INTO public.cidade VALUES (2487, 'Medicilândia', 14);
INSERT INTO public.cidade VALUES (2488, 'Melgaço', 14);
INSERT INTO public.cidade VALUES (2489, 'Mocajuba', 14);
INSERT INTO public.cidade VALUES (2490, 'Moju', 14);
INSERT INTO public.cidade VALUES (2491, 'Monte Alegre', 14);
INSERT INTO public.cidade VALUES (2492, 'Muaná', 14);
INSERT INTO public.cidade VALUES (2493, 'Nova Esperança do Piriá', 14);
INSERT INTO public.cidade VALUES (2494, 'Nova Ipixuna', 14);
INSERT INTO public.cidade VALUES (2495, 'Nova Timboteua', 14);
INSERT INTO public.cidade VALUES (2496, 'Novo Progresso', 14);
INSERT INTO public.cidade VALUES (2497, 'Novo Repartimento', 14);
INSERT INTO public.cidade VALUES (2498, 'Óbidos', 14);
INSERT INTO public.cidade VALUES (2499, 'Oeiras do Pará', 14);
INSERT INTO public.cidade VALUES (2500, 'Oriximiná', 14);
INSERT INTO public.cidade VALUES (2501, 'Ourém', 14);
INSERT INTO public.cidade VALUES (2502, 'Ourilândia do Norte', 14);
INSERT INTO public.cidade VALUES (2503, 'Pacajá', 14);
INSERT INTO public.cidade VALUES (2504, 'Palestina do Pará', 14);
INSERT INTO public.cidade VALUES (2505, 'Paragominas', 14);
INSERT INTO public.cidade VALUES (2506, 'Parauapebas', 14);
INSERT INTO public.cidade VALUES (2507, 'Pau d`Arco', 14);
INSERT INTO public.cidade VALUES (2508, 'Peixe-Boi', 14);
INSERT INTO public.cidade VALUES (2509, 'Piçarra', 14);
INSERT INTO public.cidade VALUES (2510, 'Placas', 14);
INSERT INTO public.cidade VALUES (2511, 'Ponta de Pedras', 14);
INSERT INTO public.cidade VALUES (2512, 'Portel', 14);
INSERT INTO public.cidade VALUES (2513, 'Porto de Moz', 14);
INSERT INTO public.cidade VALUES (2514, 'Prainha', 14);
INSERT INTO public.cidade VALUES (2515, 'Primavera', 14);
INSERT INTO public.cidade VALUES (2516, 'Quatipuru', 14);
INSERT INTO public.cidade VALUES (2517, 'Redenção', 14);
INSERT INTO public.cidade VALUES (2518, 'Rio Maria', 14);
INSERT INTO public.cidade VALUES (2519, 'Rondon do Pará', 14);
INSERT INTO public.cidade VALUES (2520, 'Rurópolis', 14);
INSERT INTO public.cidade VALUES (2521, 'Salinópolis', 14);
INSERT INTO public.cidade VALUES (2522, 'Salvaterra', 14);
INSERT INTO public.cidade VALUES (2523, 'Santa Bárbara do Pará', 14);
INSERT INTO public.cidade VALUES (2524, 'Santa Cruz do Arari', 14);
INSERT INTO public.cidade VALUES (2525, 'Santa Isabel do Pará', 14);
INSERT INTO public.cidade VALUES (2526, 'Santa Luzia do Pará', 14);
INSERT INTO public.cidade VALUES (2527, 'Santa Maria das Barreiras', 14);
INSERT INTO public.cidade VALUES (2528, 'Santa Maria do Pará', 14);
INSERT INTO public.cidade VALUES (2529, 'Santana do Araguaia', 14);
INSERT INTO public.cidade VALUES (2530, 'Santarém', 14);
INSERT INTO public.cidade VALUES (2531, 'Santarém Novo', 14);
INSERT INTO public.cidade VALUES (2532, 'Santo Antônio do Tauá', 14);
INSERT INTO public.cidade VALUES (2533, 'São Caetano de Odivelas', 14);
INSERT INTO public.cidade VALUES (2534, 'São Domingos do Araguaia', 14);
INSERT INTO public.cidade VALUES (2535, 'São Domingos do Capim', 14);
INSERT INTO public.cidade VALUES (2536, 'São Félix do Xingu', 14);
INSERT INTO public.cidade VALUES (2537, 'São Francisco do Pará', 14);
INSERT INTO public.cidade VALUES (2538, 'São Geraldo do Araguaia', 14);
INSERT INTO public.cidade VALUES (2539, 'São João da Ponta', 14);
INSERT INTO public.cidade VALUES (2540, 'São João de Pirabas', 14);
INSERT INTO public.cidade VALUES (2541, 'São João do Araguaia', 14);
INSERT INTO public.cidade VALUES (2542, 'São Miguel do Guamá', 14);
INSERT INTO public.cidade VALUES (2543, 'São Sebastião da Boa Vista', 14);
INSERT INTO public.cidade VALUES (2544, 'Sapucaia', 14);
INSERT INTO public.cidade VALUES (2545, 'Senador José Porfírio', 14);
INSERT INTO public.cidade VALUES (2546, 'Soure', 14);
INSERT INTO public.cidade VALUES (2547, 'Tailândia', 14);
INSERT INTO public.cidade VALUES (2548, 'Terra Alta', 14);
INSERT INTO public.cidade VALUES (2549, 'Terra Santa', 14);
INSERT INTO public.cidade VALUES (2550, 'Tomé-Açu', 14);
INSERT INTO public.cidade VALUES (2551, 'Tracuateua', 14);
INSERT INTO public.cidade VALUES (2552, 'Trairão', 14);
INSERT INTO public.cidade VALUES (2553, 'Tucumã', 14);
INSERT INTO public.cidade VALUES (2554, 'Tucuruí', 14);
INSERT INTO public.cidade VALUES (2555, 'Ulianópolis', 14);
INSERT INTO public.cidade VALUES (2556, 'Uruará', 14);
INSERT INTO public.cidade VALUES (2557, 'Vigia', 14);
INSERT INTO public.cidade VALUES (2558, 'Viseu', 14);
INSERT INTO public.cidade VALUES (2559, 'Vitória do Xingu', 14);
INSERT INTO public.cidade VALUES (2560, 'Xinguara', 14);
INSERT INTO public.cidade VALUES (2561, 'Água Branca', 15);
INSERT INTO public.cidade VALUES (2562, 'Aguiar', 15);
INSERT INTO public.cidade VALUES (2563, 'Alagoa Grande', 15);
INSERT INTO public.cidade VALUES (2564, 'Alagoa Nova', 15);
INSERT INTO public.cidade VALUES (2565, 'Alagoinha', 15);
INSERT INTO public.cidade VALUES (2566, 'Alcantil', 15);
INSERT INTO public.cidade VALUES (2567, 'Algodão de Jandaíra', 15);
INSERT INTO public.cidade VALUES (2568, 'Alhandra', 15);
INSERT INTO public.cidade VALUES (2569, 'Amparo', 15);
INSERT INTO public.cidade VALUES (2570, 'Aparecida', 15);
INSERT INTO public.cidade VALUES (2571, 'Araçagi', 15);
INSERT INTO public.cidade VALUES (2572, 'Arara', 15);
INSERT INTO public.cidade VALUES (2573, 'Araruna', 15);
INSERT INTO public.cidade VALUES (2574, 'Areia', 15);
INSERT INTO public.cidade VALUES (2575, 'Areia de Baraúnas', 15);
INSERT INTO public.cidade VALUES (2576, 'Areial', 15);
INSERT INTO public.cidade VALUES (2577, 'Aroeiras', 15);
INSERT INTO public.cidade VALUES (2578, 'Assunção', 15);
INSERT INTO public.cidade VALUES (2579, 'Baía da Traição', 15);
INSERT INTO public.cidade VALUES (2580, 'Bananeiras', 15);
INSERT INTO public.cidade VALUES (2581, 'Baraúna', 15);
INSERT INTO public.cidade VALUES (2582, 'Barra de Santa Rosa', 15);
INSERT INTO public.cidade VALUES (2583, 'Barra de Santana', 15);
INSERT INTO public.cidade VALUES (2584, 'Barra de São Miguel', 15);
INSERT INTO public.cidade VALUES (2585, 'Bayeux', 15);
INSERT INTO public.cidade VALUES (2586, 'Belém', 15);
INSERT INTO public.cidade VALUES (2587, 'Belém do Brejo do Cruz', 15);
INSERT INTO public.cidade VALUES (2588, 'Bernardino Batista', 15);
INSERT INTO public.cidade VALUES (2589, 'Boa Ventura', 15);
INSERT INTO public.cidade VALUES (2590, 'Boa Vista', 15);
INSERT INTO public.cidade VALUES (2591, 'Bom Jesus', 15);
INSERT INTO public.cidade VALUES (2592, 'Bom Sucesso', 15);
INSERT INTO public.cidade VALUES (2593, 'Bonito de Santa Fé', 15);
INSERT INTO public.cidade VALUES (2594, 'Boqueirão', 15);
INSERT INTO public.cidade VALUES (2595, 'Borborema', 15);
INSERT INTO public.cidade VALUES (2596, 'Brejo do Cruz', 15);
INSERT INTO public.cidade VALUES (2597, 'Brejo dos Santos', 15);
INSERT INTO public.cidade VALUES (2598, 'Caaporã', 15);
INSERT INTO public.cidade VALUES (2599, 'Cabaceiras', 15);
INSERT INTO public.cidade VALUES (2600, 'Cabedelo', 15);
INSERT INTO public.cidade VALUES (2601, 'Cachoeira dos Índios', 15);
INSERT INTO public.cidade VALUES (2602, 'Cacimba de Areia', 15);
INSERT INTO public.cidade VALUES (2603, 'Cacimba de Dentro', 15);
INSERT INTO public.cidade VALUES (2604, 'Cacimbas', 15);
INSERT INTO public.cidade VALUES (2605, 'Caiçara', 15);
INSERT INTO public.cidade VALUES (2606, 'Cajazeiras', 15);
INSERT INTO public.cidade VALUES (2607, 'Cajazeirinhas', 15);
INSERT INTO public.cidade VALUES (2608, 'Caldas Brandão', 15);
INSERT INTO public.cidade VALUES (2609, 'Camalaú', 15);
INSERT INTO public.cidade VALUES (2610, 'Campina Grande', 15);
INSERT INTO public.cidade VALUES (2611, 'Campo de Santana', 15);
INSERT INTO public.cidade VALUES (2612, 'Capim', 15);
INSERT INTO public.cidade VALUES (2613, 'Caraúbas', 15);
INSERT INTO public.cidade VALUES (2614, 'Carrapateira', 15);
INSERT INTO public.cidade VALUES (2615, 'Casserengue', 15);
INSERT INTO public.cidade VALUES (2616, 'Catingueira', 15);
INSERT INTO public.cidade VALUES (2617, 'Catolé do Rocha', 15);
INSERT INTO public.cidade VALUES (2618, 'Caturité', 15);
INSERT INTO public.cidade VALUES (2619, 'Conceição', 15);
INSERT INTO public.cidade VALUES (2620, 'Condado', 15);
INSERT INTO public.cidade VALUES (2621, 'Conde', 15);
INSERT INTO public.cidade VALUES (2622, 'Congo', 15);
INSERT INTO public.cidade VALUES (2623, 'Coremas', 15);
INSERT INTO public.cidade VALUES (2624, 'Coxixola', 15);
INSERT INTO public.cidade VALUES (2625, 'Cruz do Espírito Santo', 15);
INSERT INTO public.cidade VALUES (2626, 'Cubati', 15);
INSERT INTO public.cidade VALUES (2627, 'Cuité', 15);
INSERT INTO public.cidade VALUES (2628, 'Cuité de Mamanguape', 15);
INSERT INTO public.cidade VALUES (2629, 'Cuitegi', 15);
INSERT INTO public.cidade VALUES (2630, 'Curral de Cima', 15);
INSERT INTO public.cidade VALUES (2631, 'Curral Velho', 15);
INSERT INTO public.cidade VALUES (2632, 'Damião', 15);
INSERT INTO public.cidade VALUES (2633, 'Desterro', 15);
INSERT INTO public.cidade VALUES (2634, 'Diamante', 15);
INSERT INTO public.cidade VALUES (2635, 'Dona Inês', 15);
INSERT INTO public.cidade VALUES (2636, 'Duas Estradas', 15);
INSERT INTO public.cidade VALUES (2637, 'Emas', 15);
INSERT INTO public.cidade VALUES (2638, 'Esperança', 15);
INSERT INTO public.cidade VALUES (2639, 'Fagundes', 15);
INSERT INTO public.cidade VALUES (2640, 'Frei Martinho', 15);
INSERT INTO public.cidade VALUES (2641, 'Gado Bravo', 15);
INSERT INTO public.cidade VALUES (2642, 'Guarabira', 15);
INSERT INTO public.cidade VALUES (2643, 'Gurinhém', 15);
INSERT INTO public.cidade VALUES (2644, 'Gurjão', 15);
INSERT INTO public.cidade VALUES (2645, 'Ibiara', 15);
INSERT INTO public.cidade VALUES (2646, 'Igaracy', 15);
INSERT INTO public.cidade VALUES (2647, 'Imaculada', 15);
INSERT INTO public.cidade VALUES (2648, 'Ingá', 15);
INSERT INTO public.cidade VALUES (2649, 'Itabaiana', 15);
INSERT INTO public.cidade VALUES (2650, 'Itaporanga', 15);
INSERT INTO public.cidade VALUES (2651, 'Itapororoca', 15);
INSERT INTO public.cidade VALUES (2652, 'Itatuba', 15);
INSERT INTO public.cidade VALUES (2653, 'Jacaraú', 15);
INSERT INTO public.cidade VALUES (2654, 'Jericó', 15);
INSERT INTO public.cidade VALUES (2655, 'João Pessoa', 15);
INSERT INTO public.cidade VALUES (2656, 'Juarez Távora', 15);
INSERT INTO public.cidade VALUES (2657, 'Juazeirinho', 15);
INSERT INTO public.cidade VALUES (2658, 'Junco do Seridó', 15);
INSERT INTO public.cidade VALUES (2659, 'Juripiranga', 15);
INSERT INTO public.cidade VALUES (2660, 'Juru', 15);
INSERT INTO public.cidade VALUES (2661, 'Lagoa', 15);
INSERT INTO public.cidade VALUES (2662, 'Lagoa de Dentro', 15);
INSERT INTO public.cidade VALUES (2663, 'Lagoa Seca', 15);
INSERT INTO public.cidade VALUES (2664, 'Lastro', 15);
INSERT INTO public.cidade VALUES (2665, 'Livramento', 15);
INSERT INTO public.cidade VALUES (2666, 'Logradouro', 15);
INSERT INTO public.cidade VALUES (2667, 'Lucena', 15);
INSERT INTO public.cidade VALUES (2668, 'Mãe d`Água', 15);
INSERT INTO public.cidade VALUES (2669, 'Malta', 15);
INSERT INTO public.cidade VALUES (2670, 'Mamanguape', 15);
INSERT INTO public.cidade VALUES (2671, 'Manaíra', 15);
INSERT INTO public.cidade VALUES (2672, 'Marcação', 15);
INSERT INTO public.cidade VALUES (2673, 'Mari', 15);
INSERT INTO public.cidade VALUES (2674, 'Marizópolis', 15);
INSERT INTO public.cidade VALUES (2675, 'Massaranduba', 15);
INSERT INTO public.cidade VALUES (2676, 'Mataraca', 15);
INSERT INTO public.cidade VALUES (2677, 'Matinhas', 15);
INSERT INTO public.cidade VALUES (2678, 'Mato Grosso', 15);
INSERT INTO public.cidade VALUES (2679, 'Maturéia', 15);
INSERT INTO public.cidade VALUES (2680, 'Mogeiro', 15);
INSERT INTO public.cidade VALUES (2681, 'Montadas', 15);
INSERT INTO public.cidade VALUES (2682, 'Monte Horebe', 15);
INSERT INTO public.cidade VALUES (2683, 'Monteiro', 15);
INSERT INTO public.cidade VALUES (2684, 'Mulungu', 15);
INSERT INTO public.cidade VALUES (2685, 'Natuba', 15);
INSERT INTO public.cidade VALUES (2686, 'Nazarezinho', 15);
INSERT INTO public.cidade VALUES (2687, 'Nova Floresta', 15);
INSERT INTO public.cidade VALUES (2688, 'Nova Olinda', 15);
INSERT INTO public.cidade VALUES (2689, 'Nova Palmeira', 15);
INSERT INTO public.cidade VALUES (2690, 'Olho d`Água', 15);
INSERT INTO public.cidade VALUES (2691, 'Olivedos', 15);
INSERT INTO public.cidade VALUES (2692, 'Ouro Velho', 15);
INSERT INTO public.cidade VALUES (2693, 'Parari', 15);
INSERT INTO public.cidade VALUES (2694, 'Passagem', 15);
INSERT INTO public.cidade VALUES (2695, 'Patos', 15);
INSERT INTO public.cidade VALUES (2696, 'Paulista', 15);
INSERT INTO public.cidade VALUES (2697, 'Pedra Branca', 15);
INSERT INTO public.cidade VALUES (2698, 'Pedra Lavrada', 15);
INSERT INTO public.cidade VALUES (2699, 'Pedras de Fogo', 15);
INSERT INTO public.cidade VALUES (2700, 'Pedro Régis', 15);
INSERT INTO public.cidade VALUES (2701, 'Piancó', 15);
INSERT INTO public.cidade VALUES (2702, 'Picuí', 15);
INSERT INTO public.cidade VALUES (2703, 'Pilar', 15);
INSERT INTO public.cidade VALUES (2704, 'Pilões', 15);
INSERT INTO public.cidade VALUES (2705, 'Pilõezinhos', 15);
INSERT INTO public.cidade VALUES (2706, 'Pirpirituba', 15);
INSERT INTO public.cidade VALUES (2707, 'Pitimbu', 15);
INSERT INTO public.cidade VALUES (2708, 'Pocinhos', 15);
INSERT INTO public.cidade VALUES (2709, 'Poço Dantas', 15);
INSERT INTO public.cidade VALUES (2710, 'Poço de José de Moura', 15);
INSERT INTO public.cidade VALUES (2711, 'Pombal', 15);
INSERT INTO public.cidade VALUES (2712, 'Prata', 15);
INSERT INTO public.cidade VALUES (2713, 'Princesa Isabel', 15);
INSERT INTO public.cidade VALUES (2714, 'Puxinanã', 15);
INSERT INTO public.cidade VALUES (2715, 'Queimadas', 15);
INSERT INTO public.cidade VALUES (2716, 'Quixabá', 15);
INSERT INTO public.cidade VALUES (2717, 'Remígio', 15);
INSERT INTO public.cidade VALUES (2718, 'Riachão', 15);
INSERT INTO public.cidade VALUES (2719, 'Riachão do Bacamarte', 15);
INSERT INTO public.cidade VALUES (2720, 'Riachão do Poço', 15);
INSERT INTO public.cidade VALUES (2721, 'Riacho de Santo Antônio', 15);
INSERT INTO public.cidade VALUES (2722, 'Riacho dos Cavalos', 15);
INSERT INTO public.cidade VALUES (2723, 'Rio Tinto', 15);
INSERT INTO public.cidade VALUES (2724, 'Salgadinho', 15);
INSERT INTO public.cidade VALUES (2725, 'Salgado de São Félix', 15);
INSERT INTO public.cidade VALUES (2726, 'Santa Cecília', 15);
INSERT INTO public.cidade VALUES (2727, 'Santa Cruz', 15);
INSERT INTO public.cidade VALUES (2728, 'Santa Helena', 15);
INSERT INTO public.cidade VALUES (2729, 'Santa Inês', 15);
INSERT INTO public.cidade VALUES (2730, 'Santa Luzia', 15);
INSERT INTO public.cidade VALUES (2731, 'Santa Rita', 15);
INSERT INTO public.cidade VALUES (2732, 'Santa Teresinha', 15);
INSERT INTO public.cidade VALUES (2733, 'Santana de Mangueira', 15);
INSERT INTO public.cidade VALUES (2734, 'Santana dos Garrotes', 15);
INSERT INTO public.cidade VALUES (2735, 'Santarém', 15);
INSERT INTO public.cidade VALUES (2736, 'Santo André', 15);
INSERT INTO public.cidade VALUES (2737, 'São Bentinho', 15);
INSERT INTO public.cidade VALUES (2738, 'São Bento', 15);
INSERT INTO public.cidade VALUES (2739, 'São Domingos de Pombal', 15);
INSERT INTO public.cidade VALUES (2740, 'São Domingos do Cariri', 15);
INSERT INTO public.cidade VALUES (2741, 'São Francisco', 15);
INSERT INTO public.cidade VALUES (2742, 'São João do Cariri', 15);
INSERT INTO public.cidade VALUES (2743, 'São João do Rio do Peixe', 15);
INSERT INTO public.cidade VALUES (2744, 'São João do Tigre', 15);
INSERT INTO public.cidade VALUES (2745, 'São José da Lagoa Tapada', 15);
INSERT INTO public.cidade VALUES (2746, 'São José de Caiana', 15);
INSERT INTO public.cidade VALUES (2747, 'São José de Espinharas', 15);
INSERT INTO public.cidade VALUES (2748, 'São José de Piranhas', 15);
INSERT INTO public.cidade VALUES (2749, 'São José de Princesa', 15);
INSERT INTO public.cidade VALUES (2750, 'São José do Bonfim', 15);
INSERT INTO public.cidade VALUES (2751, 'São José do Brejo do Cruz', 15);
INSERT INTO public.cidade VALUES (2752, 'São José do Sabugi', 15);
INSERT INTO public.cidade VALUES (2753, 'São José dos Cordeiros', 15);
INSERT INTO public.cidade VALUES (2754, 'São José dos Ramos', 15);
INSERT INTO public.cidade VALUES (2755, 'São Mamede', 15);
INSERT INTO public.cidade VALUES (2756, 'São Miguel de Taipu', 15);
INSERT INTO public.cidade VALUES (2757, 'São Sebastião de Lagoa de Roça', 15);
INSERT INTO public.cidade VALUES (2758, 'São Sebastião do Umbuzeiro', 15);
INSERT INTO public.cidade VALUES (2759, 'Sapé', 15);
INSERT INTO public.cidade VALUES (2760, 'Seridó', 15);
INSERT INTO public.cidade VALUES (2761, 'Serra Branca', 15);
INSERT INTO public.cidade VALUES (2762, 'Serra da Raiz', 15);
INSERT INTO public.cidade VALUES (2763, 'Serra Grande', 15);
INSERT INTO public.cidade VALUES (2764, 'Serra Redonda', 15);
INSERT INTO public.cidade VALUES (2765, 'Serraria', 15);
INSERT INTO public.cidade VALUES (2766, 'Sertãozinho', 15);
INSERT INTO public.cidade VALUES (2767, 'Sobrado', 15);
INSERT INTO public.cidade VALUES (2768, 'Solânea', 15);
INSERT INTO public.cidade VALUES (2769, 'Soledade', 15);
INSERT INTO public.cidade VALUES (2770, 'Sossêgo', 15);
INSERT INTO public.cidade VALUES (2771, 'Sousa', 15);
INSERT INTO public.cidade VALUES (2772, 'Sumé', 15);
INSERT INTO public.cidade VALUES (2773, 'Taperoá', 15);
INSERT INTO public.cidade VALUES (2774, 'Tavares', 15);
INSERT INTO public.cidade VALUES (2775, 'Teixeira', 15);
INSERT INTO public.cidade VALUES (2776, 'Tenório', 15);
INSERT INTO public.cidade VALUES (2777, 'Triunfo', 15);
INSERT INTO public.cidade VALUES (2778, 'Uiraúna', 15);
INSERT INTO public.cidade VALUES (2779, 'Umbuzeiro', 15);
INSERT INTO public.cidade VALUES (2780, 'Várzea', 15);
INSERT INTO public.cidade VALUES (2781, 'Vieirópolis', 15);
INSERT INTO public.cidade VALUES (2782, 'Vista Serrana', 15);
INSERT INTO public.cidade VALUES (2783, 'Zabelê', 15);
INSERT INTO public.cidade VALUES (2784, 'Abatiá', 18);
INSERT INTO public.cidade VALUES (2785, 'Adrianópolis', 18);
INSERT INTO public.cidade VALUES (2786, 'Agudos do Sul', 18);
INSERT INTO public.cidade VALUES (2787, 'Almirante Tamandaré', 18);
INSERT INTO public.cidade VALUES (2788, 'Altamira do Paraná', 18);
INSERT INTO public.cidade VALUES (2789, 'Alto Paraíso', 18);
INSERT INTO public.cidade VALUES (2790, 'Alto Paraná', 18);
INSERT INTO public.cidade VALUES (2791, 'Alto Piquiri', 18);
INSERT INTO public.cidade VALUES (2792, 'Altônia', 18);
INSERT INTO public.cidade VALUES (2793, 'Alvorada do Sul', 18);
INSERT INTO public.cidade VALUES (2794, 'Amaporã', 18);
INSERT INTO public.cidade VALUES (2795, 'Ampére', 18);
INSERT INTO public.cidade VALUES (2796, 'Anahy', 18);
INSERT INTO public.cidade VALUES (2797, 'Andirá', 18);
INSERT INTO public.cidade VALUES (2798, 'Ângulo', 18);
INSERT INTO public.cidade VALUES (2799, 'Antonina', 18);
INSERT INTO public.cidade VALUES (2800, 'Antônio Olinto', 18);
INSERT INTO public.cidade VALUES (2801, 'Apucarana', 18);
INSERT INTO public.cidade VALUES (2802, 'Arapongas', 18);
INSERT INTO public.cidade VALUES (2803, 'Arapoti', 18);
INSERT INTO public.cidade VALUES (2804, 'Arapuã', 18);
INSERT INTO public.cidade VALUES (2805, 'Araruna', 18);
INSERT INTO public.cidade VALUES (2806, 'Araucária', 18);
INSERT INTO public.cidade VALUES (2807, 'Ariranha do Ivaí', 18);
INSERT INTO public.cidade VALUES (2808, 'Assaí', 18);
INSERT INTO public.cidade VALUES (2809, 'Assis Chateaubriand', 18);
INSERT INTO public.cidade VALUES (2810, 'Astorga', 18);
INSERT INTO public.cidade VALUES (2811, 'Atalaia', 18);
INSERT INTO public.cidade VALUES (2812, 'Balsa Nova', 18);
INSERT INTO public.cidade VALUES (2813, 'Bandeirantes', 18);
INSERT INTO public.cidade VALUES (2814, 'Barbosa Ferraz', 18);
INSERT INTO public.cidade VALUES (2815, 'Barra do Jacaré', 18);
INSERT INTO public.cidade VALUES (2816, 'Barracão', 18);
INSERT INTO public.cidade VALUES (2817, 'Bela Vista da Caroba', 18);
INSERT INTO public.cidade VALUES (2818, 'Bela Vista do Paraíso', 18);
INSERT INTO public.cidade VALUES (2819, 'Bituruna', 18);
INSERT INTO public.cidade VALUES (2820, 'Boa Esperança', 18);
INSERT INTO public.cidade VALUES (2821, 'Boa Esperança do Iguaçu', 18);
INSERT INTO public.cidade VALUES (2822, 'Boa Ventura de São Roque', 18);
INSERT INTO public.cidade VALUES (2823, 'Boa Vista da Aparecida', 18);
INSERT INTO public.cidade VALUES (2824, 'Bocaiúva do Sul', 18);
INSERT INTO public.cidade VALUES (2825, 'Bom Jesus do Sul', 18);
INSERT INTO public.cidade VALUES (2826, 'Bom Sucesso', 18);
INSERT INTO public.cidade VALUES (2827, 'Bom Sucesso do Sul', 18);
INSERT INTO public.cidade VALUES (2828, 'Borrazópolis', 18);
INSERT INTO public.cidade VALUES (2829, 'Braganey', 18);
INSERT INTO public.cidade VALUES (2910, 'Goioerê', 18);
INSERT INTO public.cidade VALUES (2830, 'Brasilândia do Sul', 18);
INSERT INTO public.cidade VALUES (2831, 'Cafeara', 18);
INSERT INTO public.cidade VALUES (2832, 'Cafelândia', 18);
INSERT INTO public.cidade VALUES (2833, 'Cafezal do Sul', 18);
INSERT INTO public.cidade VALUES (2834, 'Califórnia', 18);
INSERT INTO public.cidade VALUES (2835, 'Cambará', 18);
INSERT INTO public.cidade VALUES (2836, 'Cambé', 18);
INSERT INTO public.cidade VALUES (2837, 'Cambira', 18);
INSERT INTO public.cidade VALUES (2838, 'Campina da Lagoa', 18);
INSERT INTO public.cidade VALUES (2839, 'Campina do Simão', 18);
INSERT INTO public.cidade VALUES (2840, 'Campina Grande do Sul', 18);
INSERT INTO public.cidade VALUES (2841, 'Campo Bonito', 18);
INSERT INTO public.cidade VALUES (2842, 'Campo do Tenente', 18);
INSERT INTO public.cidade VALUES (2843, 'Campo Largo', 18);
INSERT INTO public.cidade VALUES (2844, 'Campo Magro', 18);
INSERT INTO public.cidade VALUES (2845, 'Campo Mourão', 18);
INSERT INTO public.cidade VALUES (2846, 'Cândido de Abreu', 18);
INSERT INTO public.cidade VALUES (2847, 'Candói', 18);
INSERT INTO public.cidade VALUES (2848, 'Cantagalo', 18);
INSERT INTO public.cidade VALUES (2849, 'Capanema', 18);
INSERT INTO public.cidade VALUES (2850, 'Capitão Leônidas Marques', 18);
INSERT INTO public.cidade VALUES (2851, 'Carambeí', 18);
INSERT INTO public.cidade VALUES (2852, 'Carlópolis', 18);
INSERT INTO public.cidade VALUES (2853, 'Cascavel', 18);
INSERT INTO public.cidade VALUES (2854, 'Castro', 18);
INSERT INTO public.cidade VALUES (2855, 'Catanduvas', 18);
INSERT INTO public.cidade VALUES (2856, 'Centenário do Sul', 18);
INSERT INTO public.cidade VALUES (2857, 'Cerro Azul', 18);
INSERT INTO public.cidade VALUES (2858, 'Céu Azul', 18);
INSERT INTO public.cidade VALUES (2859, 'Chopinzinho', 18);
INSERT INTO public.cidade VALUES (2860, 'Cianorte', 18);
INSERT INTO public.cidade VALUES (2861, 'Cidade Gaúcha', 18);
INSERT INTO public.cidade VALUES (2862, 'Clevelândia', 18);
INSERT INTO public.cidade VALUES (2863, 'Colombo', 18);
INSERT INTO public.cidade VALUES (2864, 'Colorado', 18);
INSERT INTO public.cidade VALUES (2865, 'Congonhinhas', 18);
INSERT INTO public.cidade VALUES (2866, 'Conselheiro Mairinck', 18);
INSERT INTO public.cidade VALUES (2867, 'Contenda', 18);
INSERT INTO public.cidade VALUES (2868, 'Corbélia', 18);
INSERT INTO public.cidade VALUES (2869, 'Cornélio Procópio', 18);
INSERT INTO public.cidade VALUES (2870, 'Coronel Domingos Soares', 18);
INSERT INTO public.cidade VALUES (2871, 'Coronel Vivida', 18);
INSERT INTO public.cidade VALUES (2872, 'Corumbataí do Sul', 18);
INSERT INTO public.cidade VALUES (2873, 'Cruz Machado', 18);
INSERT INTO public.cidade VALUES (2874, 'Cruzeiro do Iguaçu', 18);
INSERT INTO public.cidade VALUES (2875, 'Cruzeiro do Oeste', 18);
INSERT INTO public.cidade VALUES (2876, 'Cruzeiro do Sul', 18);
INSERT INTO public.cidade VALUES (2877, 'Cruzmaltina', 18);
INSERT INTO public.cidade VALUES (2878, 'Curitiba', 18);
INSERT INTO public.cidade VALUES (2879, 'Curiúva', 18);
INSERT INTO public.cidade VALUES (2880, 'Diamante d`Oeste', 18);
INSERT INTO public.cidade VALUES (2881, 'Diamante do Norte', 18);
INSERT INTO public.cidade VALUES (2882, 'Diamante do Sul', 18);
INSERT INTO public.cidade VALUES (2883, 'Dois Vizinhos', 18);
INSERT INTO public.cidade VALUES (2884, 'Douradina', 18);
INSERT INTO public.cidade VALUES (2885, 'Doutor Camargo', 18);
INSERT INTO public.cidade VALUES (2886, 'Doutor Ulysses', 18);
INSERT INTO public.cidade VALUES (2887, 'Enéas Marques', 18);
INSERT INTO public.cidade VALUES (2888, 'Engenheiro Beltrão', 18);
INSERT INTO public.cidade VALUES (2889, 'Entre Rios do Oeste', 18);
INSERT INTO public.cidade VALUES (2890, 'Esperança Nova', 18);
INSERT INTO public.cidade VALUES (2891, 'Espigão Alto do Iguaçu', 18);
INSERT INTO public.cidade VALUES (2892, 'Farol', 18);
INSERT INTO public.cidade VALUES (2893, 'Faxinal', 18);
INSERT INTO public.cidade VALUES (2894, 'Fazenda Rio Grande', 18);
INSERT INTO public.cidade VALUES (2895, 'Fênix', 18);
INSERT INTO public.cidade VALUES (2896, 'Fernandes Pinheiro', 18);
INSERT INTO public.cidade VALUES (2897, 'Figueira', 18);
INSERT INTO public.cidade VALUES (2898, 'Flor da Serra do Sul', 18);
INSERT INTO public.cidade VALUES (2899, 'Floraí', 18);
INSERT INTO public.cidade VALUES (2900, 'Floresta', 18);
INSERT INTO public.cidade VALUES (2901, 'Florestópolis', 18);
INSERT INTO public.cidade VALUES (2902, 'Flórida', 18);
INSERT INTO public.cidade VALUES (2903, 'Formosa do Oeste', 18);
INSERT INTO public.cidade VALUES (2904, 'Foz do Iguaçu', 18);
INSERT INTO public.cidade VALUES (2905, 'Foz do Jordão', 18);
INSERT INTO public.cidade VALUES (2906, 'Francisco Alves', 18);
INSERT INTO public.cidade VALUES (2907, 'Francisco Beltrão', 18);
INSERT INTO public.cidade VALUES (2908, 'General Carneiro', 18);
INSERT INTO public.cidade VALUES (2909, 'Godoy Moreira', 18);
INSERT INTO public.cidade VALUES (2911, 'Goioxim', 18);
INSERT INTO public.cidade VALUES (2912, 'Grandes Rios', 18);
INSERT INTO public.cidade VALUES (2913, 'Guaíra', 18);
INSERT INTO public.cidade VALUES (2914, 'Guairaçá', 18);
INSERT INTO public.cidade VALUES (2915, 'Guamiranga', 18);
INSERT INTO public.cidade VALUES (2916, 'Guapirama', 18);
INSERT INTO public.cidade VALUES (2917, 'Guaporema', 18);
INSERT INTO public.cidade VALUES (2918, 'Guaraci', 18);
INSERT INTO public.cidade VALUES (2919, 'Guaraniaçu', 18);
INSERT INTO public.cidade VALUES (2920, 'Guarapuava', 18);
INSERT INTO public.cidade VALUES (2921, 'Guaraqueçaba', 18);
INSERT INTO public.cidade VALUES (2922, 'Guaratuba', 18);
INSERT INTO public.cidade VALUES (2923, 'Honório Serpa', 18);
INSERT INTO public.cidade VALUES (2924, 'Ibaiti', 18);
INSERT INTO public.cidade VALUES (2925, 'Ibema', 18);
INSERT INTO public.cidade VALUES (2926, 'Ibiporã', 18);
INSERT INTO public.cidade VALUES (2927, 'Icaraíma', 18);
INSERT INTO public.cidade VALUES (2928, 'Iguaraçu', 18);
INSERT INTO public.cidade VALUES (2929, 'Iguatu', 18);
INSERT INTO public.cidade VALUES (2930, 'Imbaú', 18);
INSERT INTO public.cidade VALUES (2931, 'Imbituva', 18);
INSERT INTO public.cidade VALUES (2932, 'Inácio Martins', 18);
INSERT INTO public.cidade VALUES (2933, 'Inajá', 18);
INSERT INTO public.cidade VALUES (2934, 'Indianópolis', 18);
INSERT INTO public.cidade VALUES (2935, 'Ipiranga', 18);
INSERT INTO public.cidade VALUES (2936, 'Iporã', 18);
INSERT INTO public.cidade VALUES (2937, 'Iracema do Oeste', 18);
INSERT INTO public.cidade VALUES (2938, 'Irati', 18);
INSERT INTO public.cidade VALUES (2939, 'Iretama', 18);
INSERT INTO public.cidade VALUES (2940, 'Itaguajé', 18);
INSERT INTO public.cidade VALUES (2941, 'Itaipulândia', 18);
INSERT INTO public.cidade VALUES (2942, 'Itambaracá', 18);
INSERT INTO public.cidade VALUES (2943, 'Itambé', 18);
INSERT INTO public.cidade VALUES (2944, 'Itapejara d`Oeste', 18);
INSERT INTO public.cidade VALUES (2945, 'Itaperuçu', 18);
INSERT INTO public.cidade VALUES (2946, 'Itaúna do Sul', 18);
INSERT INTO public.cidade VALUES (2947, 'Ivaí', 18);
INSERT INTO public.cidade VALUES (2948, 'Ivaiporã', 18);
INSERT INTO public.cidade VALUES (2949, 'Ivaté', 18);
INSERT INTO public.cidade VALUES (2950, 'Ivatuba', 18);
INSERT INTO public.cidade VALUES (2951, 'Jaboti', 18);
INSERT INTO public.cidade VALUES (2952, 'Jacarezinho', 18);
INSERT INTO public.cidade VALUES (2953, 'Jaguapitã', 18);
INSERT INTO public.cidade VALUES (2954, 'Jaguariaíva', 18);
INSERT INTO public.cidade VALUES (2955, 'Jandaia do Sul', 18);
INSERT INTO public.cidade VALUES (2956, 'Janiópolis', 18);
INSERT INTO public.cidade VALUES (2957, 'Japira', 18);
INSERT INTO public.cidade VALUES (2958, 'Japurá', 18);
INSERT INTO public.cidade VALUES (2959, 'Jardim Alegre', 18);
INSERT INTO public.cidade VALUES (2960, 'Jardim Olinda', 18);
INSERT INTO public.cidade VALUES (2961, 'Jataizinho', 18);
INSERT INTO public.cidade VALUES (2962, 'Jesuítas', 18);
INSERT INTO public.cidade VALUES (2963, 'Joaquim Távora', 18);
INSERT INTO public.cidade VALUES (2964, 'Jundiaí do Sul', 18);
INSERT INTO public.cidade VALUES (2965, 'Juranda', 18);
INSERT INTO public.cidade VALUES (2966, 'Jussara', 18);
INSERT INTO public.cidade VALUES (2967, 'Kaloré', 18);
INSERT INTO public.cidade VALUES (2968, 'Lapa', 18);
INSERT INTO public.cidade VALUES (2969, 'Laranjal', 18);
INSERT INTO public.cidade VALUES (2970, 'Laranjeiras do Sul', 18);
INSERT INTO public.cidade VALUES (2971, 'Leópolis', 18);
INSERT INTO public.cidade VALUES (2972, 'Lidianópolis', 18);
INSERT INTO public.cidade VALUES (2973, 'Lindoeste', 18);
INSERT INTO public.cidade VALUES (2974, 'Loanda', 18);
INSERT INTO public.cidade VALUES (2975, 'Lobato', 18);
INSERT INTO public.cidade VALUES (2976, 'Londrina', 18);
INSERT INTO public.cidade VALUES (2977, 'Luiziana', 18);
INSERT INTO public.cidade VALUES (2978, 'Lunardelli', 18);
INSERT INTO public.cidade VALUES (2979, 'Lupionópolis', 18);
INSERT INTO public.cidade VALUES (2980, 'Mallet', 18);
INSERT INTO public.cidade VALUES (2981, 'Mamborê', 18);
INSERT INTO public.cidade VALUES (2982, 'Mandaguaçu', 18);
INSERT INTO public.cidade VALUES (2983, 'Mandaguari', 18);
INSERT INTO public.cidade VALUES (2984, 'Mandirituba', 18);
INSERT INTO public.cidade VALUES (2985, 'Manfrinópolis', 18);
INSERT INTO public.cidade VALUES (2986, 'Mangueirinha', 18);
INSERT INTO public.cidade VALUES (2987, 'Manoel Ribas', 18);
INSERT INTO public.cidade VALUES (2988, 'Marechal Cândido Rondon', 18);
INSERT INTO public.cidade VALUES (2989, 'Maria Helena', 18);
INSERT INTO public.cidade VALUES (2990, 'Marialva', 18);
INSERT INTO public.cidade VALUES (2991, 'Marilândia do Sul', 18);
INSERT INTO public.cidade VALUES (2992, 'Marilena', 18);
INSERT INTO public.cidade VALUES (2993, 'Mariluz', 18);
INSERT INTO public.cidade VALUES (2994, 'Maringá', 18);
INSERT INTO public.cidade VALUES (2995, 'Mariópolis', 18);
INSERT INTO public.cidade VALUES (2996, 'Maripá', 18);
INSERT INTO public.cidade VALUES (2997, 'Marmeleiro', 18);
INSERT INTO public.cidade VALUES (2998, 'Marquinho', 18);
INSERT INTO public.cidade VALUES (2999, 'Marumbi', 18);
INSERT INTO public.cidade VALUES (3000, 'Matelândia', 18);
INSERT INTO public.cidade VALUES (3001, 'Matinhos', 18);
INSERT INTO public.cidade VALUES (3002, 'Mato Rico', 18);
INSERT INTO public.cidade VALUES (3003, 'Mauá da Serra', 18);
INSERT INTO public.cidade VALUES (3004, 'Medianeira', 18);
INSERT INTO public.cidade VALUES (3005, 'Mercedes', 18);
INSERT INTO public.cidade VALUES (3006, 'Mirador', 18);
INSERT INTO public.cidade VALUES (3007, 'Miraselva', 18);
INSERT INTO public.cidade VALUES (3008, 'Missal', 18);
INSERT INTO public.cidade VALUES (3009, 'Moreira Sales', 18);
INSERT INTO public.cidade VALUES (3010, 'Morretes', 18);
INSERT INTO public.cidade VALUES (3011, 'Munhoz de Melo', 18);
INSERT INTO public.cidade VALUES (3012, 'Nossa Senhora das Graças', 18);
INSERT INTO public.cidade VALUES (3013, 'Nova Aliança do Ivaí', 18);
INSERT INTO public.cidade VALUES (3014, 'Nova América da Colina', 18);
INSERT INTO public.cidade VALUES (3015, 'Nova Aurora', 18);
INSERT INTO public.cidade VALUES (3016, 'Nova Cantu', 18);
INSERT INTO public.cidade VALUES (3017, 'Nova Esperança', 18);
INSERT INTO public.cidade VALUES (3018, 'Nova Esperança do Sudoeste', 18);
INSERT INTO public.cidade VALUES (3019, 'Nova Fátima', 18);
INSERT INTO public.cidade VALUES (3020, 'Nova Laranjeiras', 18);
INSERT INTO public.cidade VALUES (3021, 'Nova Londrina', 18);
INSERT INTO public.cidade VALUES (3022, 'Nova Olímpia', 18);
INSERT INTO public.cidade VALUES (3023, 'Nova Prata do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3024, 'Nova Santa Bárbara', 18);
INSERT INTO public.cidade VALUES (3025, 'Nova Santa Rosa', 18);
INSERT INTO public.cidade VALUES (3026, 'Nova Tebas', 18);
INSERT INTO public.cidade VALUES (3027, 'Novo Itacolomi', 18);
INSERT INTO public.cidade VALUES (3028, 'Ortigueira', 18);
INSERT INTO public.cidade VALUES (3029, 'Ourizona', 18);
INSERT INTO public.cidade VALUES (3030, 'Ouro Verde do Oeste', 18);
INSERT INTO public.cidade VALUES (3031, 'Paiçandu', 18);
INSERT INTO public.cidade VALUES (3032, 'Palmas', 18);
INSERT INTO public.cidade VALUES (3033, 'Palmeira', 18);
INSERT INTO public.cidade VALUES (3034, 'Palmital', 18);
INSERT INTO public.cidade VALUES (3035, 'Palotina', 18);
INSERT INTO public.cidade VALUES (3036, 'Paraíso do Norte', 18);
INSERT INTO public.cidade VALUES (3037, 'Paranacity', 18);
INSERT INTO public.cidade VALUES (3038, 'Paranaguá', 18);
INSERT INTO public.cidade VALUES (3039, 'Paranapoema', 18);
INSERT INTO public.cidade VALUES (3040, 'Paranavaí', 18);
INSERT INTO public.cidade VALUES (3041, 'Pato Bragado', 18);
INSERT INTO public.cidade VALUES (3042, 'Pato Branco', 18);
INSERT INTO public.cidade VALUES (3043, 'Paula Freitas', 18);
INSERT INTO public.cidade VALUES (3044, 'Paulo Frontin', 18);
INSERT INTO public.cidade VALUES (3045, 'Peabiru', 18);
INSERT INTO public.cidade VALUES (3046, 'Perobal', 18);
INSERT INTO public.cidade VALUES (3047, 'Pérola', 18);
INSERT INTO public.cidade VALUES (3048, 'Pérola d`Oeste', 18);
INSERT INTO public.cidade VALUES (3049, 'Piên', 18);
INSERT INTO public.cidade VALUES (3050, 'Pinhais', 18);
INSERT INTO public.cidade VALUES (3051, 'Pinhal de São Bento', 18);
INSERT INTO public.cidade VALUES (3052, 'Pinhalão', 18);
INSERT INTO public.cidade VALUES (3053, 'Pinhão', 18);
INSERT INTO public.cidade VALUES (3054, 'Piraí do Sul', 18);
INSERT INTO public.cidade VALUES (3055, 'Piraquara', 18);
INSERT INTO public.cidade VALUES (3056, 'Pitanga', 18);
INSERT INTO public.cidade VALUES (3057, 'Pitangueiras', 18);
INSERT INTO public.cidade VALUES (3058, 'Planaltina do Paraná', 18);
INSERT INTO public.cidade VALUES (3059, 'Planalto', 18);
INSERT INTO public.cidade VALUES (3060, 'Ponta Grossa', 18);
INSERT INTO public.cidade VALUES (3061, 'Pontal do Paraná', 18);
INSERT INTO public.cidade VALUES (3062, 'Porecatu', 18);
INSERT INTO public.cidade VALUES (3063, 'Porto Amazonas', 18);
INSERT INTO public.cidade VALUES (3064, 'Porto Barreiro', 18);
INSERT INTO public.cidade VALUES (3065, 'Porto Rico', 18);
INSERT INTO public.cidade VALUES (3066, 'Porto Vitória', 18);
INSERT INTO public.cidade VALUES (3067, 'Prado Ferreira', 18);
INSERT INTO public.cidade VALUES (3068, 'Pranchita', 18);
INSERT INTO public.cidade VALUES (3069, 'Presidente Castelo Branco', 18);
INSERT INTO public.cidade VALUES (3070, 'Primeiro de Maio', 18);
INSERT INTO public.cidade VALUES (3071, 'Prudentópolis', 18);
INSERT INTO public.cidade VALUES (3072, 'Quarto Centenário', 18);
INSERT INTO public.cidade VALUES (3073, 'Quatiguá', 18);
INSERT INTO public.cidade VALUES (3074, 'Quatro Barras', 18);
INSERT INTO public.cidade VALUES (3075, 'Quatro Pontes', 18);
INSERT INTO public.cidade VALUES (3076, 'Quedas do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3077, 'Querência do Norte', 18);
INSERT INTO public.cidade VALUES (3078, 'Quinta do Sol', 18);
INSERT INTO public.cidade VALUES (3079, 'Quitandinha', 18);
INSERT INTO public.cidade VALUES (3080, 'Ramilândia', 18);
INSERT INTO public.cidade VALUES (3081, 'Rancho Alegre', 18);
INSERT INTO public.cidade VALUES (3082, 'Rancho Alegre d`Oeste', 18);
INSERT INTO public.cidade VALUES (3083, 'Realeza', 18);
INSERT INTO public.cidade VALUES (3084, 'Rebouças', 18);
INSERT INTO public.cidade VALUES (3085, 'Renascença', 18);
INSERT INTO public.cidade VALUES (3086, 'Reserva', 18);
INSERT INTO public.cidade VALUES (3087, 'Reserva do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3088, 'Ribeirão Claro', 18);
INSERT INTO public.cidade VALUES (3089, 'Ribeirão do Pinhal', 18);
INSERT INTO public.cidade VALUES (3090, 'Rio Azul', 18);
INSERT INTO public.cidade VALUES (3091, 'Rio Bom', 18);
INSERT INTO public.cidade VALUES (3092, 'Rio Bonito do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3093, 'Rio Branco do Ivaí', 18);
INSERT INTO public.cidade VALUES (3094, 'Rio Branco do Sul', 18);
INSERT INTO public.cidade VALUES (3095, 'Rio Negro', 18);
INSERT INTO public.cidade VALUES (3096, 'Rolândia', 18);
INSERT INTO public.cidade VALUES (3097, 'Roncador', 18);
INSERT INTO public.cidade VALUES (3098, 'Rondon', 18);
INSERT INTO public.cidade VALUES (3099, 'Rosário do Ivaí', 18);
INSERT INTO public.cidade VALUES (3100, 'Sabáudia', 18);
INSERT INTO public.cidade VALUES (3101, 'Salgado Filho', 18);
INSERT INTO public.cidade VALUES (3102, 'Salto do Itararé', 18);
INSERT INTO public.cidade VALUES (3103, 'Salto do Lontra', 18);
INSERT INTO public.cidade VALUES (3104, 'Santa Amélia', 18);
INSERT INTO public.cidade VALUES (3105, 'Santa Cecília do Pavão', 18);
INSERT INTO public.cidade VALUES (3106, 'Santa Cruz de Monte Castelo', 18);
INSERT INTO public.cidade VALUES (3107, 'Santa Fé', 18);
INSERT INTO public.cidade VALUES (3108, 'Santa Helena', 18);
INSERT INTO public.cidade VALUES (3109, 'Santa Inês', 18);
INSERT INTO public.cidade VALUES (3110, 'Santa Isabel do Ivaí', 18);
INSERT INTO public.cidade VALUES (3111, 'Santa Izabel do Oeste', 18);
INSERT INTO public.cidade VALUES (3112, 'Santa Lúcia', 18);
INSERT INTO public.cidade VALUES (3113, 'Santa Maria do Oeste', 18);
INSERT INTO public.cidade VALUES (3114, 'Santa Mariana', 18);
INSERT INTO public.cidade VALUES (3115, 'Santa Mônica', 18);
INSERT INTO public.cidade VALUES (3116, 'Santa Tereza do Oeste', 18);
INSERT INTO public.cidade VALUES (3117, 'Santa Terezinha de Itaipu', 18);
INSERT INTO public.cidade VALUES (3118, 'Santana do Itararé', 18);
INSERT INTO public.cidade VALUES (3119, 'Santo Antônio da Platina', 18);
INSERT INTO public.cidade VALUES (3120, 'Santo Antônio do Caiuá', 18);
INSERT INTO public.cidade VALUES (3121, 'Santo Antônio do Paraíso', 18);
INSERT INTO public.cidade VALUES (3122, 'Santo Antônio do Sudoeste', 18);
INSERT INTO public.cidade VALUES (3123, 'Santo Inácio', 18);
INSERT INTO public.cidade VALUES (3124, 'São Carlos do Ivaí', 18);
INSERT INTO public.cidade VALUES (3125, 'São Jerônimo da Serra', 18);
INSERT INTO public.cidade VALUES (3126, 'São João', 18);
INSERT INTO public.cidade VALUES (3127, 'São João do Caiuá', 18);
INSERT INTO public.cidade VALUES (3128, 'São João do Ivaí', 18);
INSERT INTO public.cidade VALUES (3129, 'São João do Triunfo', 18);
INSERT INTO public.cidade VALUES (3130, 'São Jorge d`Oeste', 18);
INSERT INTO public.cidade VALUES (3131, 'São Jorge do Ivaí', 18);
INSERT INTO public.cidade VALUES (3132, 'São Jorge do Patrocínio', 18);
INSERT INTO public.cidade VALUES (3133, 'São José da Boa Vista', 18);
INSERT INTO public.cidade VALUES (3134, 'São José das Palmeiras', 18);
INSERT INTO public.cidade VALUES (3135, 'São José dos Pinhais', 18);
INSERT INTO public.cidade VALUES (3136, 'São Manoel do Paraná', 18);
INSERT INTO public.cidade VALUES (3137, 'São Mateus do Sul', 18);
INSERT INTO public.cidade VALUES (3138, 'São Miguel do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3139, 'São Pedro do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3140, 'São Pedro do Ivaí', 18);
INSERT INTO public.cidade VALUES (3141, 'São Pedro do Paraná', 18);
INSERT INTO public.cidade VALUES (3142, 'São Sebastião da Amoreira', 18);
INSERT INTO public.cidade VALUES (3143, 'São Tomé', 18);
INSERT INTO public.cidade VALUES (3144, 'Sapopema', 18);
INSERT INTO public.cidade VALUES (3145, 'Sarandi', 18);
INSERT INTO public.cidade VALUES (3146, 'Saudade do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3147, 'Sengés', 18);
INSERT INTO public.cidade VALUES (3148, 'Serranópolis do Iguaçu', 18);
INSERT INTO public.cidade VALUES (3149, 'Sertaneja', 18);
INSERT INTO public.cidade VALUES (3150, 'Sertanópolis', 18);
INSERT INTO public.cidade VALUES (3151, 'Siqueira Campos', 18);
INSERT INTO public.cidade VALUES (3152, 'Sulina', 18);
INSERT INTO public.cidade VALUES (3153, 'Tamarana', 18);
INSERT INTO public.cidade VALUES (3154, 'Tamboara', 18);
INSERT INTO public.cidade VALUES (3155, 'Tapejara', 18);
INSERT INTO public.cidade VALUES (3156, 'Tapira', 18);
INSERT INTO public.cidade VALUES (3157, 'Teixeira Soares', 18);
INSERT INTO public.cidade VALUES (3158, 'Telêmaco Borba', 18);
INSERT INTO public.cidade VALUES (3159, 'Terra Boa', 18);
INSERT INTO public.cidade VALUES (3160, 'Terra Rica', 18);
INSERT INTO public.cidade VALUES (3161, 'Terra Roxa', 18);
INSERT INTO public.cidade VALUES (3162, 'Tibagi', 18);
INSERT INTO public.cidade VALUES (3163, 'Tijucas do Sul', 18);
INSERT INTO public.cidade VALUES (3164, 'Toledo', 18);
INSERT INTO public.cidade VALUES (3165, 'Tomazina', 18);
INSERT INTO public.cidade VALUES (3166, 'Três Barras do Paraná', 18);
INSERT INTO public.cidade VALUES (3167, 'Tunas do Paraná', 18);
INSERT INTO public.cidade VALUES (3168, 'Tuneiras do Oeste', 18);
INSERT INTO public.cidade VALUES (3169, 'Tupãssi', 18);
INSERT INTO public.cidade VALUES (3170, 'Turvo', 18);
INSERT INTO public.cidade VALUES (3171, 'Ubiratã', 18);
INSERT INTO public.cidade VALUES (3172, 'Umuarama', 18);
INSERT INTO public.cidade VALUES (3173, 'União da Vitória', 18);
INSERT INTO public.cidade VALUES (3174, 'Uniflor', 18);
INSERT INTO public.cidade VALUES (3175, 'Uraí', 18);
INSERT INTO public.cidade VALUES (3176, 'Ventania', 18);
INSERT INTO public.cidade VALUES (3177, 'Vera Cruz do Oeste', 18);
INSERT INTO public.cidade VALUES (3178, 'Verê', 18);
INSERT INTO public.cidade VALUES (3179, 'Virmond', 18);
INSERT INTO public.cidade VALUES (3180, 'Vitorino', 18);
INSERT INTO public.cidade VALUES (3181, 'Wenceslau Braz', 18);
INSERT INTO public.cidade VALUES (3182, 'Xambrê', 18);
INSERT INTO public.cidade VALUES (3183, 'Abreu e Lima', 16);
INSERT INTO public.cidade VALUES (3184, 'Afogados da Ingazeira', 16);
INSERT INTO public.cidade VALUES (3185, 'Afrânio', 16);
INSERT INTO public.cidade VALUES (3186, 'Agrestina', 16);
INSERT INTO public.cidade VALUES (3187, 'Água Preta', 16);
INSERT INTO public.cidade VALUES (3188, 'Águas Belas', 16);
INSERT INTO public.cidade VALUES (3189, 'Alagoinha', 16);
INSERT INTO public.cidade VALUES (3190, 'Aliança', 16);
INSERT INTO public.cidade VALUES (3191, 'Altinho', 16);
INSERT INTO public.cidade VALUES (3192, 'Amaraji', 16);
INSERT INTO public.cidade VALUES (3193, 'Angelim', 16);
INSERT INTO public.cidade VALUES (3194, 'Araçoiaba', 16);
INSERT INTO public.cidade VALUES (3195, 'Araripina', 16);
INSERT INTO public.cidade VALUES (3196, 'Arcoverde', 16);
INSERT INTO public.cidade VALUES (3197, 'Barra de Guabiraba', 16);
INSERT INTO public.cidade VALUES (3198, 'Barreiros', 16);
INSERT INTO public.cidade VALUES (3199, 'Belém de Maria', 16);
INSERT INTO public.cidade VALUES (3200, 'Belém de São Francisco', 16);
INSERT INTO public.cidade VALUES (3201, 'Belo Jardim', 16);
INSERT INTO public.cidade VALUES (3202, 'Betânia', 16);
INSERT INTO public.cidade VALUES (3203, 'Bezerros', 16);
INSERT INTO public.cidade VALUES (3204, 'Bodocó', 16);
INSERT INTO public.cidade VALUES (3205, 'Bom Conselho', 16);
INSERT INTO public.cidade VALUES (3206, 'Bom Jardim', 16);
INSERT INTO public.cidade VALUES (3207, 'Bonito', 16);
INSERT INTO public.cidade VALUES (3208, 'Brejão', 16);
INSERT INTO public.cidade VALUES (3209, 'Brejinho', 16);
INSERT INTO public.cidade VALUES (3210, 'Brejo da Madre de Deus', 16);
INSERT INTO public.cidade VALUES (3211, 'Buenos Aires', 16);
INSERT INTO public.cidade VALUES (3212, 'Buíque', 16);
INSERT INTO public.cidade VALUES (3213, 'Cabo de Santo Agostinho', 16);
INSERT INTO public.cidade VALUES (3214, 'Cabrobó', 16);
INSERT INTO public.cidade VALUES (3215, 'Cachoeirinha', 16);
INSERT INTO public.cidade VALUES (3216, 'Caetés', 16);
INSERT INTO public.cidade VALUES (3217, 'Calçado', 16);
INSERT INTO public.cidade VALUES (3218, 'Calumbi', 16);
INSERT INTO public.cidade VALUES (3219, 'Camaragibe', 16);
INSERT INTO public.cidade VALUES (3220, 'Camocim de São Félix', 16);
INSERT INTO public.cidade VALUES (3221, 'Camutanga', 16);
INSERT INTO public.cidade VALUES (3222, 'Canhotinho', 16);
INSERT INTO public.cidade VALUES (3223, 'Capoeiras', 16);
INSERT INTO public.cidade VALUES (3224, 'Carnaíba', 16);
INSERT INTO public.cidade VALUES (3225, 'Carnaubeira da Penha', 16);
INSERT INTO public.cidade VALUES (3226, 'Carpina', 16);
INSERT INTO public.cidade VALUES (3227, 'Caruaru', 16);
INSERT INTO public.cidade VALUES (3228, 'Casinhas', 16);
INSERT INTO public.cidade VALUES (3229, 'Catende', 16);
INSERT INTO public.cidade VALUES (3230, 'Cedro', 16);
INSERT INTO public.cidade VALUES (3231, 'Chã de Alegria', 16);
INSERT INTO public.cidade VALUES (3232, 'Chã Grande', 16);
INSERT INTO public.cidade VALUES (3233, 'Condado', 16);
INSERT INTO public.cidade VALUES (3234, 'Correntes', 16);
INSERT INTO public.cidade VALUES (3235, 'Cortês', 16);
INSERT INTO public.cidade VALUES (3236, 'Cumaru', 16);
INSERT INTO public.cidade VALUES (3237, 'Cupira', 16);
INSERT INTO public.cidade VALUES (3238, 'Custódia', 16);
INSERT INTO public.cidade VALUES (3239, 'Dormentes', 16);
INSERT INTO public.cidade VALUES (3240, 'Escada', 16);
INSERT INTO public.cidade VALUES (3241, 'Exu', 16);
INSERT INTO public.cidade VALUES (3242, 'Feira Nova', 16);
INSERT INTO public.cidade VALUES (3243, 'Fernando de Noronha', 16);
INSERT INTO public.cidade VALUES (3244, 'Ferreiros', 16);
INSERT INTO public.cidade VALUES (3245, 'Flores', 16);
INSERT INTO public.cidade VALUES (3246, 'Floresta', 16);
INSERT INTO public.cidade VALUES (3247, 'Frei Miguelinho', 16);
INSERT INTO public.cidade VALUES (3248, 'Gameleira', 16);
INSERT INTO public.cidade VALUES (3249, 'Garanhuns', 16);
INSERT INTO public.cidade VALUES (3250, 'Glória do Goitá', 16);
INSERT INTO public.cidade VALUES (3251, 'Goiana', 16);
INSERT INTO public.cidade VALUES (3252, 'Granito', 16);
INSERT INTO public.cidade VALUES (3253, 'Gravatá', 16);
INSERT INTO public.cidade VALUES (3254, 'Iati', 16);
INSERT INTO public.cidade VALUES (3255, 'Ibimirim', 16);
INSERT INTO public.cidade VALUES (3256, 'Ibirajuba', 16);
INSERT INTO public.cidade VALUES (3257, 'Igarassu', 16);
INSERT INTO public.cidade VALUES (3258, 'Iguaraci', 16);
INSERT INTO public.cidade VALUES (3259, 'Ilha de Itamaracá', 16);
INSERT INTO public.cidade VALUES (3260, 'Inajá', 16);
INSERT INTO public.cidade VALUES (3261, 'Ingazeira', 16);
INSERT INTO public.cidade VALUES (3262, 'Ipojuca', 16);
INSERT INTO public.cidade VALUES (3263, 'Ipubi', 16);
INSERT INTO public.cidade VALUES (3264, 'Itacuruba', 16);
INSERT INTO public.cidade VALUES (3265, 'Itaíba', 16);
INSERT INTO public.cidade VALUES (3266, 'Itambé', 16);
INSERT INTO public.cidade VALUES (3267, 'Itapetim', 16);
INSERT INTO public.cidade VALUES (3268, 'Itapissuma', 16);
INSERT INTO public.cidade VALUES (3269, 'Itaquitinga', 16);
INSERT INTO public.cidade VALUES (3270, 'Jaboatão dos Guararapes', 16);
INSERT INTO public.cidade VALUES (3271, 'Jaqueira', 16);
INSERT INTO public.cidade VALUES (3272, 'Jataúba', 16);
INSERT INTO public.cidade VALUES (3273, 'Jatobá', 16);
INSERT INTO public.cidade VALUES (3274, 'João Alfredo', 16);
INSERT INTO public.cidade VALUES (3275, 'Joaquim Nabuco', 16);
INSERT INTO public.cidade VALUES (3276, 'Jucati', 16);
INSERT INTO public.cidade VALUES (3277, 'Jupi', 16);
INSERT INTO public.cidade VALUES (3278, 'Jurema', 16);
INSERT INTO public.cidade VALUES (3279, 'Lagoa do Carro', 16);
INSERT INTO public.cidade VALUES (3280, 'Lagoa do Itaenga', 16);
INSERT INTO public.cidade VALUES (3281, 'Lagoa do Ouro', 16);
INSERT INTO public.cidade VALUES (3282, 'Lagoa dos Gatos', 16);
INSERT INTO public.cidade VALUES (3283, 'Lagoa Grande', 16);
INSERT INTO public.cidade VALUES (3284, 'Lajedo', 16);
INSERT INTO public.cidade VALUES (3285, 'Limoeiro', 16);
INSERT INTO public.cidade VALUES (3286, 'Macaparana', 16);
INSERT INTO public.cidade VALUES (3287, 'Machados', 16);
INSERT INTO public.cidade VALUES (3288, 'Manari', 16);
INSERT INTO public.cidade VALUES (3289, 'Maraial', 16);
INSERT INTO public.cidade VALUES (3290, 'Mirandiba', 16);
INSERT INTO public.cidade VALUES (3291, 'Moreilândia', 16);
INSERT INTO public.cidade VALUES (3292, 'Moreno', 16);
INSERT INTO public.cidade VALUES (3293, 'Nazaré da Mata', 16);
INSERT INTO public.cidade VALUES (3294, 'Olinda', 16);
INSERT INTO public.cidade VALUES (3295, 'Orobó', 16);
INSERT INTO public.cidade VALUES (3296, 'Orocó', 16);
INSERT INTO public.cidade VALUES (3297, 'Ouricuri', 16);
INSERT INTO public.cidade VALUES (3298, 'Palmares', 16);
INSERT INTO public.cidade VALUES (3299, 'Palmeirina', 16);
INSERT INTO public.cidade VALUES (3300, 'Panelas', 16);
INSERT INTO public.cidade VALUES (3301, 'Paranatama', 16);
INSERT INTO public.cidade VALUES (3302, 'Parnamirim', 16);
INSERT INTO public.cidade VALUES (3303, 'Passira', 16);
INSERT INTO public.cidade VALUES (3304, 'Paudalho', 16);
INSERT INTO public.cidade VALUES (3305, 'Paulista', 16);
INSERT INTO public.cidade VALUES (3306, 'Pedra', 16);
INSERT INTO public.cidade VALUES (3307, 'Pesqueira', 16);
INSERT INTO public.cidade VALUES (3308, 'Petrolândia', 16);
INSERT INTO public.cidade VALUES (3309, 'Petrolina', 16);
INSERT INTO public.cidade VALUES (3310, 'Poção', 16);
INSERT INTO public.cidade VALUES (3311, 'Pombos', 16);
INSERT INTO public.cidade VALUES (3312, 'Primavera', 16);
INSERT INTO public.cidade VALUES (3313, 'Quipapá', 16);
INSERT INTO public.cidade VALUES (3314, 'Quixaba', 16);
INSERT INTO public.cidade VALUES (3315, 'Recife', 16);
INSERT INTO public.cidade VALUES (3316, 'Riacho das Almas', 16);
INSERT INTO public.cidade VALUES (3317, 'Ribeirão', 16);
INSERT INTO public.cidade VALUES (3318, 'Rio Formoso', 16);
INSERT INTO public.cidade VALUES (3319, 'Sairé', 16);
INSERT INTO public.cidade VALUES (3320, 'Salgadinho', 16);
INSERT INTO public.cidade VALUES (3321, 'Salgueiro', 16);
INSERT INTO public.cidade VALUES (3322, 'Saloá', 16);
INSERT INTO public.cidade VALUES (3323, 'Sanharó', 16);
INSERT INTO public.cidade VALUES (3324, 'Santa Cruz', 16);
INSERT INTO public.cidade VALUES (3325, 'Santa Cruz da Baixa Verde', 16);
INSERT INTO public.cidade VALUES (3326, 'Santa Cruz do Capibaribe', 16);
INSERT INTO public.cidade VALUES (3327, 'Santa Filomena', 16);
INSERT INTO public.cidade VALUES (3328, 'Santa Maria da Boa Vista', 16);
INSERT INTO public.cidade VALUES (3329, 'Santa Maria do Cambucá', 16);
INSERT INTO public.cidade VALUES (3330, 'Santa Terezinha', 16);
INSERT INTO public.cidade VALUES (3331, 'São Benedito do Sul', 16);
INSERT INTO public.cidade VALUES (3332, 'São Bento do Una', 16);
INSERT INTO public.cidade VALUES (3333, 'São Caitano', 16);
INSERT INTO public.cidade VALUES (3334, 'São João', 16);
INSERT INTO public.cidade VALUES (3335, 'São Joaquim do Monte', 16);
INSERT INTO public.cidade VALUES (3336, 'São José da Coroa Grande', 16);
INSERT INTO public.cidade VALUES (3337, 'São José do Belmonte', 16);
INSERT INTO public.cidade VALUES (3338, 'São José do Egito', 16);
INSERT INTO public.cidade VALUES (3339, 'São Lourenço da Mata', 16);
INSERT INTO public.cidade VALUES (3340, 'São Vicente Ferrer', 16);
INSERT INTO public.cidade VALUES (3341, 'Serra Talhada', 16);
INSERT INTO public.cidade VALUES (3342, 'Serrita', 16);
INSERT INTO public.cidade VALUES (3343, 'Sertânia', 16);
INSERT INTO public.cidade VALUES (3344, 'Sirinhaém', 16);
INSERT INTO public.cidade VALUES (3345, 'Solidão', 16);
INSERT INTO public.cidade VALUES (3346, 'Surubim', 16);
INSERT INTO public.cidade VALUES (3347, 'Tabira', 16);
INSERT INTO public.cidade VALUES (3348, 'Tacaimbó', 16);
INSERT INTO public.cidade VALUES (3349, 'Tacaratu', 16);
INSERT INTO public.cidade VALUES (3350, 'Tamandaré', 16);
INSERT INTO public.cidade VALUES (3351, 'Taquaritinga do Norte', 16);
INSERT INTO public.cidade VALUES (3352, 'Terezinha', 16);
INSERT INTO public.cidade VALUES (3353, 'Terra Nova', 16);
INSERT INTO public.cidade VALUES (3354, 'Timbaúba', 16);
INSERT INTO public.cidade VALUES (3355, 'Toritama', 16);
INSERT INTO public.cidade VALUES (3356, 'Tracunhaém', 16);
INSERT INTO public.cidade VALUES (3357, 'Trindade', 16);
INSERT INTO public.cidade VALUES (3358, 'Triunfo', 16);
INSERT INTO public.cidade VALUES (3359, 'Tupanatinga', 16);
INSERT INTO public.cidade VALUES (3360, 'Tuparetama', 16);
INSERT INTO public.cidade VALUES (3361, 'Venturosa', 16);
INSERT INTO public.cidade VALUES (3362, 'Verdejante', 16);
INSERT INTO public.cidade VALUES (3363, 'Vertente do Lério', 16);
INSERT INTO public.cidade VALUES (3364, 'Vertentes', 16);
INSERT INTO public.cidade VALUES (3365, 'Vicência', 16);
INSERT INTO public.cidade VALUES (3366, 'Vitória de Santo Antão', 16);
INSERT INTO public.cidade VALUES (3367, 'Xexéu', 16);
INSERT INTO public.cidade VALUES (3368, 'Acauã', 17);
INSERT INTO public.cidade VALUES (3369, 'Agricolândia', 17);
INSERT INTO public.cidade VALUES (3370, 'Água Branca', 17);
INSERT INTO public.cidade VALUES (3371, 'Alagoinha do Piauí', 17);
INSERT INTO public.cidade VALUES (3372, 'Alegrete do Piauí', 17);
INSERT INTO public.cidade VALUES (3373, 'Alto Longá', 17);
INSERT INTO public.cidade VALUES (3374, 'Altos', 17);
INSERT INTO public.cidade VALUES (3375, 'Alvorada do Gurguéia', 17);
INSERT INTO public.cidade VALUES (3376, 'Amarante', 17);
INSERT INTO public.cidade VALUES (3377, 'Angical do Piauí', 17);
INSERT INTO public.cidade VALUES (3378, 'Anísio de Abreu', 17);
INSERT INTO public.cidade VALUES (3379, 'Antônio Almeida', 17);
INSERT INTO public.cidade VALUES (3380, 'Aroazes', 17);
INSERT INTO public.cidade VALUES (3381, 'Aroeiras do Itaim', 17);
INSERT INTO public.cidade VALUES (3382, 'Arraial', 17);
INSERT INTO public.cidade VALUES (3383, 'Assunção do Piauí', 17);
INSERT INTO public.cidade VALUES (3384, 'Avelino Lopes', 17);
INSERT INTO public.cidade VALUES (3385, 'Baixa Grande do Ribeiro', 17);
INSERT INTO public.cidade VALUES (3386, 'Barra d`Alcântara', 17);
INSERT INTO public.cidade VALUES (3387, 'Barras', 17);
INSERT INTO public.cidade VALUES (3388, 'Barreiras do Piauí', 17);
INSERT INTO public.cidade VALUES (3389, 'Barro Duro', 17);
INSERT INTO public.cidade VALUES (3390, 'Batalha', 17);
INSERT INTO public.cidade VALUES (3391, 'Bela Vista do Piauí', 17);
INSERT INTO public.cidade VALUES (3392, 'Belém do Piauí', 17);
INSERT INTO public.cidade VALUES (3393, 'Beneditinos', 17);
INSERT INTO public.cidade VALUES (3394, 'Bertolínia', 17);
INSERT INTO public.cidade VALUES (3395, 'Betânia do Piauí', 17);
INSERT INTO public.cidade VALUES (3396, 'Boa Hora', 17);
INSERT INTO public.cidade VALUES (3397, 'Bocaina', 17);
INSERT INTO public.cidade VALUES (3398, 'Bom Jesus', 17);
INSERT INTO public.cidade VALUES (3399, 'Bom Princípio do Piauí', 17);
INSERT INTO public.cidade VALUES (3400, 'Bonfim do Piauí', 17);
INSERT INTO public.cidade VALUES (3401, 'Boqueirão do Piauí', 17);
INSERT INTO public.cidade VALUES (3402, 'Brasileira', 17);
INSERT INTO public.cidade VALUES (3403, 'Brejo do Piauí', 17);
INSERT INTO public.cidade VALUES (3404, 'Buriti dos Lopes', 17);
INSERT INTO public.cidade VALUES (3405, 'Buriti dos Montes', 17);
INSERT INTO public.cidade VALUES (3406, 'Cabeceiras do Piauí', 17);
INSERT INTO public.cidade VALUES (3407, 'Cajazeiras do Piauí', 17);
INSERT INTO public.cidade VALUES (3408, 'Cajueiro da Praia', 17);
INSERT INTO public.cidade VALUES (3409, 'Caldeirão Grande do Piauí', 17);
INSERT INTO public.cidade VALUES (3410, 'Campinas do Piauí', 17);
INSERT INTO public.cidade VALUES (3411, 'Campo Alegre do Fidalgo', 17);
INSERT INTO public.cidade VALUES (3412, 'Campo Grande do Piauí', 17);
INSERT INTO public.cidade VALUES (3413, 'Campo Largo do Piauí', 17);
INSERT INTO public.cidade VALUES (3414, 'Campo Maior', 17);
INSERT INTO public.cidade VALUES (3415, 'Canavieira', 17);
INSERT INTO public.cidade VALUES (3416, 'Canto do Buriti', 17);
INSERT INTO public.cidade VALUES (3417, 'Capitão de Campos', 17);
INSERT INTO public.cidade VALUES (3418, 'Capitão Gervásio Oliveira', 17);
INSERT INTO public.cidade VALUES (3419, 'Caracol', 17);
INSERT INTO public.cidade VALUES (3420, 'Caraúbas do Piauí', 17);
INSERT INTO public.cidade VALUES (3421, 'Caridade do Piauí', 17);
INSERT INTO public.cidade VALUES (3422, 'Castelo do Piauí', 17);
INSERT INTO public.cidade VALUES (3423, 'Caxingó', 17);
INSERT INTO public.cidade VALUES (3424, 'Cocal', 17);
INSERT INTO public.cidade VALUES (3425, 'Cocal de Telha', 17);
INSERT INTO public.cidade VALUES (3426, 'Cocal dos Alves', 17);
INSERT INTO public.cidade VALUES (3427, 'Coivaras', 17);
INSERT INTO public.cidade VALUES (3428, 'Colônia do Gurguéia', 17);
INSERT INTO public.cidade VALUES (3429, 'Colônia do Piauí', 17);
INSERT INTO public.cidade VALUES (3430, 'Conceição do Canindé', 17);
INSERT INTO public.cidade VALUES (3431, 'Coronel José Dias', 17);
INSERT INTO public.cidade VALUES (3432, 'Corrente', 17);
INSERT INTO public.cidade VALUES (3433, 'Cristalândia do Piauí', 17);
INSERT INTO public.cidade VALUES (3434, 'Cristino Castro', 17);
INSERT INTO public.cidade VALUES (3435, 'Curimatá', 17);
INSERT INTO public.cidade VALUES (3436, 'Currais', 17);
INSERT INTO public.cidade VALUES (3437, 'Curral Novo do Piauí', 17);
INSERT INTO public.cidade VALUES (3438, 'Curralinhos', 17);
INSERT INTO public.cidade VALUES (3439, 'Demerval Lobão', 17);
INSERT INTO public.cidade VALUES (3440, 'Dirceu Arcoverde', 17);
INSERT INTO public.cidade VALUES (3441, 'Dom Expedito Lopes', 17);
INSERT INTO public.cidade VALUES (3442, 'Dom Inocêncio', 17);
INSERT INTO public.cidade VALUES (3443, 'Domingos Mourão', 17);
INSERT INTO public.cidade VALUES (3444, 'Elesbão Veloso', 17);
INSERT INTO public.cidade VALUES (3445, 'Eliseu Martins', 17);
INSERT INTO public.cidade VALUES (3446, 'Esperantina', 17);
INSERT INTO public.cidade VALUES (3447, 'Fartura do Piauí', 17);
INSERT INTO public.cidade VALUES (3448, 'Flores do Piauí', 17);
INSERT INTO public.cidade VALUES (3449, 'Floresta do Piauí', 17);
INSERT INTO public.cidade VALUES (3450, 'Floriano', 17);
INSERT INTO public.cidade VALUES (3451, 'Francinópolis', 17);
INSERT INTO public.cidade VALUES (3452, 'Francisco Ayres', 17);
INSERT INTO public.cidade VALUES (3453, 'Francisco Macedo', 17);
INSERT INTO public.cidade VALUES (3454, 'Francisco Santos', 17);
INSERT INTO public.cidade VALUES (3455, 'Fronteiras', 17);
INSERT INTO public.cidade VALUES (3456, 'Geminiano', 17);
INSERT INTO public.cidade VALUES (3457, 'Gilbués', 17);
INSERT INTO public.cidade VALUES (3458, 'Guadalupe', 17);
INSERT INTO public.cidade VALUES (3459, 'Guaribas', 17);
INSERT INTO public.cidade VALUES (3460, 'Hugo Napoleão', 17);
INSERT INTO public.cidade VALUES (3461, 'Ilha Grande', 17);
INSERT INTO public.cidade VALUES (3462, 'Inhuma', 17);
INSERT INTO public.cidade VALUES (3463, 'Ipiranga do Piauí', 17);
INSERT INTO public.cidade VALUES (3464, 'Isaías Coelho', 17);
INSERT INTO public.cidade VALUES (3465, 'Itainópolis', 17);
INSERT INTO public.cidade VALUES (3466, 'Itaueira', 17);
INSERT INTO public.cidade VALUES (3467, 'Jacobina do Piauí', 17);
INSERT INTO public.cidade VALUES (3468, 'Jaicós', 17);
INSERT INTO public.cidade VALUES (3469, 'Jardim do Mulato', 17);
INSERT INTO public.cidade VALUES (3470, 'Jatobá do Piauí', 17);
INSERT INTO public.cidade VALUES (3471, 'Jerumenha', 17);
INSERT INTO public.cidade VALUES (3472, 'João Costa', 17);
INSERT INTO public.cidade VALUES (3473, 'Joaquim Pires', 17);
INSERT INTO public.cidade VALUES (3474, 'Joca Marques', 17);
INSERT INTO public.cidade VALUES (3475, 'José de Freitas', 17);
INSERT INTO public.cidade VALUES (3476, 'Juazeiro do Piauí', 17);
INSERT INTO public.cidade VALUES (3477, 'Júlio Borges', 17);
INSERT INTO public.cidade VALUES (3478, 'Jurema', 17);
INSERT INTO public.cidade VALUES (3479, 'Lagoa Alegre', 17);
INSERT INTO public.cidade VALUES (3480, 'Lagoa de São Francisco', 17);
INSERT INTO public.cidade VALUES (3481, 'Lagoa do Barro do Piauí', 17);
INSERT INTO public.cidade VALUES (3482, 'Lagoa do Piauí', 17);
INSERT INTO public.cidade VALUES (3483, 'Lagoa do Sítio', 17);
INSERT INTO public.cidade VALUES (3484, 'Lagoinha do Piauí', 17);
INSERT INTO public.cidade VALUES (3485, 'Landri Sales', 17);
INSERT INTO public.cidade VALUES (3486, 'Luís Correia', 17);
INSERT INTO public.cidade VALUES (3487, 'Luzilândia', 17);
INSERT INTO public.cidade VALUES (3488, 'Madeiro', 17);
INSERT INTO public.cidade VALUES (3489, 'Manoel Emídio', 17);
INSERT INTO public.cidade VALUES (3490, 'Marcolândia', 17);
INSERT INTO public.cidade VALUES (3491, 'Marcos Parente', 17);
INSERT INTO public.cidade VALUES (3492, 'Massapê do Piauí', 17);
INSERT INTO public.cidade VALUES (3493, 'Matias Olímpio', 17);
INSERT INTO public.cidade VALUES (3494, 'Miguel Alves', 17);
INSERT INTO public.cidade VALUES (3495, 'Miguel Leão', 17);
INSERT INTO public.cidade VALUES (3496, 'Milton Brandão', 17);
INSERT INTO public.cidade VALUES (3497, 'Monsenhor Gil', 17);
INSERT INTO public.cidade VALUES (3498, 'Monsenhor Hipólito', 17);
INSERT INTO public.cidade VALUES (3499, 'Monte Alegre do Piauí', 17);
INSERT INTO public.cidade VALUES (3500, 'Morro Cabeça no Tempo', 17);
INSERT INTO public.cidade VALUES (3501, 'Morro do Chapéu do Piauí', 17);
INSERT INTO public.cidade VALUES (3502, 'Murici dos Portelas', 17);
INSERT INTO public.cidade VALUES (3503, 'Nazaré do Piauí', 17);
INSERT INTO public.cidade VALUES (3504, 'Nossa Senhora de Nazaré', 17);
INSERT INTO public.cidade VALUES (3505, 'Nossa Senhora dos Remédios', 17);
INSERT INTO public.cidade VALUES (3506, 'Nova Santa Rita', 17);
INSERT INTO public.cidade VALUES (3507, 'Novo Oriente do Piauí', 17);
INSERT INTO public.cidade VALUES (3508, 'Novo Santo Antônio', 17);
INSERT INTO public.cidade VALUES (3509, 'Oeiras', 17);
INSERT INTO public.cidade VALUES (3510, 'Olho d`Água do Piauí', 17);
INSERT INTO public.cidade VALUES (3511, 'Padre Marcos', 17);
INSERT INTO public.cidade VALUES (3512, 'Paes Landim', 17);
INSERT INTO public.cidade VALUES (3513, 'Pajeú do Piauí', 17);
INSERT INTO public.cidade VALUES (3514, 'Palmeira do Piauí', 17);
INSERT INTO public.cidade VALUES (3515, 'Palmeirais', 17);
INSERT INTO public.cidade VALUES (3516, 'Paquetá', 17);
INSERT INTO public.cidade VALUES (3517, 'Parnaguá', 17);
INSERT INTO public.cidade VALUES (3518, 'Parnaíba', 17);
INSERT INTO public.cidade VALUES (3519, 'Passagem Franca do Piauí', 17);
INSERT INTO public.cidade VALUES (3520, 'Patos do Piauí', 17);
INSERT INTO public.cidade VALUES (3521, 'Pau d`Arco do Piauí', 17);
INSERT INTO public.cidade VALUES (3522, 'Paulistana', 17);
INSERT INTO public.cidade VALUES (3523, 'Pavussu', 17);
INSERT INTO public.cidade VALUES (3524, 'Pedro II', 17);
INSERT INTO public.cidade VALUES (3525, 'Pedro Laurentino', 17);
INSERT INTO public.cidade VALUES (3526, 'Picos', 17);
INSERT INTO public.cidade VALUES (3527, 'Pimenteiras', 17);
INSERT INTO public.cidade VALUES (3528, 'Pio IX', 17);
INSERT INTO public.cidade VALUES (3529, 'Piracuruca', 17);
INSERT INTO public.cidade VALUES (3530, 'Piripiri', 17);
INSERT INTO public.cidade VALUES (3531, 'Porto', 17);
INSERT INTO public.cidade VALUES (3532, 'Porto Alegre do Piauí', 17);
INSERT INTO public.cidade VALUES (3533, 'Prata do Piauí', 17);
INSERT INTO public.cidade VALUES (3534, 'Queimada Nova', 17);
INSERT INTO public.cidade VALUES (3535, 'Redenção do Gurguéia', 17);
INSERT INTO public.cidade VALUES (3536, 'Regeneração', 17);
INSERT INTO public.cidade VALUES (3537, 'Riacho Frio', 17);
INSERT INTO public.cidade VALUES (3538, 'Ribeira do Piauí', 17);
INSERT INTO public.cidade VALUES (3539, 'Ribeiro Gonçalves', 17);
INSERT INTO public.cidade VALUES (3540, 'Rio Grande do Piauí', 17);
INSERT INTO public.cidade VALUES (3541, 'Santa Cruz do Piauí', 17);
INSERT INTO public.cidade VALUES (3542, 'Santa Cruz dos Milagres', 17);
INSERT INTO public.cidade VALUES (3543, 'Santa Filomena', 17);
INSERT INTO public.cidade VALUES (3544, 'Santa Luz', 17);
INSERT INTO public.cidade VALUES (3545, 'Santa Rosa do Piauí', 17);
INSERT INTO public.cidade VALUES (3546, 'Santana do Piauí', 17);
INSERT INTO public.cidade VALUES (3547, 'Santo Antônio de Lisboa', 17);
INSERT INTO public.cidade VALUES (3548, 'Santo Antônio dos Milagres', 17);
INSERT INTO public.cidade VALUES (3549, 'Santo Inácio do Piauí', 17);
INSERT INTO public.cidade VALUES (3550, 'São Braz do Piauí', 17);
INSERT INTO public.cidade VALUES (3551, 'São Félix do Piauí', 17);
INSERT INTO public.cidade VALUES (3552, 'São Francisco de Assis do Piauí', 17);
INSERT INTO public.cidade VALUES (3553, 'São Francisco do Piauí', 17);
INSERT INTO public.cidade VALUES (3554, 'São Gonçalo do Gurguéia', 17);
INSERT INTO public.cidade VALUES (3555, 'São Gonçalo do Piauí', 17);
INSERT INTO public.cidade VALUES (3556, 'São João da Canabrava', 17);
INSERT INTO public.cidade VALUES (3557, 'São João da Fronteira', 17);
INSERT INTO public.cidade VALUES (3558, 'São João da Serra', 17);
INSERT INTO public.cidade VALUES (3559, 'São João da Varjota', 17);
INSERT INTO public.cidade VALUES (3560, 'São João do Arraial', 17);
INSERT INTO public.cidade VALUES (3561, 'São João do Piauí', 17);
INSERT INTO public.cidade VALUES (3562, 'São José do Divino', 17);
INSERT INTO public.cidade VALUES (3563, 'São José do Peixe', 17);
INSERT INTO public.cidade VALUES (3564, 'São José do Piauí', 17);
INSERT INTO public.cidade VALUES (3565, 'São Julião', 17);
INSERT INTO public.cidade VALUES (3566, 'São Lourenço do Piauí', 17);
INSERT INTO public.cidade VALUES (3567, 'São Luis do Piauí', 17);
INSERT INTO public.cidade VALUES (3568, 'São Miguel da Baixa Grande', 17);
INSERT INTO public.cidade VALUES (3569, 'São Miguel do Fidalgo', 17);
INSERT INTO public.cidade VALUES (3570, 'São Miguel do Tapuio', 17);
INSERT INTO public.cidade VALUES (3571, 'São Pedro do Piauí', 17);
INSERT INTO public.cidade VALUES (3572, 'São Raimundo Nonato', 17);
INSERT INTO public.cidade VALUES (3573, 'Sebastião Barros', 17);
INSERT INTO public.cidade VALUES (3574, 'Sebastião Leal', 17);
INSERT INTO public.cidade VALUES (3575, 'Sigefredo Pacheco', 17);
INSERT INTO public.cidade VALUES (3576, 'Simões', 17);
INSERT INTO public.cidade VALUES (3577, 'Simplício Mendes', 17);
INSERT INTO public.cidade VALUES (3578, 'Socorro do Piauí', 17);
INSERT INTO public.cidade VALUES (3579, 'Sussuapara', 17);
INSERT INTO public.cidade VALUES (3580, 'Tamboril do Piauí', 17);
INSERT INTO public.cidade VALUES (3581, 'Tanque do Piauí', 17);
INSERT INTO public.cidade VALUES (3582, 'Teresina', 17);
INSERT INTO public.cidade VALUES (3583, 'União', 17);
INSERT INTO public.cidade VALUES (3584, 'Uruçuí', 17);
INSERT INTO public.cidade VALUES (3585, 'Valença do Piauí', 17);
INSERT INTO public.cidade VALUES (3586, 'Várzea Branca', 17);
INSERT INTO public.cidade VALUES (3587, 'Várzea Grande', 17);
INSERT INTO public.cidade VALUES (3588, 'Vera Mendes', 17);
INSERT INTO public.cidade VALUES (3589, 'Vila Nova do Piauí', 17);
INSERT INTO public.cidade VALUES (3590, 'Wall Ferraz', 17);
INSERT INTO public.cidade VALUES (3591, 'Angra dos Reis', 19);
INSERT INTO public.cidade VALUES (3592, 'Aperibé', 19);
INSERT INTO public.cidade VALUES (3593, 'Araruama', 19);
INSERT INTO public.cidade VALUES (3594, 'Areal', 19);
INSERT INTO public.cidade VALUES (3595, 'Armação dos Búzios', 19);
INSERT INTO public.cidade VALUES (3596, 'Arraial do Cabo', 19);
INSERT INTO public.cidade VALUES (3597, 'Barra do Piraí', 19);
INSERT INTO public.cidade VALUES (3598, 'Barra Mansa', 19);
INSERT INTO public.cidade VALUES (3599, 'Belford Roxo', 19);
INSERT INTO public.cidade VALUES (3600, 'Bom Jardim', 19);
INSERT INTO public.cidade VALUES (3601, 'Bom Jesus do Itabapoana', 19);
INSERT INTO public.cidade VALUES (3602, 'Cabo Frio', 19);
INSERT INTO public.cidade VALUES (3603, 'Cachoeiras de Macacu', 19);
INSERT INTO public.cidade VALUES (3604, 'Cambuci', 19);
INSERT INTO public.cidade VALUES (3605, 'Campos dos Goytacazes', 19);
INSERT INTO public.cidade VALUES (3606, 'Cantagalo', 19);
INSERT INTO public.cidade VALUES (3607, 'Carapebus', 19);
INSERT INTO public.cidade VALUES (3608, 'Cardoso Moreira', 19);
INSERT INTO public.cidade VALUES (3609, 'Carmo', 19);
INSERT INTO public.cidade VALUES (3610, 'Casimiro de Abreu', 19);
INSERT INTO public.cidade VALUES (3611, 'Comendador Levy Gasparian', 19);
INSERT INTO public.cidade VALUES (3612, 'Conceição de Macabu', 19);
INSERT INTO public.cidade VALUES (3613, 'Cordeiro', 19);
INSERT INTO public.cidade VALUES (3614, 'Duas Barras', 19);
INSERT INTO public.cidade VALUES (3615, 'Duque de Caxias', 19);
INSERT INTO public.cidade VALUES (3616, 'Engenheiro Paulo de Frontin', 19);
INSERT INTO public.cidade VALUES (3617, 'Guapimirim', 19);
INSERT INTO public.cidade VALUES (3618, 'Iguaba Grande', 19);
INSERT INTO public.cidade VALUES (3619, 'Itaboraí', 19);
INSERT INTO public.cidade VALUES (3620, 'Itaguaí', 19);
INSERT INTO public.cidade VALUES (3621, 'Italva', 19);
INSERT INTO public.cidade VALUES (3622, 'Itaocara', 19);
INSERT INTO public.cidade VALUES (3623, 'Itaperuna', 19);
INSERT INTO public.cidade VALUES (3624, 'Itatiaia', 19);
INSERT INTO public.cidade VALUES (3625, 'Japeri', 19);
INSERT INTO public.cidade VALUES (3626, 'Laje do Muriaé', 19);
INSERT INTO public.cidade VALUES (3627, 'Macaé', 19);
INSERT INTO public.cidade VALUES (3628, 'Macuco', 19);
INSERT INTO public.cidade VALUES (3629, 'Magé', 19);
INSERT INTO public.cidade VALUES (3630, 'Mangaratiba', 19);
INSERT INTO public.cidade VALUES (3631, 'Maricá', 19);
INSERT INTO public.cidade VALUES (3632, 'Mendes', 19);
INSERT INTO public.cidade VALUES (3633, 'Mesquita', 19);
INSERT INTO public.cidade VALUES (3634, 'Miguel Pereira', 19);
INSERT INTO public.cidade VALUES (3635, 'Miracema', 19);
INSERT INTO public.cidade VALUES (3636, 'Natividade', 19);
INSERT INTO public.cidade VALUES (3637, 'Nilópolis', 19);
INSERT INTO public.cidade VALUES (3638, 'Niterói', 19);
INSERT INTO public.cidade VALUES (3639, 'Nova Friburgo', 19);
INSERT INTO public.cidade VALUES (3640, 'Nova Iguaçu', 19);
INSERT INTO public.cidade VALUES (3641, 'Paracambi', 19);
INSERT INTO public.cidade VALUES (3642, 'Paraíba do Sul', 19);
INSERT INTO public.cidade VALUES (3643, 'Parati', 19);
INSERT INTO public.cidade VALUES (3644, 'Paty do Alferes', 19);
INSERT INTO public.cidade VALUES (3645, 'Petrópolis', 19);
INSERT INTO public.cidade VALUES (3646, 'Pinheiral', 19);
INSERT INTO public.cidade VALUES (3647, 'Piraí', 19);
INSERT INTO public.cidade VALUES (3648, 'Porciúncula', 19);
INSERT INTO public.cidade VALUES (3649, 'Porto Real', 19);
INSERT INTO public.cidade VALUES (3650, 'Quatis', 19);
INSERT INTO public.cidade VALUES (3651, 'Queimados', 19);
INSERT INTO public.cidade VALUES (3652, 'Quissamã', 19);
INSERT INTO public.cidade VALUES (3653, 'Resende', 19);
INSERT INTO public.cidade VALUES (3654, 'Rio Bonito', 19);
INSERT INTO public.cidade VALUES (3655, 'Rio Claro', 19);
INSERT INTO public.cidade VALUES (3656, 'Rio das Flores', 19);
INSERT INTO public.cidade VALUES (3657, 'Rio das Ostras', 19);
INSERT INTO public.cidade VALUES (3658, 'Rio de Janeiro', 19);
INSERT INTO public.cidade VALUES (3659, 'Santa Maria Madalena', 19);
INSERT INTO public.cidade VALUES (3660, 'Santo Antônio de Pádua', 19);
INSERT INTO public.cidade VALUES (3661, 'São Fidélis', 19);
INSERT INTO public.cidade VALUES (3662, 'São Francisco de Itabapoana', 19);
INSERT INTO public.cidade VALUES (3663, 'São Gonçalo', 19);
INSERT INTO public.cidade VALUES (3664, 'São João da Barra', 19);
INSERT INTO public.cidade VALUES (3665, 'São João de Meriti', 19);
INSERT INTO public.cidade VALUES (3666, 'São José de Ubá', 19);
INSERT INTO public.cidade VALUES (3667, 'São José do Vale do Rio Preto', 19);
INSERT INTO public.cidade VALUES (3668, 'São Pedro da Aldeia', 19);
INSERT INTO public.cidade VALUES (3669, 'São Sebastião do Alto', 19);
INSERT INTO public.cidade VALUES (3670, 'Sapucaia', 19);
INSERT INTO public.cidade VALUES (3671, 'Saquarema', 19);
INSERT INTO public.cidade VALUES (3672, 'Seropédica', 19);
INSERT INTO public.cidade VALUES (3673, 'Silva Jardim', 19);
INSERT INTO public.cidade VALUES (3674, 'Sumidouro', 19);
INSERT INTO public.cidade VALUES (3675, 'Tanguá', 19);
INSERT INTO public.cidade VALUES (3676, 'Teresópolis', 19);
INSERT INTO public.cidade VALUES (3677, 'Trajano de Morais', 19);
INSERT INTO public.cidade VALUES (3678, 'Três Rios', 19);
INSERT INTO public.cidade VALUES (3679, 'Valença', 19);
INSERT INTO public.cidade VALUES (3680, 'Varre-Sai', 19);
INSERT INTO public.cidade VALUES (3681, 'Vassouras', 19);
INSERT INTO public.cidade VALUES (3682, 'Volta Redonda', 19);
INSERT INTO public.cidade VALUES (3683, 'Acari', 20);
INSERT INTO public.cidade VALUES (3684, 'Açu', 20);
INSERT INTO public.cidade VALUES (3685, 'Afonso Bezerra', 20);
INSERT INTO public.cidade VALUES (3686, 'Água Nova', 20);
INSERT INTO public.cidade VALUES (3687, 'Alexandria', 20);
INSERT INTO public.cidade VALUES (3688, 'Almino Afonso', 20);
INSERT INTO public.cidade VALUES (3689, 'Alto do Rodrigues', 20);
INSERT INTO public.cidade VALUES (3690, 'Jardim de Angicos', 20);
INSERT INTO public.cidade VALUES (3691, 'Antônio Martins', 20);
INSERT INTO public.cidade VALUES (3692, 'Apodi', 20);
INSERT INTO public.cidade VALUES (3693, 'Areia Branca', 20);
INSERT INTO public.cidade VALUES (3694, 'Arês', 20);
INSERT INTO public.cidade VALUES (3695, 'Augusto Severo', 20);
INSERT INTO public.cidade VALUES (3696, 'Baía Formosa', 20);
INSERT INTO public.cidade VALUES (3697, 'Baraúna', 20);
INSERT INTO public.cidade VALUES (3698, 'Barcelona', 20);
INSERT INTO public.cidade VALUES (3699, 'Bento Fernandes', 20);
INSERT INTO public.cidade VALUES (3700, 'Bodó', 20);
INSERT INTO public.cidade VALUES (3701, 'Bom Jesus', 20);
INSERT INTO public.cidade VALUES (3702, 'Brejinho', 20);
INSERT INTO public.cidade VALUES (3703, 'Caiçara do Norte', 20);
INSERT INTO public.cidade VALUES (3704, 'Caiçara do Rio do Vento', 20);
INSERT INTO public.cidade VALUES (3705, 'Caicó', 20);
INSERT INTO public.cidade VALUES (3706, 'Campo Redondo', 20);
INSERT INTO public.cidade VALUES (3707, 'Canguaretama', 20);
INSERT INTO public.cidade VALUES (3708, 'Caraúbas', 20);
INSERT INTO public.cidade VALUES (3709, 'Carnaúba dos Dantas', 20);
INSERT INTO public.cidade VALUES (3710, 'Carnaubais', 20);
INSERT INTO public.cidade VALUES (3711, 'Ceará-Mirim', 20);
INSERT INTO public.cidade VALUES (3712, 'Cerro Corá', 20);
INSERT INTO public.cidade VALUES (3713, 'Coronel Ezequiel', 20);
INSERT INTO public.cidade VALUES (3714, 'Coronel João Pessoa', 20);
INSERT INTO public.cidade VALUES (3715, 'Cruzeta', 20);
INSERT INTO public.cidade VALUES (3716, 'Currais Novos', 20);
INSERT INTO public.cidade VALUES (3717, 'Doutor Severiano', 20);
INSERT INTO public.cidade VALUES (3718, 'Encanto', 20);
INSERT INTO public.cidade VALUES (3719, 'Equador', 20);
INSERT INTO public.cidade VALUES (3720, 'Espírito Santo', 20);
INSERT INTO public.cidade VALUES (3721, 'Extremoz', 20);
INSERT INTO public.cidade VALUES (3722, 'Felipe Guerra', 20);
INSERT INTO public.cidade VALUES (3723, 'Fernando Pedroza', 20);
INSERT INTO public.cidade VALUES (3724, 'Florânia', 20);
INSERT INTO public.cidade VALUES (3725, 'Francisco Dantas', 20);
INSERT INTO public.cidade VALUES (3726, 'Frutuoso Gomes', 20);
INSERT INTO public.cidade VALUES (3727, 'Galinhos', 20);
INSERT INTO public.cidade VALUES (3728, 'Goianinha', 20);
INSERT INTO public.cidade VALUES (3729, 'Governador Dix-Sept Rosado', 20);
INSERT INTO public.cidade VALUES (3730, 'Grossos', 20);
INSERT INTO public.cidade VALUES (3731, 'Guamaré', 20);
INSERT INTO public.cidade VALUES (3732, 'Ielmo Marinho', 20);
INSERT INTO public.cidade VALUES (3733, 'Ipanguaçu', 20);
INSERT INTO public.cidade VALUES (3734, 'Ipueira', 20);
INSERT INTO public.cidade VALUES (3735, 'Itajá', 20);
INSERT INTO public.cidade VALUES (3736, 'Itaú', 20);
INSERT INTO public.cidade VALUES (3737, 'Jaçanã', 20);
INSERT INTO public.cidade VALUES (3738, 'Jandaíra', 20);
INSERT INTO public.cidade VALUES (3739, 'Janduís', 20);
INSERT INTO public.cidade VALUES (3740, 'Januário Cicco', 20);
INSERT INTO public.cidade VALUES (3741, 'Japi', 20);
INSERT INTO public.cidade VALUES (3743, 'Jardim de Piranhas', 20);
INSERT INTO public.cidade VALUES (3744, 'Jardim do Seridó', 20);
INSERT INTO public.cidade VALUES (3745, 'João Câmara', 20);
INSERT INTO public.cidade VALUES (3746, 'João Dias', 20);
INSERT INTO public.cidade VALUES (3747, 'José da Penha', 20);
INSERT INTO public.cidade VALUES (3748, 'Jucurutu', 20);
INSERT INTO public.cidade VALUES (3749, 'Jundiá', 20);
INSERT INTO public.cidade VALUES (3750, 'Lagoa d`Anta', 20);
INSERT INTO public.cidade VALUES (3751, 'Lagoa de Pedras', 20);
INSERT INTO public.cidade VALUES (3752, 'Lagoa de Velhos', 20);
INSERT INTO public.cidade VALUES (3753, 'Lagoa Nova', 20);
INSERT INTO public.cidade VALUES (3754, 'Lagoa Salgada', 20);
INSERT INTO public.cidade VALUES (3755, 'Lajes', 20);
INSERT INTO public.cidade VALUES (3756, 'Lajes Pintadas', 20);
INSERT INTO public.cidade VALUES (3757, 'Lucrécia', 20);
INSERT INTO public.cidade VALUES (3758, 'Luís Gomes', 20);
INSERT INTO public.cidade VALUES (3759, 'Macaíba', 20);
INSERT INTO public.cidade VALUES (3760, 'Macau', 20);
INSERT INTO public.cidade VALUES (3761, 'Major Sales', 20);
INSERT INTO public.cidade VALUES (3762, 'Marcelino Vieira', 20);
INSERT INTO public.cidade VALUES (3763, 'Martins', 20);
INSERT INTO public.cidade VALUES (3764, 'Maxaranguape', 20);
INSERT INTO public.cidade VALUES (3765, 'Messias Targino', 20);
INSERT INTO public.cidade VALUES (3766, 'Montanhas', 20);
INSERT INTO public.cidade VALUES (3767, 'Monte Alegre', 20);
INSERT INTO public.cidade VALUES (3768, 'Monte das Gameleiras', 20);
INSERT INTO public.cidade VALUES (3769, 'Mossoró', 20);
INSERT INTO public.cidade VALUES (3770, 'Natal', 20);
INSERT INTO public.cidade VALUES (3771, 'Nísia Floresta', 20);
INSERT INTO public.cidade VALUES (3772, 'Nova Cruz', 20);
INSERT INTO public.cidade VALUES (3773, 'Olho-d`Água do Borges', 20);
INSERT INTO public.cidade VALUES (3774, 'Ouro Branco', 20);
INSERT INTO public.cidade VALUES (3775, 'Paraná', 20);
INSERT INTO public.cidade VALUES (3776, 'Paraú', 20);
INSERT INTO public.cidade VALUES (3777, 'Parazinho', 20);
INSERT INTO public.cidade VALUES (3778, 'Parelhas', 20);
INSERT INTO public.cidade VALUES (3779, 'Parnamirim', 20);
INSERT INTO public.cidade VALUES (3780, 'Passa e Fica', 20);
INSERT INTO public.cidade VALUES (3781, 'Passagem', 20);
INSERT INTO public.cidade VALUES (3782, 'Patu', 20);
INSERT INTO public.cidade VALUES (3783, 'Pau dos Ferros', 20);
INSERT INTO public.cidade VALUES (3784, 'Pedra Grande', 20);
INSERT INTO public.cidade VALUES (3785, 'Pedra Preta', 20);
INSERT INTO public.cidade VALUES (3786, 'Pedro Avelino', 20);
INSERT INTO public.cidade VALUES (3787, 'Pedro Velho', 20);
INSERT INTO public.cidade VALUES (3788, 'Pendências', 20);
INSERT INTO public.cidade VALUES (3789, 'Pilões', 20);
INSERT INTO public.cidade VALUES (3790, 'Poço Branco', 20);
INSERT INTO public.cidade VALUES (3791, 'Portalegre', 20);
INSERT INTO public.cidade VALUES (3792, 'Porto do Mangue', 20);
INSERT INTO public.cidade VALUES (3793, 'Presidente Juscelino', 20);
INSERT INTO public.cidade VALUES (3794, 'Pureza', 20);
INSERT INTO public.cidade VALUES (3795, 'Rafael Fernandes', 20);
INSERT INTO public.cidade VALUES (3796, 'Rafael Godeiro', 20);
INSERT INTO public.cidade VALUES (3797, 'Riacho da Cruz', 20);
INSERT INTO public.cidade VALUES (3798, 'Riacho de Santana', 20);
INSERT INTO public.cidade VALUES (3799, 'Riachuelo', 20);
INSERT INTO public.cidade VALUES (3800, 'Rio do Fogo', 20);
INSERT INTO public.cidade VALUES (3801, 'Rodolfo Fernandes', 20);
INSERT INTO public.cidade VALUES (3802, 'Ruy Barbosa', 20);
INSERT INTO public.cidade VALUES (3803, 'Santa Cruz', 20);
INSERT INTO public.cidade VALUES (3804, 'Santa Maria', 20);
INSERT INTO public.cidade VALUES (3805, 'Santana do Matos', 20);
INSERT INTO public.cidade VALUES (3806, 'Santana do Seridó', 20);
INSERT INTO public.cidade VALUES (3807, 'Santo Antônio', 20);
INSERT INTO public.cidade VALUES (3808, 'São Bento do Norte', 20);
INSERT INTO public.cidade VALUES (3809, 'São Bento do Trairí', 20);
INSERT INTO public.cidade VALUES (3810, 'São Fernando', 20);
INSERT INTO public.cidade VALUES (3811, 'São Francisco do Oeste', 20);
INSERT INTO public.cidade VALUES (3812, 'São Gonçalo do Amarante', 20);
INSERT INTO public.cidade VALUES (3813, 'São João do Sabugi', 20);
INSERT INTO public.cidade VALUES (3814, 'São José de Mipibu', 20);
INSERT INTO public.cidade VALUES (3815, 'São José do Campestre', 20);
INSERT INTO public.cidade VALUES (3816, 'São José do Seridó', 20);
INSERT INTO public.cidade VALUES (3817, 'São Miguel', 20);
INSERT INTO public.cidade VALUES (3818, 'São Miguel do Gostoso', 20);
INSERT INTO public.cidade VALUES (3819, 'São Paulo do Potengi', 20);
INSERT INTO public.cidade VALUES (3820, 'São Pedro', 20);
INSERT INTO public.cidade VALUES (3821, 'São Rafael', 20);
INSERT INTO public.cidade VALUES (3822, 'São Tomé', 20);
INSERT INTO public.cidade VALUES (3823, 'São Vicente', 20);
INSERT INTO public.cidade VALUES (3824, 'Senador Elói de Souza', 20);
INSERT INTO public.cidade VALUES (3825, 'Senador Georgino Avelino', 20);
INSERT INTO public.cidade VALUES (3826, 'Serra de São Bento', 20);
INSERT INTO public.cidade VALUES (3827, 'Serra do Mel', 20);
INSERT INTO public.cidade VALUES (3828, 'Serra Negra do Norte', 20);
INSERT INTO public.cidade VALUES (3829, 'Serrinha', 20);
INSERT INTO public.cidade VALUES (3830, 'Serrinha dos Pintos', 20);
INSERT INTO public.cidade VALUES (3831, 'Severiano Melo', 20);
INSERT INTO public.cidade VALUES (3832, 'Sítio Novo', 20);
INSERT INTO public.cidade VALUES (3833, 'Taboleiro Grande', 20);
INSERT INTO public.cidade VALUES (3834, 'Taipu', 20);
INSERT INTO public.cidade VALUES (3835, 'Tangará', 20);
INSERT INTO public.cidade VALUES (3836, 'Tenente Ananias', 20);
INSERT INTO public.cidade VALUES (3837, 'Tenente Laurentino Cruz', 20);
INSERT INTO public.cidade VALUES (3838, 'Tibau', 20);
INSERT INTO public.cidade VALUES (3839, 'Tibau do Sul', 20);
INSERT INTO public.cidade VALUES (3840, 'Timbaúba dos Batistas', 20);
INSERT INTO public.cidade VALUES (3841, 'Touros', 20);
INSERT INTO public.cidade VALUES (3842, 'Triunfo Potiguar', 20);
INSERT INTO public.cidade VALUES (3843, 'Umarizal', 20);
INSERT INTO public.cidade VALUES (3844, 'Upanema', 20);
INSERT INTO public.cidade VALUES (3845, 'Várzea', 20);
INSERT INTO public.cidade VALUES (3846, 'Venha-Ver', 20);
INSERT INTO public.cidade VALUES (3847, 'Vera Cruz', 20);
INSERT INTO public.cidade VALUES (3848, 'Viçosa', 20);
INSERT INTO public.cidade VALUES (3849, 'Vila Flor', 20);
INSERT INTO public.cidade VALUES (3850, 'Aceguá', 23);
INSERT INTO public.cidade VALUES (3851, 'Água Santa', 23);
INSERT INTO public.cidade VALUES (3852, 'Agudo', 23);
INSERT INTO public.cidade VALUES (3853, 'Ajuricaba', 23);
INSERT INTO public.cidade VALUES (3854, 'Alecrim', 23);
INSERT INTO public.cidade VALUES (3855, 'Alegrete', 23);
INSERT INTO public.cidade VALUES (3856, 'Alegria', 23);
INSERT INTO public.cidade VALUES (3857, 'Almirante Tamandaré do Sul', 23);
INSERT INTO public.cidade VALUES (3858, 'Alpestre', 23);
INSERT INTO public.cidade VALUES (3859, 'Alto Alegre', 23);
INSERT INTO public.cidade VALUES (3860, 'Alto Feliz', 23);
INSERT INTO public.cidade VALUES (3861, 'Alvorada', 23);
INSERT INTO public.cidade VALUES (3862, 'Amaral Ferrador', 23);
INSERT INTO public.cidade VALUES (3863, 'Ametista do Sul', 23);
INSERT INTO public.cidade VALUES (3864, 'André da Rocha', 23);
INSERT INTO public.cidade VALUES (3865, 'Anta Gorda', 23);
INSERT INTO public.cidade VALUES (3866, 'Antônio Prado', 23);
INSERT INTO public.cidade VALUES (3867, 'Arambaré', 23);
INSERT INTO public.cidade VALUES (3868, 'Araricá', 23);
INSERT INTO public.cidade VALUES (3869, 'Aratiba', 23);
INSERT INTO public.cidade VALUES (3870, 'Arroio do Meio', 23);
INSERT INTO public.cidade VALUES (3871, 'Arroio do Padre', 23);
INSERT INTO public.cidade VALUES (3872, 'Arroio do Sal', 23);
INSERT INTO public.cidade VALUES (3873, 'Arroio do Tigre', 23);
INSERT INTO public.cidade VALUES (3874, 'Arroio dos Ratos', 23);
INSERT INTO public.cidade VALUES (3875, 'Arroio Grande', 23);
INSERT INTO public.cidade VALUES (3876, 'Arvorezinha', 23);
INSERT INTO public.cidade VALUES (3877, 'Augusto Pestana', 23);
INSERT INTO public.cidade VALUES (3878, 'Áurea', 23);
INSERT INTO public.cidade VALUES (3879, 'Bagé', 23);
INSERT INTO public.cidade VALUES (3880, 'Balneário Pinhal', 23);
INSERT INTO public.cidade VALUES (3881, 'Barão', 23);
INSERT INTO public.cidade VALUES (3882, 'Barão de Cotegipe', 23);
INSERT INTO public.cidade VALUES (3883, 'Barão do Triunfo', 23);
INSERT INTO public.cidade VALUES (3884, 'Barra do Guarita', 23);
INSERT INTO public.cidade VALUES (3885, 'Barra do Quaraí', 23);
INSERT INTO public.cidade VALUES (3886, 'Barra do Ribeiro', 23);
INSERT INTO public.cidade VALUES (3887, 'Barra do Rio Azul', 23);
INSERT INTO public.cidade VALUES (3888, 'Barra Funda', 23);
INSERT INTO public.cidade VALUES (3889, 'Barracão', 23);
INSERT INTO public.cidade VALUES (3890, 'Barros Cassal', 23);
INSERT INTO public.cidade VALUES (3891, 'Benjamin Constant do Sul', 23);
INSERT INTO public.cidade VALUES (3892, 'Bento Gonçalves', 23);
INSERT INTO public.cidade VALUES (3893, 'Boa Vista das Missões', 23);
INSERT INTO public.cidade VALUES (3894, 'Boa Vista do Buricá', 23);
INSERT INTO public.cidade VALUES (3895, 'Boa Vista do Cadeado', 23);
INSERT INTO public.cidade VALUES (3896, 'Boa Vista do Incra', 23);
INSERT INTO public.cidade VALUES (3897, 'Boa Vista do Sul', 23);
INSERT INTO public.cidade VALUES (3898, 'Bom Jesus', 23);
INSERT INTO public.cidade VALUES (3899, 'Bom Princípio', 23);
INSERT INTO public.cidade VALUES (3900, 'Bom Progresso', 23);
INSERT INTO public.cidade VALUES (3901, 'Bom Retiro do Sul', 23);
INSERT INTO public.cidade VALUES (3902, 'Boqueirão do Leão', 23);
INSERT INTO public.cidade VALUES (3903, 'Bossoroca', 23);
INSERT INTO public.cidade VALUES (3904, 'Bozano', 23);
INSERT INTO public.cidade VALUES (3905, 'Braga', 23);
INSERT INTO public.cidade VALUES (3906, 'Brochier', 23);
INSERT INTO public.cidade VALUES (3907, 'Butiá', 23);
INSERT INTO public.cidade VALUES (3908, 'Caçapava do Sul', 23);
INSERT INTO public.cidade VALUES (3909, 'Cacequi', 23);
INSERT INTO public.cidade VALUES (3910, 'Cachoeira do Sul', 23);
INSERT INTO public.cidade VALUES (3911, 'Cachoeirinha', 23);
INSERT INTO public.cidade VALUES (3912, 'Cacique Doble', 23);
INSERT INTO public.cidade VALUES (3913, 'Caibaté', 23);
INSERT INTO public.cidade VALUES (3914, 'Caiçara', 23);
INSERT INTO public.cidade VALUES (3915, 'Camaquã', 23);
INSERT INTO public.cidade VALUES (3916, 'Camargo', 23);
INSERT INTO public.cidade VALUES (3917, 'Cambará do Sul', 23);
INSERT INTO public.cidade VALUES (3918, 'Campestre da Serra', 23);
INSERT INTO public.cidade VALUES (3919, 'Campina das Missões', 23);
INSERT INTO public.cidade VALUES (3920, 'Campinas do Sul', 23);
INSERT INTO public.cidade VALUES (3921, 'Campo Bom', 23);
INSERT INTO public.cidade VALUES (3922, 'Campo Novo', 23);
INSERT INTO public.cidade VALUES (3923, 'Campos Borges', 23);
INSERT INTO public.cidade VALUES (3924, 'Candelária', 23);
INSERT INTO public.cidade VALUES (3925, 'Cândido Godói', 23);
INSERT INTO public.cidade VALUES (3926, 'Candiota', 23);
INSERT INTO public.cidade VALUES (3927, 'Canela', 23);
INSERT INTO public.cidade VALUES (3928, 'Canguçu', 23);
INSERT INTO public.cidade VALUES (3929, 'Canoas', 23);
INSERT INTO public.cidade VALUES (3930, 'Canudos do Vale', 23);
INSERT INTO public.cidade VALUES (3931, 'Capão Bonito do Sul', 23);
INSERT INTO public.cidade VALUES (3932, 'Capão da Canoa', 23);
INSERT INTO public.cidade VALUES (3933, 'Capão do Cipó', 23);
INSERT INTO public.cidade VALUES (3934, 'Capão do Leão', 23);
INSERT INTO public.cidade VALUES (3935, 'Capela de Santana', 23);
INSERT INTO public.cidade VALUES (3936, 'Capitão', 23);
INSERT INTO public.cidade VALUES (3937, 'Capivari do Sul', 23);
INSERT INTO public.cidade VALUES (3938, 'Caraá', 23);
INSERT INTO public.cidade VALUES (3939, 'Carazinho', 23);
INSERT INTO public.cidade VALUES (3940, 'Carlos Barbosa', 23);
INSERT INTO public.cidade VALUES (3941, 'Carlos Gomes', 23);
INSERT INTO public.cidade VALUES (3942, 'Casca', 23);
INSERT INTO public.cidade VALUES (3943, 'Caseiros', 23);
INSERT INTO public.cidade VALUES (3944, 'Catuípe', 23);
INSERT INTO public.cidade VALUES (3945, 'Caxias do Sul', 23);
INSERT INTO public.cidade VALUES (3946, 'Centenário', 23);
INSERT INTO public.cidade VALUES (3947, 'Cerrito', 23);
INSERT INTO public.cidade VALUES (3948, 'Cerro Branco', 23);
INSERT INTO public.cidade VALUES (3949, 'Cerro Grande', 23);
INSERT INTO public.cidade VALUES (3950, 'Cerro Grande do Sul', 23);
INSERT INTO public.cidade VALUES (3951, 'Cerro Largo', 23);
INSERT INTO public.cidade VALUES (3952, 'Chapada', 23);
INSERT INTO public.cidade VALUES (3953, 'Charqueadas', 23);
INSERT INTO public.cidade VALUES (3954, 'Charrua', 23);
INSERT INTO public.cidade VALUES (3955, 'Chiapetta', 23);
INSERT INTO public.cidade VALUES (3956, 'Chuí', 23);
INSERT INTO public.cidade VALUES (3957, 'Chuvisca', 23);
INSERT INTO public.cidade VALUES (3958, 'Cidreira', 23);
INSERT INTO public.cidade VALUES (3959, 'Ciríaco', 23);
INSERT INTO public.cidade VALUES (3960, 'Colinas', 23);
INSERT INTO public.cidade VALUES (3961, 'Colorado', 23);
INSERT INTO public.cidade VALUES (3962, 'Condor', 23);
INSERT INTO public.cidade VALUES (3963, 'Constantina', 23);
INSERT INTO public.cidade VALUES (3964, 'Coqueiro Baixo', 23);
INSERT INTO public.cidade VALUES (3965, 'Coqueiros do Sul', 23);
INSERT INTO public.cidade VALUES (3966, 'Coronel Barros', 23);
INSERT INTO public.cidade VALUES (3967, 'Coronel Bicaco', 23);
INSERT INTO public.cidade VALUES (3968, 'Coronel Pilar', 23);
INSERT INTO public.cidade VALUES (3969, 'Cotiporã', 23);
INSERT INTO public.cidade VALUES (3970, 'Coxilha', 23);
INSERT INTO public.cidade VALUES (3971, 'Crissiumal', 23);
INSERT INTO public.cidade VALUES (3972, 'Cristal', 23);
INSERT INTO public.cidade VALUES (3973, 'Cristal do Sul', 23);
INSERT INTO public.cidade VALUES (3974, 'Cruz Alta', 23);
INSERT INTO public.cidade VALUES (3975, 'Cruzaltense', 23);
INSERT INTO public.cidade VALUES (3976, 'Cruzeiro do Sul', 23);
INSERT INTO public.cidade VALUES (3977, 'David Canabarro', 23);
INSERT INTO public.cidade VALUES (3978, 'Derrubadas', 23);
INSERT INTO public.cidade VALUES (3979, 'Dezesseis de Novembro', 23);
INSERT INTO public.cidade VALUES (3980, 'Dilermando de Aguiar', 23);
INSERT INTO public.cidade VALUES (3981, 'Dois Irmãos', 23);
INSERT INTO public.cidade VALUES (3982, 'Dois Irmãos das Missões', 23);
INSERT INTO public.cidade VALUES (3983, 'Dois Lajeados', 23);
INSERT INTO public.cidade VALUES (3984, 'Dom Feliciano', 23);
INSERT INTO public.cidade VALUES (3985, 'Dom Pedrito', 23);
INSERT INTO public.cidade VALUES (3986, 'Dom Pedro de Alcântara', 23);
INSERT INTO public.cidade VALUES (3987, 'Dona Francisca', 23);
INSERT INTO public.cidade VALUES (3988, 'Doutor Maurício Cardoso', 23);
INSERT INTO public.cidade VALUES (3989, 'Doutor Ricardo', 23);
INSERT INTO public.cidade VALUES (3990, 'Eldorado do Sul', 23);
INSERT INTO public.cidade VALUES (3991, 'Encantado', 23);
INSERT INTO public.cidade VALUES (3992, 'Encruzilhada do Sul', 23);
INSERT INTO public.cidade VALUES (3993, 'Engenho Velho', 23);
INSERT INTO public.cidade VALUES (3994, 'Entre Rios do Sul', 23);
INSERT INTO public.cidade VALUES (3995, 'Entre-Ijuís', 23);
INSERT INTO public.cidade VALUES (3996, 'Erebango', 23);
INSERT INTO public.cidade VALUES (3997, 'Erechim', 23);
INSERT INTO public.cidade VALUES (3998, 'Ernestina', 23);
INSERT INTO public.cidade VALUES (3999, 'Erval Grande', 23);
INSERT INTO public.cidade VALUES (4000, 'Erval Seco', 23);
INSERT INTO public.cidade VALUES (4001, 'Esmeralda', 23);
INSERT INTO public.cidade VALUES (4002, 'Esperança do Sul', 23);
INSERT INTO public.cidade VALUES (4003, 'Espumoso', 23);
INSERT INTO public.cidade VALUES (4004, 'Estação', 23);
INSERT INTO public.cidade VALUES (4005, 'Estância Velha', 23);
INSERT INTO public.cidade VALUES (4006, 'Esteio', 23);
INSERT INTO public.cidade VALUES (4007, 'Estrela', 23);
INSERT INTO public.cidade VALUES (4008, 'Estrela Velha', 23);
INSERT INTO public.cidade VALUES (4009, 'Eugênio de Castro', 23);
INSERT INTO public.cidade VALUES (4010, 'Fagundes Varela', 23);
INSERT INTO public.cidade VALUES (4011, 'Farroupilha', 23);
INSERT INTO public.cidade VALUES (4012, 'Faxinal do Soturno', 23);
INSERT INTO public.cidade VALUES (4013, 'Faxinalzinho', 23);
INSERT INTO public.cidade VALUES (4014, 'Fazenda Vilanova', 23);
INSERT INTO public.cidade VALUES (4015, 'Feliz', 23);
INSERT INTO public.cidade VALUES (4016, 'Flores da Cunha', 23);
INSERT INTO public.cidade VALUES (4017, 'Floriano Peixoto', 23);
INSERT INTO public.cidade VALUES (4018, 'Fontoura Xavier', 23);
INSERT INTO public.cidade VALUES (4019, 'Formigueiro', 23);
INSERT INTO public.cidade VALUES (4020, 'Forquetinha', 23);
INSERT INTO public.cidade VALUES (4021, 'Fortaleza dos Valos', 23);
INSERT INTO public.cidade VALUES (4022, 'Frederico Westphalen', 23);
INSERT INTO public.cidade VALUES (4023, 'Garibaldi', 23);
INSERT INTO public.cidade VALUES (4024, 'Garruchos', 23);
INSERT INTO public.cidade VALUES (4025, 'Gaurama', 23);
INSERT INTO public.cidade VALUES (4026, 'General Câmara', 23);
INSERT INTO public.cidade VALUES (4027, 'Gentil', 23);
INSERT INTO public.cidade VALUES (4028, 'Getúlio Vargas', 23);
INSERT INTO public.cidade VALUES (4029, 'Giruá', 23);
INSERT INTO public.cidade VALUES (4030, 'Glorinha', 23);
INSERT INTO public.cidade VALUES (4031, 'Gramado', 23);
INSERT INTO public.cidade VALUES (4032, 'Gramado dos Loureiros', 23);
INSERT INTO public.cidade VALUES (4033, 'Gramado Xavier', 23);
INSERT INTO public.cidade VALUES (4034, 'Gravataí', 23);
INSERT INTO public.cidade VALUES (4035, 'Guabiju', 23);
INSERT INTO public.cidade VALUES (4036, 'Guaíba', 23);
INSERT INTO public.cidade VALUES (4037, 'Guaporé', 23);
INSERT INTO public.cidade VALUES (4038, 'Guarani das Missões', 23);
INSERT INTO public.cidade VALUES (4039, 'Harmonia', 23);
INSERT INTO public.cidade VALUES (4040, 'Herval', 23);
INSERT INTO public.cidade VALUES (4041, 'Herveiras', 23);
INSERT INTO public.cidade VALUES (4042, 'Horizontina', 23);
INSERT INTO public.cidade VALUES (4043, 'Hulha Negra', 23);
INSERT INTO public.cidade VALUES (4044, 'Humaitá', 23);
INSERT INTO public.cidade VALUES (4045, 'Ibarama', 23);
INSERT INTO public.cidade VALUES (4046, 'Ibiaçá', 23);
INSERT INTO public.cidade VALUES (4047, 'Ibiraiaras', 23);
INSERT INTO public.cidade VALUES (4048, 'Ibirapuitã', 23);
INSERT INTO public.cidade VALUES (4049, 'Ibirubá', 23);
INSERT INTO public.cidade VALUES (4050, 'Igrejinha', 23);
INSERT INTO public.cidade VALUES (4051, 'Ijuí', 23);
INSERT INTO public.cidade VALUES (4052, 'Ilópolis', 23);
INSERT INTO public.cidade VALUES (4053, 'Imbé', 23);
INSERT INTO public.cidade VALUES (4054, 'Imigrante', 23);
INSERT INTO public.cidade VALUES (4055, 'Independência', 23);
INSERT INTO public.cidade VALUES (4056, 'Inhacorá', 23);
INSERT INTO public.cidade VALUES (4057, 'Ipê', 23);
INSERT INTO public.cidade VALUES (4058, 'Ipiranga do Sul', 23);
INSERT INTO public.cidade VALUES (4059, 'Iraí', 23);
INSERT INTO public.cidade VALUES (4060, 'Itaara', 23);
INSERT INTO public.cidade VALUES (4061, 'Itacurubi', 23);
INSERT INTO public.cidade VALUES (4062, 'Itapuca', 23);
INSERT INTO public.cidade VALUES (4063, 'Itaqui', 23);
INSERT INTO public.cidade VALUES (4064, 'Itati', 23);
INSERT INTO public.cidade VALUES (4065, 'Itatiba do Sul', 23);
INSERT INTO public.cidade VALUES (4066, 'Ivorá', 23);
INSERT INTO public.cidade VALUES (4067, 'Ivoti', 23);
INSERT INTO public.cidade VALUES (4068, 'Jaboticaba', 23);
INSERT INTO public.cidade VALUES (4069, 'Jacuizinho', 23);
INSERT INTO public.cidade VALUES (4070, 'Jacutinga', 23);
INSERT INTO public.cidade VALUES (4071, 'Jaguarão', 23);
INSERT INTO public.cidade VALUES (4072, 'Jaguari', 23);
INSERT INTO public.cidade VALUES (4073, 'Jaquirana', 23);
INSERT INTO public.cidade VALUES (4074, 'Jari', 23);
INSERT INTO public.cidade VALUES (4075, 'Jóia', 23);
INSERT INTO public.cidade VALUES (4076, 'Júlio de Castilhos', 23);
INSERT INTO public.cidade VALUES (4077, 'Lagoa Bonita do Sul', 23);
INSERT INTO public.cidade VALUES (4078, 'Lagoa dos Três Cantos', 23);
INSERT INTO public.cidade VALUES (4079, 'Lagoa Vermelha', 23);
INSERT INTO public.cidade VALUES (4080, 'Lagoão', 23);
INSERT INTO public.cidade VALUES (4081, 'Lajeado', 23);
INSERT INTO public.cidade VALUES (4082, 'Lajeado do Bugre', 23);
INSERT INTO public.cidade VALUES (4083, 'Lavras do Sul', 23);
INSERT INTO public.cidade VALUES (4084, 'Liberato Salzano', 23);
INSERT INTO public.cidade VALUES (4085, 'Lindolfo Collor', 23);
INSERT INTO public.cidade VALUES (4086, 'Linha Nova', 23);
INSERT INTO public.cidade VALUES (4087, 'Maçambara', 23);
INSERT INTO public.cidade VALUES (4088, 'Machadinho', 23);
INSERT INTO public.cidade VALUES (4089, 'Mampituba', 23);
INSERT INTO public.cidade VALUES (4090, 'Manoel Viana', 23);
INSERT INTO public.cidade VALUES (4091, 'Maquiné', 23);
INSERT INTO public.cidade VALUES (4092, 'Maratá', 23);
INSERT INTO public.cidade VALUES (4093, 'Marau', 23);
INSERT INTO public.cidade VALUES (4094, 'Marcelino Ramos', 23);
INSERT INTO public.cidade VALUES (4095, 'Mariana Pimentel', 23);
INSERT INTO public.cidade VALUES (4096, 'Mariano Moro', 23);
INSERT INTO public.cidade VALUES (4097, 'Marques de Souza', 23);
INSERT INTO public.cidade VALUES (4098, 'Mata', 23);
INSERT INTO public.cidade VALUES (4099, 'Mato Castelhano', 23);
INSERT INTO public.cidade VALUES (4100, 'Mato Leitão', 23);
INSERT INTO public.cidade VALUES (4101, 'Mato Queimado', 23);
INSERT INTO public.cidade VALUES (4102, 'Maximiliano de Almeida', 23);
INSERT INTO public.cidade VALUES (4103, 'Minas do Leão', 23);
INSERT INTO public.cidade VALUES (4104, 'Miraguaí', 23);
INSERT INTO public.cidade VALUES (4105, 'Montauri', 23);
INSERT INTO public.cidade VALUES (4106, 'Monte Alegre dos Campos', 23);
INSERT INTO public.cidade VALUES (4107, 'Monte Belo do Sul', 23);
INSERT INTO public.cidade VALUES (4108, 'Montenegro', 23);
INSERT INTO public.cidade VALUES (4109, 'Mormaço', 23);
INSERT INTO public.cidade VALUES (4110, 'Morrinhos do Sul', 23);
INSERT INTO public.cidade VALUES (4111, 'Morro Redondo', 23);
INSERT INTO public.cidade VALUES (4112, 'Morro Reuter', 23);
INSERT INTO public.cidade VALUES (4113, 'Mostardas', 23);
INSERT INTO public.cidade VALUES (4114, 'Muçum', 23);
INSERT INTO public.cidade VALUES (4115, 'Muitos Capões', 23);
INSERT INTO public.cidade VALUES (4116, 'Muliterno', 23);
INSERT INTO public.cidade VALUES (4117, 'Não-Me-Toque', 23);
INSERT INTO public.cidade VALUES (4118, 'Nicolau Vergueiro', 23);
INSERT INTO public.cidade VALUES (4119, 'Nonoai', 23);
INSERT INTO public.cidade VALUES (4120, 'Nova Alvorada', 23);
INSERT INTO public.cidade VALUES (4121, 'Nova Araçá', 23);
INSERT INTO public.cidade VALUES (4122, 'Nova Bassano', 23);
INSERT INTO public.cidade VALUES (4123, 'Nova Boa Vista', 23);
INSERT INTO public.cidade VALUES (4124, 'Nova Bréscia', 23);
INSERT INTO public.cidade VALUES (4125, 'Nova Candelária', 23);
INSERT INTO public.cidade VALUES (4126, 'Nova Esperança do Sul', 23);
INSERT INTO public.cidade VALUES (4127, 'Nova Hartz', 23);
INSERT INTO public.cidade VALUES (4128, 'Nova Pádua', 23);
INSERT INTO public.cidade VALUES (4129, 'Nova Palma', 23);
INSERT INTO public.cidade VALUES (4130, 'Nova Petrópolis', 23);
INSERT INTO public.cidade VALUES (4131, 'Nova Prata', 23);
INSERT INTO public.cidade VALUES (4132, 'Nova Ramada', 23);
INSERT INTO public.cidade VALUES (4133, 'Nova Roma do Sul', 23);
INSERT INTO public.cidade VALUES (4134, 'Nova Santa Rita', 23);
INSERT INTO public.cidade VALUES (4135, 'Novo Barreiro', 23);
INSERT INTO public.cidade VALUES (4136, 'Novo Cabrais', 23);
INSERT INTO public.cidade VALUES (4137, 'Novo Hamburgo', 23);
INSERT INTO public.cidade VALUES (4138, 'Novo Machado', 23);
INSERT INTO public.cidade VALUES (4139, 'Novo Tiradentes', 23);
INSERT INTO public.cidade VALUES (4140, 'Novo Xingu', 23);
INSERT INTO public.cidade VALUES (4141, 'Osório', 23);
INSERT INTO public.cidade VALUES (4142, 'Paim Filho', 23);
INSERT INTO public.cidade VALUES (4143, 'Palmares do Sul', 23);
INSERT INTO public.cidade VALUES (4144, 'Palmeira das Missões', 23);
INSERT INTO public.cidade VALUES (4145, 'Palmitinho', 23);
INSERT INTO public.cidade VALUES (4146, 'Panambi', 23);
INSERT INTO public.cidade VALUES (4147, 'Pantano Grande', 23);
INSERT INTO public.cidade VALUES (4148, 'Paraí', 23);
INSERT INTO public.cidade VALUES (4149, 'Paraíso do Sul', 23);
INSERT INTO public.cidade VALUES (4150, 'Pareci Novo', 23);
INSERT INTO public.cidade VALUES (4151, 'Parobé', 23);
INSERT INTO public.cidade VALUES (4152, 'Passa Sete', 23);
INSERT INTO public.cidade VALUES (4153, 'Passo do Sobrado', 23);
INSERT INTO public.cidade VALUES (4154, 'Passo Fundo', 23);
INSERT INTO public.cidade VALUES (4155, 'Paulo Bento', 23);
INSERT INTO public.cidade VALUES (4156, 'Paverama', 23);
INSERT INTO public.cidade VALUES (4157, 'Pedras Altas', 23);
INSERT INTO public.cidade VALUES (4158, 'Pedro Osório', 23);
INSERT INTO public.cidade VALUES (4159, 'Pejuçara', 23);
INSERT INTO public.cidade VALUES (4160, 'Pelotas', 23);
INSERT INTO public.cidade VALUES (4161, 'Picada Café', 23);
INSERT INTO public.cidade VALUES (4162, 'Pinhal', 23);
INSERT INTO public.cidade VALUES (4163, 'Pinhal da Serra', 23);
INSERT INTO public.cidade VALUES (4164, 'Pinhal Grande', 23);
INSERT INTO public.cidade VALUES (4165, 'Pinheirinho do Vale', 23);
INSERT INTO public.cidade VALUES (4166, 'Pinheiro Machado', 23);
INSERT INTO public.cidade VALUES (4167, 'Pirapó', 23);
INSERT INTO public.cidade VALUES (4168, 'Piratini', 23);
INSERT INTO public.cidade VALUES (4169, 'Planalto', 23);
INSERT INTO public.cidade VALUES (4170, 'Poço das Antas', 23);
INSERT INTO public.cidade VALUES (4171, 'Pontão', 23);
INSERT INTO public.cidade VALUES (4172, 'Ponte Preta', 23);
INSERT INTO public.cidade VALUES (4173, 'Portão', 23);
INSERT INTO public.cidade VALUES (4174, 'Porto Alegre', 23);
INSERT INTO public.cidade VALUES (4175, 'Porto Lucena', 23);
INSERT INTO public.cidade VALUES (4176, 'Porto Mauá', 23);
INSERT INTO public.cidade VALUES (4177, 'Porto Vera Cruz', 23);
INSERT INTO public.cidade VALUES (4178, 'Porto Xavier', 23);
INSERT INTO public.cidade VALUES (4179, 'Pouso Novo', 23);
INSERT INTO public.cidade VALUES (4180, 'Presidente Lucena', 23);
INSERT INTO public.cidade VALUES (4181, 'Progresso', 23);
INSERT INTO public.cidade VALUES (4182, 'Protásio Alves', 23);
INSERT INTO public.cidade VALUES (4183, 'Putinga', 23);
INSERT INTO public.cidade VALUES (4184, 'Quaraí', 23);
INSERT INTO public.cidade VALUES (4185, 'Quatro Irmãos', 23);
INSERT INTO public.cidade VALUES (4186, 'Quevedos', 23);
INSERT INTO public.cidade VALUES (4187, 'Quinze de Novembro', 23);
INSERT INTO public.cidade VALUES (4188, 'Redentora', 23);
INSERT INTO public.cidade VALUES (4189, 'Relvado', 23);
INSERT INTO public.cidade VALUES (4190, 'Restinga Seca', 23);
INSERT INTO public.cidade VALUES (4191, 'Rio dos Índios', 23);
INSERT INTO public.cidade VALUES (4192, 'Rio Grande', 23);
INSERT INTO public.cidade VALUES (4193, 'Rio Pardo', 23);
INSERT INTO public.cidade VALUES (4194, 'Riozinho', 23);
INSERT INTO public.cidade VALUES (4195, 'Roca Sales', 23);
INSERT INTO public.cidade VALUES (4196, 'Rodeio Bonito', 23);
INSERT INTO public.cidade VALUES (4197, 'Rolador', 23);
INSERT INTO public.cidade VALUES (4198, 'Rolante', 23);
INSERT INTO public.cidade VALUES (4199, 'Ronda Alta', 23);
INSERT INTO public.cidade VALUES (4200, 'Rondinha', 23);
INSERT INTO public.cidade VALUES (4201, 'Roque Gonzales', 23);
INSERT INTO public.cidade VALUES (4202, 'Rosário do Sul', 23);
INSERT INTO public.cidade VALUES (4203, 'Sagrada Família', 23);
INSERT INTO public.cidade VALUES (4204, 'Saldanha Marinho', 23);
INSERT INTO public.cidade VALUES (4205, 'Salto do Jacuí', 23);
INSERT INTO public.cidade VALUES (4206, 'Salvador das Missões', 23);
INSERT INTO public.cidade VALUES (4207, 'Salvador do Sul', 23);
INSERT INTO public.cidade VALUES (4208, 'Sananduva', 23);
INSERT INTO public.cidade VALUES (4209, 'Santa Bárbara do Sul', 23);
INSERT INTO public.cidade VALUES (4210, 'Santa Cecília do Sul', 23);
INSERT INTO public.cidade VALUES (4211, 'Santa Clara do Sul', 23);
INSERT INTO public.cidade VALUES (4212, 'Santa Cruz do Sul', 23);
INSERT INTO public.cidade VALUES (4213, 'Santa Margarida do Sul', 23);
INSERT INTO public.cidade VALUES (4214, 'Santa Maria', 23);
INSERT INTO public.cidade VALUES (4215, 'Santa Maria do Herval', 23);
INSERT INTO public.cidade VALUES (4216, 'Santa Rosa', 23);
INSERT INTO public.cidade VALUES (4217, 'Santa Tereza', 23);
INSERT INTO public.cidade VALUES (4218, 'Santa Vitória do Palmar', 23);
INSERT INTO public.cidade VALUES (4219, 'Santana da Boa Vista', 23);
INSERT INTO public.cidade VALUES (4220, 'Santana do Livramento', 23);
INSERT INTO public.cidade VALUES (4221, 'Santiago', 23);
INSERT INTO public.cidade VALUES (4222, 'Santo Ângelo', 23);
INSERT INTO public.cidade VALUES (4223, 'Santo Antônio da Patrulha', 23);
INSERT INTO public.cidade VALUES (4224, 'Santo Antônio das Missões', 23);
INSERT INTO public.cidade VALUES (4225, 'Santo Antônio do Palma', 23);
INSERT INTO public.cidade VALUES (4226, 'Santo Antônio do Planalto', 23);
INSERT INTO public.cidade VALUES (4227, 'Santo Augusto', 23);
INSERT INTO public.cidade VALUES (4228, 'Santo Cristo', 23);
INSERT INTO public.cidade VALUES (4229, 'Santo Expedito do Sul', 23);
INSERT INTO public.cidade VALUES (4230, 'São Borja', 23);
INSERT INTO public.cidade VALUES (4231, 'São Domingos do Sul', 23);
INSERT INTO public.cidade VALUES (4232, 'São Francisco de Assis', 23);
INSERT INTO public.cidade VALUES (4233, 'São Francisco de Paula', 23);
INSERT INTO public.cidade VALUES (4234, 'São Gabriel', 23);
INSERT INTO public.cidade VALUES (4235, 'São Jerônimo', 23);
INSERT INTO public.cidade VALUES (4236, 'São João da Urtiga', 23);
INSERT INTO public.cidade VALUES (4237, 'São João do Polêsine', 23);
INSERT INTO public.cidade VALUES (4238, 'São Jorge', 23);
INSERT INTO public.cidade VALUES (4239, 'São José das Missões', 23);
INSERT INTO public.cidade VALUES (4240, 'São José do Herval', 23);
INSERT INTO public.cidade VALUES (4241, 'São José do Hortêncio', 23);
INSERT INTO public.cidade VALUES (4242, 'São José do Inhacorá', 23);
INSERT INTO public.cidade VALUES (4243, 'São José do Norte', 23);
INSERT INTO public.cidade VALUES (4244, 'São José do Ouro', 23);
INSERT INTO public.cidade VALUES (4245, 'São José do Sul', 23);
INSERT INTO public.cidade VALUES (4246, 'São José dos Ausentes', 23);
INSERT INTO public.cidade VALUES (4247, 'São Leopoldo', 23);
INSERT INTO public.cidade VALUES (4248, 'São Lourenço do Sul', 23);
INSERT INTO public.cidade VALUES (4249, 'São Luiz Gonzaga', 23);
INSERT INTO public.cidade VALUES (4250, 'São Marcos', 23);
INSERT INTO public.cidade VALUES (4251, 'São Martinho', 23);
INSERT INTO public.cidade VALUES (4252, 'São Martinho da Serra', 23);
INSERT INTO public.cidade VALUES (4253, 'São Miguel das Missões', 23);
INSERT INTO public.cidade VALUES (4254, 'São Nicolau', 23);
INSERT INTO public.cidade VALUES (4255, 'São Paulo das Missões', 23);
INSERT INTO public.cidade VALUES (4256, 'São Pedro da Serra', 23);
INSERT INTO public.cidade VALUES (4257, 'São Pedro das Missões', 23);
INSERT INTO public.cidade VALUES (4258, 'São Pedro do Butiá', 23);
INSERT INTO public.cidade VALUES (4259, 'São Pedro do Sul', 23);
INSERT INTO public.cidade VALUES (4260, 'São Sebastião do Caí', 23);
INSERT INTO public.cidade VALUES (4261, 'São Sepé', 23);
INSERT INTO public.cidade VALUES (4262, 'São Valentim', 23);
INSERT INTO public.cidade VALUES (4263, 'São Valentim do Sul', 23);
INSERT INTO public.cidade VALUES (4264, 'São Valério do Sul', 23);
INSERT INTO public.cidade VALUES (4265, 'São Vendelino', 23);
INSERT INTO public.cidade VALUES (4266, 'São Vicente do Sul', 23);
INSERT INTO public.cidade VALUES (4267, 'Sapiranga', 23);
INSERT INTO public.cidade VALUES (4268, 'Sapucaia do Sul', 23);
INSERT INTO public.cidade VALUES (4269, 'Sarandi', 23);
INSERT INTO public.cidade VALUES (4270, 'Seberi', 23);
INSERT INTO public.cidade VALUES (4271, 'Sede Nova', 23);
INSERT INTO public.cidade VALUES (4272, 'Segredo', 23);
INSERT INTO public.cidade VALUES (4273, 'Selbach', 23);
INSERT INTO public.cidade VALUES (4274, 'Senador Salgado Filho', 23);
INSERT INTO public.cidade VALUES (4275, 'Sentinela do Sul', 23);
INSERT INTO public.cidade VALUES (4276, 'Serafina Corrêa', 23);
INSERT INTO public.cidade VALUES (4277, 'Sério', 23);
INSERT INTO public.cidade VALUES (4278, 'Sertão', 23);
INSERT INTO public.cidade VALUES (4279, 'Sertão Santana', 23);
INSERT INTO public.cidade VALUES (4280, 'Sete de Setembro', 23);
INSERT INTO public.cidade VALUES (4281, 'Severiano de Almeida', 23);
INSERT INTO public.cidade VALUES (4282, 'Silveira Martins', 23);
INSERT INTO public.cidade VALUES (4283, 'Sinimbu', 23);
INSERT INTO public.cidade VALUES (4284, 'Sobradinho', 23);
INSERT INTO public.cidade VALUES (4285, 'Soledade', 23);
INSERT INTO public.cidade VALUES (4286, 'Tabaí', 23);
INSERT INTO public.cidade VALUES (4287, 'Tapejara', 23);
INSERT INTO public.cidade VALUES (4288, 'Tapera', 23);
INSERT INTO public.cidade VALUES (4289, 'Tapes', 23);
INSERT INTO public.cidade VALUES (4290, 'Taquara', 23);
INSERT INTO public.cidade VALUES (4291, 'Taquari', 23);
INSERT INTO public.cidade VALUES (4292, 'Taquaruçu do Sul', 23);
INSERT INTO public.cidade VALUES (4293, 'Tavares', 23);
INSERT INTO public.cidade VALUES (4294, 'Tenente Portela', 23);
INSERT INTO public.cidade VALUES (4295, 'Terra de Areia', 23);
INSERT INTO public.cidade VALUES (4296, 'Teutônia', 23);
INSERT INTO public.cidade VALUES (4297, 'Tio Hugo', 23);
INSERT INTO public.cidade VALUES (4298, 'Tiradentes do Sul', 23);
INSERT INTO public.cidade VALUES (4299, 'Toropi', 23);
INSERT INTO public.cidade VALUES (4300, 'Torres', 23);
INSERT INTO public.cidade VALUES (4301, 'Tramandaí', 23);
INSERT INTO public.cidade VALUES (4302, 'Travesseiro', 23);
INSERT INTO public.cidade VALUES (4303, 'Três Arroios', 23);
INSERT INTO public.cidade VALUES (4304, 'Três Cachoeiras', 23);
INSERT INTO public.cidade VALUES (4305, 'Três Coroas', 23);
INSERT INTO public.cidade VALUES (4306, 'Três de Maio', 23);
INSERT INTO public.cidade VALUES (4307, 'Três Forquilhas', 23);
INSERT INTO public.cidade VALUES (4308, 'Três Palmeiras', 23);
INSERT INTO public.cidade VALUES (4309, 'Três Passos', 23);
INSERT INTO public.cidade VALUES (4310, 'Trindade do Sul', 23);
INSERT INTO public.cidade VALUES (4311, 'Triunfo', 23);
INSERT INTO public.cidade VALUES (4312, 'Tucunduva', 23);
INSERT INTO public.cidade VALUES (4313, 'Tunas', 23);
INSERT INTO public.cidade VALUES (4314, 'Tupanci do Sul', 23);
INSERT INTO public.cidade VALUES (4315, 'Tupanciretã', 23);
INSERT INTO public.cidade VALUES (4316, 'Tupandi', 23);
INSERT INTO public.cidade VALUES (4317, 'Tuparendi', 23);
INSERT INTO public.cidade VALUES (4318, 'Turuçu', 23);
INSERT INTO public.cidade VALUES (4319, 'Ubiretama', 23);
INSERT INTO public.cidade VALUES (4320, 'União da Serra', 23);
INSERT INTO public.cidade VALUES (4321, 'Unistalda', 23);
INSERT INTO public.cidade VALUES (4322, 'Uruguaiana', 23);
INSERT INTO public.cidade VALUES (4323, 'Vacaria', 23);
INSERT INTO public.cidade VALUES (4324, 'Vale do Sol', 23);
INSERT INTO public.cidade VALUES (4325, 'Vale Real', 23);
INSERT INTO public.cidade VALUES (4326, 'Vale Verde', 23);
INSERT INTO public.cidade VALUES (4327, 'Vanini', 23);
INSERT INTO public.cidade VALUES (4328, 'Venâncio Aires', 23);
INSERT INTO public.cidade VALUES (4329, 'Vera Cruz', 23);
INSERT INTO public.cidade VALUES (4330, 'Veranópolis', 23);
INSERT INTO public.cidade VALUES (4331, 'Vespasiano Correa', 23);
INSERT INTO public.cidade VALUES (4332, 'Viadutos', 23);
INSERT INTO public.cidade VALUES (4333, 'Viamão', 23);
INSERT INTO public.cidade VALUES (4334, 'Vicente Dutra', 23);
INSERT INTO public.cidade VALUES (4335, 'Victor Graeff', 23);
INSERT INTO public.cidade VALUES (4336, 'Vila Flores', 23);
INSERT INTO public.cidade VALUES (4337, 'Vila Lângaro', 23);
INSERT INTO public.cidade VALUES (4338, 'Vila Maria', 23);
INSERT INTO public.cidade VALUES (4339, 'Vila Nova do Sul', 23);
INSERT INTO public.cidade VALUES (4340, 'Vista Alegre', 23);
INSERT INTO public.cidade VALUES (4341, 'Vista Alegre do Prata', 23);
INSERT INTO public.cidade VALUES (4342, 'Vista Gaúcha', 23);
INSERT INTO public.cidade VALUES (4343, 'Vitória das Missões', 23);
INSERT INTO public.cidade VALUES (4344, 'Westfália', 23);
INSERT INTO public.cidade VALUES (4345, 'Xangri-lá', 23);
INSERT INTO public.cidade VALUES (4346, 'Alta Floresta d`Oeste', 21);
INSERT INTO public.cidade VALUES (4347, 'Alto Alegre dos Parecis', 21);
INSERT INTO public.cidade VALUES (4348, 'Alto Paraíso', 21);
INSERT INTO public.cidade VALUES (4349, 'Alvorada d`Oeste', 21);
INSERT INTO public.cidade VALUES (4350, 'Ariquemes', 21);
INSERT INTO public.cidade VALUES (4351, 'Buritis', 21);
INSERT INTO public.cidade VALUES (4352, 'Cabixi', 21);
INSERT INTO public.cidade VALUES (4353, 'Cacaulândia', 21);
INSERT INTO public.cidade VALUES (4354, 'Cacoal', 21);
INSERT INTO public.cidade VALUES (4355, 'Campo Novo de Rondônia', 21);
INSERT INTO public.cidade VALUES (4356, 'Candeias do Jamari', 21);
INSERT INTO public.cidade VALUES (4357, 'Castanheiras', 21);
INSERT INTO public.cidade VALUES (4358, 'Cerejeiras', 21);
INSERT INTO public.cidade VALUES (4359, 'Chupinguaia', 21);
INSERT INTO public.cidade VALUES (4360, 'Colorado do Oeste', 21);
INSERT INTO public.cidade VALUES (4361, 'Corumbiara', 21);
INSERT INTO public.cidade VALUES (4362, 'Costa Marques', 21);
INSERT INTO public.cidade VALUES (4363, 'Cujubim', 21);
INSERT INTO public.cidade VALUES (4364, 'Espigão d`Oeste', 21);
INSERT INTO public.cidade VALUES (4365, 'Governador Jorge Teixeira', 21);
INSERT INTO public.cidade VALUES (4366, 'Guajará-Mirim', 21);
INSERT INTO public.cidade VALUES (4367, 'Itapuã do Oeste', 21);
INSERT INTO public.cidade VALUES (4368, 'Jaru', 21);
INSERT INTO public.cidade VALUES (4369, 'Ji-Paraná', 21);
INSERT INTO public.cidade VALUES (4370, 'Machadinho d`Oeste', 21);
INSERT INTO public.cidade VALUES (4371, 'Ministro Andreazza', 21);
INSERT INTO public.cidade VALUES (4372, 'Mirante da Serra', 21);
INSERT INTO public.cidade VALUES (4373, 'Monte Negro', 21);
INSERT INTO public.cidade VALUES (4374, 'Nova Brasilândia d`Oeste', 21);
INSERT INTO public.cidade VALUES (4375, 'Nova Mamoré', 21);
INSERT INTO public.cidade VALUES (4376, 'Nova União', 21);
INSERT INTO public.cidade VALUES (4377, 'Novo Horizonte do Oeste', 21);
INSERT INTO public.cidade VALUES (4378, 'Ouro Preto do Oeste', 21);
INSERT INTO public.cidade VALUES (4379, 'Parecis', 21);
INSERT INTO public.cidade VALUES (4380, 'Pimenta Bueno', 21);
INSERT INTO public.cidade VALUES (4381, 'Pimenteiras do Oeste', 21);
INSERT INTO public.cidade VALUES (4382, 'Porto Velho', 21);
INSERT INTO public.cidade VALUES (4383, 'Presidente Médici', 21);
INSERT INTO public.cidade VALUES (4384, 'Primavera de Rondônia', 21);
INSERT INTO public.cidade VALUES (4385, 'Rio Crespo', 21);
INSERT INTO public.cidade VALUES (4386, 'Rolim de Moura', 21);
INSERT INTO public.cidade VALUES (4387, 'Santa Luzia d`Oeste', 21);
INSERT INTO public.cidade VALUES (4388, 'São Felipe d`Oeste', 21);
INSERT INTO public.cidade VALUES (4389, 'São Francisco do Guaporé', 21);
INSERT INTO public.cidade VALUES (4390, 'São Miguel do Guaporé', 21);
INSERT INTO public.cidade VALUES (4391, 'Seringueiras', 21);
INSERT INTO public.cidade VALUES (4392, 'Teixeirópolis', 21);
INSERT INTO public.cidade VALUES (4393, 'Theobroma', 21);
INSERT INTO public.cidade VALUES (4394, 'Urupá', 21);
INSERT INTO public.cidade VALUES (4395, 'Vale do Anari', 21);
INSERT INTO public.cidade VALUES (4396, 'Vale do Paraíso', 21);
INSERT INTO public.cidade VALUES (4397, 'Vilhena', 21);
INSERT INTO public.cidade VALUES (4398, 'Alto Alegre', 22);
INSERT INTO public.cidade VALUES (4399, 'Amajari', 22);
INSERT INTO public.cidade VALUES (4400, 'Boa Vista', 22);
INSERT INTO public.cidade VALUES (4401, 'Bonfim', 22);
INSERT INTO public.cidade VALUES (4402, 'Cantá', 22);
INSERT INTO public.cidade VALUES (4403, 'Caracaraí', 22);
INSERT INTO public.cidade VALUES (4404, 'Caroebe', 22);
INSERT INTO public.cidade VALUES (4405, 'Iracema', 22);
INSERT INTO public.cidade VALUES (4406, 'Mucajaí', 22);
INSERT INTO public.cidade VALUES (4407, 'Normandia', 22);
INSERT INTO public.cidade VALUES (4408, 'Pacaraima', 22);
INSERT INTO public.cidade VALUES (4409, 'Rorainópolis', 22);
INSERT INTO public.cidade VALUES (4410, 'São João da Baliza', 22);
INSERT INTO public.cidade VALUES (4411, 'São Luiz', 22);
INSERT INTO public.cidade VALUES (4412, 'Uiramutã', 22);
INSERT INTO public.cidade VALUES (4413, 'Abdon Batista', 24);
INSERT INTO public.cidade VALUES (4414, 'Abelardo Luz', 24);
INSERT INTO public.cidade VALUES (4415, 'Agrolândia', 24);
INSERT INTO public.cidade VALUES (4416, 'Agronômica', 24);
INSERT INTO public.cidade VALUES (4417, 'Água Doce', 24);
INSERT INTO public.cidade VALUES (4418, 'Águas de Chapecó', 24);
INSERT INTO public.cidade VALUES (4419, 'Águas Frias', 24);
INSERT INTO public.cidade VALUES (4420, 'Águas Mornas', 24);
INSERT INTO public.cidade VALUES (4421, 'Alfredo Wagner', 24);
INSERT INTO public.cidade VALUES (4422, 'Alto Bela Vista', 24);
INSERT INTO public.cidade VALUES (4423, 'Anchieta', 24);
INSERT INTO public.cidade VALUES (4424, 'Angelina', 24);
INSERT INTO public.cidade VALUES (4425, 'Anita Garibaldi', 24);
INSERT INTO public.cidade VALUES (4426, 'Anitápolis', 24);
INSERT INTO public.cidade VALUES (4427, 'Antônio Carlos', 24);
INSERT INTO public.cidade VALUES (4428, 'Apiúna', 24);
INSERT INTO public.cidade VALUES (4429, 'Arabutã', 24);
INSERT INTO public.cidade VALUES (4430, 'Araquari', 24);
INSERT INTO public.cidade VALUES (4431, 'Araranguá', 24);
INSERT INTO public.cidade VALUES (4432, 'Armazém', 24);
INSERT INTO public.cidade VALUES (4433, 'Arroio Trinta', 24);
INSERT INTO public.cidade VALUES (4434, 'Arvoredo', 24);
INSERT INTO public.cidade VALUES (4435, 'Ascurra', 24);
INSERT INTO public.cidade VALUES (4436, 'Atalanta', 24);
INSERT INTO public.cidade VALUES (4437, 'Aurora', 24);
INSERT INTO public.cidade VALUES (4438, 'Balneário Arroio do Silva', 24);
INSERT INTO public.cidade VALUES (4439, 'Balneário Barra do Sul', 24);
INSERT INTO public.cidade VALUES (4440, 'Balneário Camboriú', 24);
INSERT INTO public.cidade VALUES (4441, 'Balneário Gaivota', 24);
INSERT INTO public.cidade VALUES (4442, 'Bandeirante', 24);
INSERT INTO public.cidade VALUES (4443, 'Barra Bonita', 24);
INSERT INTO public.cidade VALUES (4444, 'Barra Velha', 24);
INSERT INTO public.cidade VALUES (4445, 'Bela Vista do Toldo', 24);
INSERT INTO public.cidade VALUES (4446, 'Belmonte', 24);
INSERT INTO public.cidade VALUES (4447, 'Benedito Novo', 24);
INSERT INTO public.cidade VALUES (4448, 'Biguaçu', 24);
INSERT INTO public.cidade VALUES (4449, 'Blumenau', 24);
INSERT INTO public.cidade VALUES (4450, 'Bocaina do Sul', 24);
INSERT INTO public.cidade VALUES (4451, 'Bom Jardim da Serra', 24);
INSERT INTO public.cidade VALUES (4452, 'Bom Jesus', 24);
INSERT INTO public.cidade VALUES (4453, 'Bom Jesus do Oeste', 24);
INSERT INTO public.cidade VALUES (4454, 'Bom Retiro', 24);
INSERT INTO public.cidade VALUES (4455, 'Bombinhas', 24);
INSERT INTO public.cidade VALUES (4456, 'Botuverá', 24);
INSERT INTO public.cidade VALUES (4457, 'Braço do Norte', 24);
INSERT INTO public.cidade VALUES (4458, 'Braço do Trombudo', 24);
INSERT INTO public.cidade VALUES (4459, 'Brunópolis', 24);
INSERT INTO public.cidade VALUES (4460, 'Brusque', 24);
INSERT INTO public.cidade VALUES (4461, 'Caçador', 24);
INSERT INTO public.cidade VALUES (4462, 'Caibi', 24);
INSERT INTO public.cidade VALUES (4463, 'Calmon', 24);
INSERT INTO public.cidade VALUES (4464, 'Camboriú', 24);
INSERT INTO public.cidade VALUES (4465, 'Campo Alegre', 24);
INSERT INTO public.cidade VALUES (4466, 'Campo Belo do Sul', 24);
INSERT INTO public.cidade VALUES (4467, 'Campo Erê', 24);
INSERT INTO public.cidade VALUES (4468, 'Campos Novos', 24);
INSERT INTO public.cidade VALUES (4469, 'Canelinha', 24);
INSERT INTO public.cidade VALUES (4470, 'Canoinhas', 24);
INSERT INTO public.cidade VALUES (4471, 'Capão Alto', 24);
INSERT INTO public.cidade VALUES (4472, 'Capinzal', 24);
INSERT INTO public.cidade VALUES (4473, 'Capivari de Baixo', 24);
INSERT INTO public.cidade VALUES (4474, 'Catanduvas', 24);
INSERT INTO public.cidade VALUES (4475, 'Caxambu do Sul', 24);
INSERT INTO public.cidade VALUES (4476, 'Celso Ramos', 24);
INSERT INTO public.cidade VALUES (4477, 'Cerro Negro', 24);
INSERT INTO public.cidade VALUES (4478, 'Chapadão do Lageado', 24);
INSERT INTO public.cidade VALUES (4479, 'Chapecó', 24);
INSERT INTO public.cidade VALUES (4480, 'Cocal do Sul', 24);
INSERT INTO public.cidade VALUES (4481, 'Concórdia', 24);
INSERT INTO public.cidade VALUES (4482, 'Cordilheira Alta', 24);
INSERT INTO public.cidade VALUES (4483, 'Coronel Freitas', 24);
INSERT INTO public.cidade VALUES (4484, 'Coronel Martins', 24);
INSERT INTO public.cidade VALUES (4485, 'Correia Pinto', 24);
INSERT INTO public.cidade VALUES (4486, 'Corupá', 24);
INSERT INTO public.cidade VALUES (4487, 'Criciúma', 24);
INSERT INTO public.cidade VALUES (4488, 'Cunha Porã', 24);
INSERT INTO public.cidade VALUES (4489, 'Cunhataí', 24);
INSERT INTO public.cidade VALUES (4490, 'Curitibanos', 24);
INSERT INTO public.cidade VALUES (4491, 'Descanso', 24);
INSERT INTO public.cidade VALUES (4492, 'Dionísio Cerqueira', 24);
INSERT INTO public.cidade VALUES (4493, 'Dona Emma', 24);
INSERT INTO public.cidade VALUES (4494, 'Doutor Pedrinho', 24);
INSERT INTO public.cidade VALUES (4495, 'Entre Rios', 24);
INSERT INTO public.cidade VALUES (4496, 'Ermo', 24);
INSERT INTO public.cidade VALUES (4497, 'Erval Velho', 24);
INSERT INTO public.cidade VALUES (4498, 'Faxinal dos Guedes', 24);
INSERT INTO public.cidade VALUES (4499, 'Flor do Sertão', 24);
INSERT INTO public.cidade VALUES (4500, 'Florianópolis', 24);
INSERT INTO public.cidade VALUES (4501, 'Formosa do Sul', 24);
INSERT INTO public.cidade VALUES (4502, 'Forquilhinha', 24);
INSERT INTO public.cidade VALUES (4503, 'Fraiburgo', 24);
INSERT INTO public.cidade VALUES (4504, 'Frei Rogério', 24);
INSERT INTO public.cidade VALUES (4505, 'Galvão', 24);
INSERT INTO public.cidade VALUES (4506, 'Garopaba', 24);
INSERT INTO public.cidade VALUES (4507, 'Garuva', 24);
INSERT INTO public.cidade VALUES (4508, 'Gaspar', 24);
INSERT INTO public.cidade VALUES (4509, 'Governador Celso Ramos', 24);
INSERT INTO public.cidade VALUES (4510, 'Grão Pará', 24);
INSERT INTO public.cidade VALUES (4511, 'Gravatal', 24);
INSERT INTO public.cidade VALUES (4512, 'Guabiruba', 24);
INSERT INTO public.cidade VALUES (4513, 'Guaraciaba', 24);
INSERT INTO public.cidade VALUES (4514, 'Guaramirim', 24);
INSERT INTO public.cidade VALUES (4515, 'Guarujá do Sul', 24);
INSERT INTO public.cidade VALUES (4516, 'Guatambú', 24);
INSERT INTO public.cidade VALUES (4517, 'Herval d`Oeste', 24);
INSERT INTO public.cidade VALUES (4518, 'Ibiam', 24);
INSERT INTO public.cidade VALUES (4519, 'Ibicaré', 24);
INSERT INTO public.cidade VALUES (4520, 'Ibirama', 24);
INSERT INTO public.cidade VALUES (4521, 'Içara', 24);
INSERT INTO public.cidade VALUES (4522, 'Ilhota', 24);
INSERT INTO public.cidade VALUES (4523, 'Imaruí', 24);
INSERT INTO public.cidade VALUES (4524, 'Imbituba', 24);
INSERT INTO public.cidade VALUES (4525, 'Imbuia', 24);
INSERT INTO public.cidade VALUES (4526, 'Indaial', 24);
INSERT INTO public.cidade VALUES (4527, 'Iomerê', 24);
INSERT INTO public.cidade VALUES (4528, 'Ipira', 24);
INSERT INTO public.cidade VALUES (4529, 'Iporã do Oeste', 24);
INSERT INTO public.cidade VALUES (4530, 'Ipuaçu', 24);
INSERT INTO public.cidade VALUES (4531, 'Ipumirim', 24);
INSERT INTO public.cidade VALUES (4532, 'Iraceminha', 24);
INSERT INTO public.cidade VALUES (4533, 'Irani', 24);
INSERT INTO public.cidade VALUES (4534, 'Irati', 24);
INSERT INTO public.cidade VALUES (4535, 'Irineópolis', 24);
INSERT INTO public.cidade VALUES (4536, 'Itá', 24);
INSERT INTO public.cidade VALUES (4537, 'Itaiópolis', 24);
INSERT INTO public.cidade VALUES (4538, 'Itajaí', 24);
INSERT INTO public.cidade VALUES (4539, 'Itapema', 24);
INSERT INTO public.cidade VALUES (4540, 'Itapiranga', 24);
INSERT INTO public.cidade VALUES (4541, 'Itapoá', 24);
INSERT INTO public.cidade VALUES (4542, 'Ituporanga', 24);
INSERT INTO public.cidade VALUES (4543, 'Jaborá', 24);
INSERT INTO public.cidade VALUES (4544, 'Jacinto Machado', 24);
INSERT INTO public.cidade VALUES (4545, 'Jaguaruna', 24);
INSERT INTO public.cidade VALUES (4546, 'Jaraguá do Sul', 24);
INSERT INTO public.cidade VALUES (4547, 'Jardinópolis', 24);
INSERT INTO public.cidade VALUES (4548, 'Joaçaba', 24);
INSERT INTO public.cidade VALUES (4549, 'Joinville', 24);
INSERT INTO public.cidade VALUES (4550, 'José Boiteux', 24);
INSERT INTO public.cidade VALUES (4551, 'Jupiá', 24);
INSERT INTO public.cidade VALUES (4552, 'Lacerdópolis', 24);
INSERT INTO public.cidade VALUES (4553, 'Lages', 24);
INSERT INTO public.cidade VALUES (4554, 'Laguna', 24);
INSERT INTO public.cidade VALUES (4555, 'Lajeado Grande', 24);
INSERT INTO public.cidade VALUES (4556, 'Laurentino', 24);
INSERT INTO public.cidade VALUES (4557, 'Lauro Muller', 24);
INSERT INTO public.cidade VALUES (4558, 'Lebon Régis', 24);
INSERT INTO public.cidade VALUES (4559, 'Leoberto Leal', 24);
INSERT INTO public.cidade VALUES (4560, 'Lindóia do Sul', 24);
INSERT INTO public.cidade VALUES (4561, 'Lontras', 24);
INSERT INTO public.cidade VALUES (4562, 'Luiz Alves', 24);
INSERT INTO public.cidade VALUES (4563, 'Luzerna', 24);
INSERT INTO public.cidade VALUES (4564, 'Macieira', 24);
INSERT INTO public.cidade VALUES (4565, 'Mafra', 24);
INSERT INTO public.cidade VALUES (4566, 'Major Gercino', 24);
INSERT INTO public.cidade VALUES (4567, 'Major Vieira', 24);
INSERT INTO public.cidade VALUES (4568, 'Maracajá', 24);
INSERT INTO public.cidade VALUES (4569, 'Maravilha', 24);
INSERT INTO public.cidade VALUES (4570, 'Marema', 24);
INSERT INTO public.cidade VALUES (4571, 'Massaranduba', 24);
INSERT INTO public.cidade VALUES (4572, 'Matos Costa', 24);
INSERT INTO public.cidade VALUES (4573, 'Meleiro', 24);
INSERT INTO public.cidade VALUES (4574, 'Mirim Doce', 24);
INSERT INTO public.cidade VALUES (4575, 'Modelo', 24);
INSERT INTO public.cidade VALUES (4576, 'Mondaí', 24);
INSERT INTO public.cidade VALUES (4577, 'Monte Carlo', 24);
INSERT INTO public.cidade VALUES (4578, 'Monte Castelo', 24);
INSERT INTO public.cidade VALUES (4579, 'Morro da Fumaça', 24);
INSERT INTO public.cidade VALUES (4580, 'Morro Grande', 24);
INSERT INTO public.cidade VALUES (4581, 'Navegantes', 24);
INSERT INTO public.cidade VALUES (4582, 'Nova Erechim', 24);
INSERT INTO public.cidade VALUES (4583, 'Nova Itaberaba', 24);
INSERT INTO public.cidade VALUES (4584, 'Nova Trento', 24);
INSERT INTO public.cidade VALUES (4585, 'Nova Veneza', 24);
INSERT INTO public.cidade VALUES (4586, 'Novo Horizonte', 24);
INSERT INTO public.cidade VALUES (4587, 'Orleans', 24);
INSERT INTO public.cidade VALUES (4588, 'Otacílio Costa', 24);
INSERT INTO public.cidade VALUES (4589, 'Ouro', 24);
INSERT INTO public.cidade VALUES (4590, 'Ouro Verde', 24);
INSERT INTO public.cidade VALUES (4591, 'Paial', 24);
INSERT INTO public.cidade VALUES (4592, 'Painel', 24);
INSERT INTO public.cidade VALUES (4593, 'Palhoça', 24);
INSERT INTO public.cidade VALUES (4594, 'Palma Sola', 24);
INSERT INTO public.cidade VALUES (4595, 'Palmeira', 24);
INSERT INTO public.cidade VALUES (4596, 'Palmitos', 24);
INSERT INTO public.cidade VALUES (4597, 'Papanduva', 24);
INSERT INTO public.cidade VALUES (4598, 'Paraíso', 24);
INSERT INTO public.cidade VALUES (4599, 'Passo de Torres', 24);
INSERT INTO public.cidade VALUES (4600, 'Passos Maia', 24);
INSERT INTO public.cidade VALUES (4601, 'Paulo Lopes', 24);
INSERT INTO public.cidade VALUES (4602, 'Pedras Grandes', 24);
INSERT INTO public.cidade VALUES (4603, 'Penha', 24);
INSERT INTO public.cidade VALUES (4604, 'Peritiba', 24);
INSERT INTO public.cidade VALUES (4605, 'Petrolândia', 24);
INSERT INTO public.cidade VALUES (4606, 'Balneário Piçarras', 24);
INSERT INTO public.cidade VALUES (4607, 'Pinhalzinho', 24);
INSERT INTO public.cidade VALUES (4608, 'Pinheiro Preto', 24);
INSERT INTO public.cidade VALUES (4609, 'Piratuba', 24);
INSERT INTO public.cidade VALUES (4610, 'Planalto Alegre', 24);
INSERT INTO public.cidade VALUES (4611, 'Pomerode', 24);
INSERT INTO public.cidade VALUES (4612, 'Ponte Alta', 24);
INSERT INTO public.cidade VALUES (4613, 'Ponte Alta do Norte', 24);
INSERT INTO public.cidade VALUES (4614, 'Ponte Serrada', 24);
INSERT INTO public.cidade VALUES (4615, 'Porto Belo', 24);
INSERT INTO public.cidade VALUES (4616, 'Porto União', 24);
INSERT INTO public.cidade VALUES (4617, 'Pouso Redondo', 24);
INSERT INTO public.cidade VALUES (4618, 'Praia Grande', 24);
INSERT INTO public.cidade VALUES (4620, 'Presidente Getúlio', 24);
INSERT INTO public.cidade VALUES (4621, 'Presidente Nereu', 24);
INSERT INTO public.cidade VALUES (4622, 'Princesa', 24);
INSERT INTO public.cidade VALUES (4623, 'Quilombo', 24);
INSERT INTO public.cidade VALUES (4624, 'Rancho Queimado', 24);
INSERT INTO public.cidade VALUES (4625, 'Rio das Antas', 24);
INSERT INTO public.cidade VALUES (4626, 'Rio do Campo', 24);
INSERT INTO public.cidade VALUES (4627, 'Rio do Oeste', 24);
INSERT INTO public.cidade VALUES (4628, 'Rio do Sul', 24);
INSERT INTO public.cidade VALUES (4629, 'Rio dos Cedros', 24);
INSERT INTO public.cidade VALUES (4630, 'Rio Fortuna', 24);
INSERT INTO public.cidade VALUES (4631, 'Rio Negrinho', 24);
INSERT INTO public.cidade VALUES (4632, 'Rio Rufino', 24);
INSERT INTO public.cidade VALUES (4633, 'Riqueza', 24);
INSERT INTO public.cidade VALUES (4634, 'Rodeio', 24);
INSERT INTO public.cidade VALUES (4635, 'Romelândia', 24);
INSERT INTO public.cidade VALUES (4636, 'Salete', 24);
INSERT INTO public.cidade VALUES (4637, 'Saltinho', 24);
INSERT INTO public.cidade VALUES (4638, 'Salto Veloso', 24);
INSERT INTO public.cidade VALUES (4639, 'Sangão', 24);
INSERT INTO public.cidade VALUES (4640, 'Santa Cecília', 24);
INSERT INTO public.cidade VALUES (4641, 'Santa Helena', 24);
INSERT INTO public.cidade VALUES (4642, 'Santa Rosa de Lima', 24);
INSERT INTO public.cidade VALUES (4643, 'Santa Rosa do Sul', 24);
INSERT INTO public.cidade VALUES (4644, 'Santa Terezinha', 24);
INSERT INTO public.cidade VALUES (4645, 'Santa Terezinha do Progresso', 24);
INSERT INTO public.cidade VALUES (4646, 'Santiago do Sul', 24);
INSERT INTO public.cidade VALUES (4647, 'Santo Amaro da Imperatriz', 24);
INSERT INTO public.cidade VALUES (4648, 'São Bento do Sul', 24);
INSERT INTO public.cidade VALUES (4649, 'São Bernardino', 24);
INSERT INTO public.cidade VALUES (4650, 'São Bonifácio', 24);
INSERT INTO public.cidade VALUES (4651, 'São Carlos', 24);
INSERT INTO public.cidade VALUES (4652, 'São Cristovão do Sul', 24);
INSERT INTO public.cidade VALUES (4653, 'São Domingos', 24);
INSERT INTO public.cidade VALUES (4654, 'São Francisco do Sul', 24);
INSERT INTO public.cidade VALUES (4655, 'São João Batista', 24);
INSERT INTO public.cidade VALUES (4656, 'São João do Itaperiú', 24);
INSERT INTO public.cidade VALUES (4657, 'São João do Oeste', 24);
INSERT INTO public.cidade VALUES (4658, 'São João do Sul', 24);
INSERT INTO public.cidade VALUES (4659, 'São Joaquim', 24);
INSERT INTO public.cidade VALUES (4660, 'São José', 24);
INSERT INTO public.cidade VALUES (4661, 'São José do Cedro', 24);
INSERT INTO public.cidade VALUES (4662, 'São José do Cerrito', 24);
INSERT INTO public.cidade VALUES (4663, 'São Lourenço do Oeste', 24);
INSERT INTO public.cidade VALUES (4664, 'São Ludgero', 24);
INSERT INTO public.cidade VALUES (4665, 'São Martinho', 24);
INSERT INTO public.cidade VALUES (4666, 'São Miguel da Boa Vista', 24);
INSERT INTO public.cidade VALUES (4667, 'São Miguel do Oeste', 24);
INSERT INTO public.cidade VALUES (4668, 'São Pedro de Alcântara', 24);
INSERT INTO public.cidade VALUES (4669, 'Saudades', 24);
INSERT INTO public.cidade VALUES (4670, 'Schroeder', 24);
INSERT INTO public.cidade VALUES (4671, 'Seara', 24);
INSERT INTO public.cidade VALUES (4672, 'Serra Alta', 24);
INSERT INTO public.cidade VALUES (4673, 'Siderópolis', 24);
INSERT INTO public.cidade VALUES (4674, 'Sombrio', 24);
INSERT INTO public.cidade VALUES (4675, 'Sul Brasil', 24);
INSERT INTO public.cidade VALUES (4676, 'Taió', 24);
INSERT INTO public.cidade VALUES (4677, 'Tangará', 24);
INSERT INTO public.cidade VALUES (4678, 'Tigrinhos', 24);
INSERT INTO public.cidade VALUES (4679, 'Tijucas', 24);
INSERT INTO public.cidade VALUES (4680, 'Timbé do Sul', 24);
INSERT INTO public.cidade VALUES (4681, 'Timbó', 24);
INSERT INTO public.cidade VALUES (4682, 'Timbó Grande', 24);
INSERT INTO public.cidade VALUES (4683, 'Três Barras', 24);
INSERT INTO public.cidade VALUES (4684, 'Treviso', 24);
INSERT INTO public.cidade VALUES (4685, 'Treze de Maio', 24);
INSERT INTO public.cidade VALUES (4686, 'Treze Tílias', 24);
INSERT INTO public.cidade VALUES (4687, 'Trombudo Central', 24);
INSERT INTO public.cidade VALUES (4688, 'Tubarão', 24);
INSERT INTO public.cidade VALUES (4689, 'Tunápolis', 24);
INSERT INTO public.cidade VALUES (4690, 'Turvo', 24);
INSERT INTO public.cidade VALUES (4691, 'União do Oeste', 24);
INSERT INTO public.cidade VALUES (4692, 'Urubici', 24);
INSERT INTO public.cidade VALUES (4693, 'Urupema', 24);
INSERT INTO public.cidade VALUES (4694, 'Urussanga', 24);
INSERT INTO public.cidade VALUES (4695, 'Vargeão', 24);
INSERT INTO public.cidade VALUES (4696, 'Vargem', 24);
INSERT INTO public.cidade VALUES (4697, 'Vargem Bonita', 24);
INSERT INTO public.cidade VALUES (4698, 'Vidal Ramos', 24);
INSERT INTO public.cidade VALUES (4699, 'Videira', 24);
INSERT INTO public.cidade VALUES (4700, 'Vitor Meireles', 24);
INSERT INTO public.cidade VALUES (4701, 'Witmarsum', 24);
INSERT INTO public.cidade VALUES (4702, 'Xanxerê', 24);
INSERT INTO public.cidade VALUES (4703, 'Xavantina', 24);
INSERT INTO public.cidade VALUES (4704, 'Xaxim', 24);
INSERT INTO public.cidade VALUES (4705, 'Zortéa', 24);
INSERT INTO public.cidade VALUES (4706, 'Adamantina', 26);
INSERT INTO public.cidade VALUES (4707, 'Adolfo', 26);
INSERT INTO public.cidade VALUES (4708, 'Aguaí', 26);
INSERT INTO public.cidade VALUES (4709, 'Águas da Prata', 26);
INSERT INTO public.cidade VALUES (4710, 'Águas de Lindóia', 26);
INSERT INTO public.cidade VALUES (4711, 'Águas de Santa Bárbara', 26);
INSERT INTO public.cidade VALUES (4712, 'Águas de São Pedro', 26);
INSERT INTO public.cidade VALUES (4713, 'Agudos', 26);
INSERT INTO public.cidade VALUES (4714, 'Alambari', 26);
INSERT INTO public.cidade VALUES (4715, 'Alfredo Marcondes', 26);
INSERT INTO public.cidade VALUES (4716, 'Altair', 26);
INSERT INTO public.cidade VALUES (4717, 'Altinópolis', 26);
INSERT INTO public.cidade VALUES (4718, 'Alto Alegre', 26);
INSERT INTO public.cidade VALUES (4719, 'Alumínio', 26);
INSERT INTO public.cidade VALUES (4720, 'Álvares Florence', 26);
INSERT INTO public.cidade VALUES (4721, 'Álvares Machado', 26);
INSERT INTO public.cidade VALUES (4722, 'Álvaro de Carvalho', 26);
INSERT INTO public.cidade VALUES (4723, 'Alvinlândia', 26);
INSERT INTO public.cidade VALUES (4724, 'Americana', 26);
INSERT INTO public.cidade VALUES (4725, 'Américo Brasiliense', 26);
INSERT INTO public.cidade VALUES (4726, 'Américo de Campos', 26);
INSERT INTO public.cidade VALUES (4727, 'Amparo', 26);
INSERT INTO public.cidade VALUES (4728, 'Analândia', 26);
INSERT INTO public.cidade VALUES (4729, 'Andradina', 26);
INSERT INTO public.cidade VALUES (4730, 'Angatuba', 26);
INSERT INTO public.cidade VALUES (4731, 'Anhembi', 26);
INSERT INTO public.cidade VALUES (4732, 'Anhumas', 26);
INSERT INTO public.cidade VALUES (4733, 'Aparecida', 26);
INSERT INTO public.cidade VALUES (4734, 'Aparecida d`Oeste', 26);
INSERT INTO public.cidade VALUES (4735, 'Apiaí', 26);
INSERT INTO public.cidade VALUES (4736, 'Araçariguama', 26);
INSERT INTO public.cidade VALUES (4737, 'Araçatuba', 26);
INSERT INTO public.cidade VALUES (4738, 'Araçoiaba da Serra', 26);
INSERT INTO public.cidade VALUES (4739, 'Aramina', 26);
INSERT INTO public.cidade VALUES (4740, 'Arandu', 26);
INSERT INTO public.cidade VALUES (4741, 'Arapeí', 26);
INSERT INTO public.cidade VALUES (4742, 'Araraquara', 26);
INSERT INTO public.cidade VALUES (4743, 'Araras', 26);
INSERT INTO public.cidade VALUES (4744, 'Arco-Íris', 26);
INSERT INTO public.cidade VALUES (4745, 'Arealva', 26);
INSERT INTO public.cidade VALUES (4746, 'Areias', 26);
INSERT INTO public.cidade VALUES (4747, 'Areiópolis', 26);
INSERT INTO public.cidade VALUES (4748, 'Ariranha', 26);
INSERT INTO public.cidade VALUES (4749, 'Artur Nogueira', 26);
INSERT INTO public.cidade VALUES (4750, 'Arujá', 26);
INSERT INTO public.cidade VALUES (4751, 'Aspásia', 26);
INSERT INTO public.cidade VALUES (4752, 'Assis', 26);
INSERT INTO public.cidade VALUES (4753, 'Atibaia', 26);
INSERT INTO public.cidade VALUES (4754, 'Auriflama', 26);
INSERT INTO public.cidade VALUES (4755, 'Avaí', 26);
INSERT INTO public.cidade VALUES (4756, 'Avanhandava', 26);
INSERT INTO public.cidade VALUES (4757, 'Avaré', 26);
INSERT INTO public.cidade VALUES (4758, 'Bady Bassitt', 26);
INSERT INTO public.cidade VALUES (4759, 'Balbinos', 26);
INSERT INTO public.cidade VALUES (4760, 'Bálsamo', 26);
INSERT INTO public.cidade VALUES (4761, 'Bananal', 26);
INSERT INTO public.cidade VALUES (4762, 'Barão de Antonina', 26);
INSERT INTO public.cidade VALUES (4763, 'Barbosa', 26);
INSERT INTO public.cidade VALUES (4764, 'Bariri', 26);
INSERT INTO public.cidade VALUES (4765, 'Barra Bonita', 26);
INSERT INTO public.cidade VALUES (4766, 'Barra do Chapéu', 26);
INSERT INTO public.cidade VALUES (4767, 'Barra do Turvo', 26);
INSERT INTO public.cidade VALUES (4768, 'Barretos', 26);
INSERT INTO public.cidade VALUES (4769, 'Barrinha', 26);
INSERT INTO public.cidade VALUES (4770, 'Barueri', 26);
INSERT INTO public.cidade VALUES (4771, 'Bastos', 26);
INSERT INTO public.cidade VALUES (4772, 'Batatais', 26);
INSERT INTO public.cidade VALUES (4773, 'Bauru', 26);
INSERT INTO public.cidade VALUES (4774, 'Bebedouro', 26);
INSERT INTO public.cidade VALUES (4775, 'Bento de Abreu', 26);
INSERT INTO public.cidade VALUES (4776, 'Bernardino de Campos', 26);
INSERT INTO public.cidade VALUES (4777, 'Bertioga', 26);
INSERT INTO public.cidade VALUES (4778, 'Bilac', 26);
INSERT INTO public.cidade VALUES (4779, 'Birigui', 26);
INSERT INTO public.cidade VALUES (4780, 'Biritiba-Mirim', 26);
INSERT INTO public.cidade VALUES (4781, 'Boa Esperança do Sul', 26);
INSERT INTO public.cidade VALUES (4782, 'Bocaina', 26);
INSERT INTO public.cidade VALUES (4783, 'Bofete', 26);
INSERT INTO public.cidade VALUES (4784, 'Boituva', 26);
INSERT INTO public.cidade VALUES (4785, 'Bom Jesus dos Perdões', 26);
INSERT INTO public.cidade VALUES (4786, 'Bom Sucesso de Itararé', 26);
INSERT INTO public.cidade VALUES (4787, 'Borá', 26);
INSERT INTO public.cidade VALUES (4788, 'Boracéia', 26);
INSERT INTO public.cidade VALUES (4789, 'Borborema', 26);
INSERT INTO public.cidade VALUES (4790, 'Borebi', 26);
INSERT INTO public.cidade VALUES (4791, 'Botucatu', 26);
INSERT INTO public.cidade VALUES (4792, 'Bragança Paulista', 26);
INSERT INTO public.cidade VALUES (4793, 'Braúna', 26);
INSERT INTO public.cidade VALUES (4794, 'Brejo Alegre', 26);
INSERT INTO public.cidade VALUES (4795, 'Brodowski', 26);
INSERT INTO public.cidade VALUES (4796, 'Brotas', 26);
INSERT INTO public.cidade VALUES (4797, 'Buri', 26);
INSERT INTO public.cidade VALUES (4798, 'Buritama', 26);
INSERT INTO public.cidade VALUES (4799, 'Buritizal', 26);
INSERT INTO public.cidade VALUES (4800, 'Cabrália Paulista', 26);
INSERT INTO public.cidade VALUES (4801, 'Cabreúva', 26);
INSERT INTO public.cidade VALUES (4802, 'Caçapava', 26);
INSERT INTO public.cidade VALUES (4803, 'Cachoeira Paulista', 26);
INSERT INTO public.cidade VALUES (4804, 'Caconde', 26);
INSERT INTO public.cidade VALUES (4805, 'Cafelândia', 26);
INSERT INTO public.cidade VALUES (4806, 'Caiabu', 26);
INSERT INTO public.cidade VALUES (4807, 'Caieiras', 26);
INSERT INTO public.cidade VALUES (4808, 'Caiuá', 26);
INSERT INTO public.cidade VALUES (4809, 'Cajamar', 26);
INSERT INTO public.cidade VALUES (4810, 'Cajati', 26);
INSERT INTO public.cidade VALUES (4811, 'Cajobi', 26);
INSERT INTO public.cidade VALUES (4812, 'Cajuru', 26);
INSERT INTO public.cidade VALUES (4813, 'Campina do Monte Alegre', 26);
INSERT INTO public.cidade VALUES (4814, 'Campinas', 26);
INSERT INTO public.cidade VALUES (4815, 'Campo Limpo Paulista', 26);
INSERT INTO public.cidade VALUES (4816, 'Campos do Jordão', 26);
INSERT INTO public.cidade VALUES (4817, 'Campos Novos Paulista', 26);
INSERT INTO public.cidade VALUES (4818, 'Cananéia', 26);
INSERT INTO public.cidade VALUES (4819, 'Canas', 26);
INSERT INTO public.cidade VALUES (4820, 'Cândido Mota', 26);
INSERT INTO public.cidade VALUES (4821, 'Cândido Rodrigues', 26);
INSERT INTO public.cidade VALUES (4822, 'Canitar', 26);
INSERT INTO public.cidade VALUES (4823, 'Capão Bonito', 26);
INSERT INTO public.cidade VALUES (4824, 'Capela do Alto', 26);
INSERT INTO public.cidade VALUES (4825, 'Capivari', 26);
INSERT INTO public.cidade VALUES (4826, 'Caraguatatuba', 26);
INSERT INTO public.cidade VALUES (4827, 'Carapicuíba', 26);
INSERT INTO public.cidade VALUES (4828, 'Cardoso', 26);
INSERT INTO public.cidade VALUES (4829, 'Casa Branca', 26);
INSERT INTO public.cidade VALUES (4830, 'Cássia dos Coqueiros', 26);
INSERT INTO public.cidade VALUES (4831, 'Castilho', 26);
INSERT INTO public.cidade VALUES (4832, 'Catanduva', 26);
INSERT INTO public.cidade VALUES (4833, 'Catiguá', 26);
INSERT INTO public.cidade VALUES (4834, 'Cedral', 26);
INSERT INTO public.cidade VALUES (4835, 'Cerqueira César', 26);
INSERT INTO public.cidade VALUES (4836, 'Cerquilho', 26);
INSERT INTO public.cidade VALUES (4837, 'Cesário Lange', 26);
INSERT INTO public.cidade VALUES (4838, 'Charqueada', 26);
INSERT INTO public.cidade VALUES (4839, 'Chavantes', 26);
INSERT INTO public.cidade VALUES (4840, 'Clementina', 26);
INSERT INTO public.cidade VALUES (4841, 'Colina', 26);
INSERT INTO public.cidade VALUES (4842, 'Colômbia', 26);
INSERT INTO public.cidade VALUES (4843, 'Conchal', 26);
INSERT INTO public.cidade VALUES (4844, 'Conchas', 26);
INSERT INTO public.cidade VALUES (4845, 'Cordeirópolis', 26);
INSERT INTO public.cidade VALUES (4846, 'Coroados', 26);
INSERT INTO public.cidade VALUES (4847, 'Coronel Macedo', 26);
INSERT INTO public.cidade VALUES (4848, 'Corumbataí', 26);
INSERT INTO public.cidade VALUES (4849, 'Cosmópolis', 26);
INSERT INTO public.cidade VALUES (4850, 'Cosmorama', 26);
INSERT INTO public.cidade VALUES (4851, 'Cotia', 26);
INSERT INTO public.cidade VALUES (4852, 'Cravinhos', 26);
INSERT INTO public.cidade VALUES (4853, 'Cristais Paulista', 26);
INSERT INTO public.cidade VALUES (4854, 'Cruzália', 26);
INSERT INTO public.cidade VALUES (4855, 'Cruzeiro', 26);
INSERT INTO public.cidade VALUES (4856, 'Cubatão', 26);
INSERT INTO public.cidade VALUES (4857, 'Cunha', 26);
INSERT INTO public.cidade VALUES (4858, 'Descalvado', 26);
INSERT INTO public.cidade VALUES (4859, 'Diadema', 26);
INSERT INTO public.cidade VALUES (4860, 'Dirce Reis', 26);
INSERT INTO public.cidade VALUES (4861, 'Divinolândia', 26);
INSERT INTO public.cidade VALUES (4862, 'Dobrada', 26);
INSERT INTO public.cidade VALUES (4863, 'Dois Córregos', 26);
INSERT INTO public.cidade VALUES (4864, 'Dolcinópolis', 26);
INSERT INTO public.cidade VALUES (4865, 'Dourado', 26);
INSERT INTO public.cidade VALUES (4866, 'Dracena', 26);
INSERT INTO public.cidade VALUES (4867, 'Duartina', 26);
INSERT INTO public.cidade VALUES (4868, 'Dumont', 26);
INSERT INTO public.cidade VALUES (4869, 'Echaporã', 26);
INSERT INTO public.cidade VALUES (4870, 'Eldorado', 26);
INSERT INTO public.cidade VALUES (4871, 'Elias Fausto', 26);
INSERT INTO public.cidade VALUES (4872, 'Elisiário', 26);
INSERT INTO public.cidade VALUES (4873, 'Embaúba', 26);
INSERT INTO public.cidade VALUES (4874, 'Embu', 26);
INSERT INTO public.cidade VALUES (4875, 'Embu-Guaçu', 26);
INSERT INTO public.cidade VALUES (4876, 'Emilianópolis', 26);
INSERT INTO public.cidade VALUES (4877, 'Engenheiro Coelho', 26);
INSERT INTO public.cidade VALUES (4878, 'Espírito Santo do Pinhal', 26);
INSERT INTO public.cidade VALUES (4879, 'Espírito Santo do Turvo', 26);
INSERT INTO public.cidade VALUES (4880, 'Estiva Gerbi', 26);
INSERT INTO public.cidade VALUES (4881, 'Estrela d`Oeste', 26);
INSERT INTO public.cidade VALUES (4882, 'Estrela do Norte', 26);
INSERT INTO public.cidade VALUES (4883, 'Euclides da Cunha Paulista', 26);
INSERT INTO public.cidade VALUES (4884, 'Fartura', 26);
INSERT INTO public.cidade VALUES (4885, 'Fernando Prestes', 26);
INSERT INTO public.cidade VALUES (4886, 'Fernandópolis', 26);
INSERT INTO public.cidade VALUES (4887, 'Fernão', 26);
INSERT INTO public.cidade VALUES (4888, 'Ferraz de Vasconcelos', 26);
INSERT INTO public.cidade VALUES (4889, 'Flora Rica', 26);
INSERT INTO public.cidade VALUES (4890, 'Floreal', 26);
INSERT INTO public.cidade VALUES (4891, 'Flórida Paulista', 26);
INSERT INTO public.cidade VALUES (4892, 'Florínia', 26);
INSERT INTO public.cidade VALUES (4893, 'Franca', 26);
INSERT INTO public.cidade VALUES (4894, 'Francisco Morato', 26);
INSERT INTO public.cidade VALUES (4895, 'Franco da Rocha', 26);
INSERT INTO public.cidade VALUES (4896, 'Gabriel Monteiro', 26);
INSERT INTO public.cidade VALUES (4897, 'Gália', 26);
INSERT INTO public.cidade VALUES (4898, 'Garça', 26);
INSERT INTO public.cidade VALUES (4899, 'Gastão Vidigal', 26);
INSERT INTO public.cidade VALUES (4900, 'Gavião Peixoto', 26);
INSERT INTO public.cidade VALUES (4901, 'General Salgado', 26);
INSERT INTO public.cidade VALUES (4902, 'Getulina', 26);
INSERT INTO public.cidade VALUES (4903, 'Glicério', 26);
INSERT INTO public.cidade VALUES (4904, 'Guaiçara', 26);
INSERT INTO public.cidade VALUES (4905, 'Guaimbê', 26);
INSERT INTO public.cidade VALUES (4906, 'Guaíra', 26);
INSERT INTO public.cidade VALUES (4907, 'Guapiaçu', 26);
INSERT INTO public.cidade VALUES (4908, 'Guapiara', 26);
INSERT INTO public.cidade VALUES (4909, 'Guará', 26);
INSERT INTO public.cidade VALUES (4910, 'Guaraçaí', 26);
INSERT INTO public.cidade VALUES (4911, 'Guaraci', 26);
INSERT INTO public.cidade VALUES (4912, 'Guarani d`Oeste', 26);
INSERT INTO public.cidade VALUES (4913, 'Guarantã', 26);
INSERT INTO public.cidade VALUES (4914, 'Guararapes', 26);
INSERT INTO public.cidade VALUES (4915, 'Guararema', 26);
INSERT INTO public.cidade VALUES (4916, 'Guaratinguetá', 26);
INSERT INTO public.cidade VALUES (4917, 'Guareí', 26);
INSERT INTO public.cidade VALUES (4918, 'Guariba', 26);
INSERT INTO public.cidade VALUES (4919, 'Guarujá', 26);
INSERT INTO public.cidade VALUES (4920, 'Guarulhos', 26);
INSERT INTO public.cidade VALUES (4921, 'Guatapará', 26);
INSERT INTO public.cidade VALUES (4922, 'Guzolândia', 26);
INSERT INTO public.cidade VALUES (4923, 'Herculândia', 26);
INSERT INTO public.cidade VALUES (4924, 'Holambra', 26);
INSERT INTO public.cidade VALUES (4925, 'Hortolândia', 26);
INSERT INTO public.cidade VALUES (4926, 'Iacanga', 26);
INSERT INTO public.cidade VALUES (4927, 'Iacri', 26);
INSERT INTO public.cidade VALUES (4928, 'Iaras', 26);
INSERT INTO public.cidade VALUES (4929, 'Ibaté', 26);
INSERT INTO public.cidade VALUES (4930, 'Ibirá', 26);
INSERT INTO public.cidade VALUES (4931, 'Ibirarema', 26);
INSERT INTO public.cidade VALUES (4932, 'Ibitinga', 26);
INSERT INTO public.cidade VALUES (4933, 'Ibiúna', 26);
INSERT INTO public.cidade VALUES (4934, 'Icém', 26);
INSERT INTO public.cidade VALUES (4935, 'Iepê', 26);
INSERT INTO public.cidade VALUES (4936, 'Igaraçu do Tietê', 26);
INSERT INTO public.cidade VALUES (4937, 'Igarapava', 26);
INSERT INTO public.cidade VALUES (4938, 'Igaratá', 26);
INSERT INTO public.cidade VALUES (4939, 'Iguape', 26);
INSERT INTO public.cidade VALUES (4940, 'Ilha Comprida', 26);
INSERT INTO public.cidade VALUES (4941, 'Ilha Solteira', 26);
INSERT INTO public.cidade VALUES (4942, 'Ilhabela', 26);
INSERT INTO public.cidade VALUES (4943, 'Indaiatuba', 26);
INSERT INTO public.cidade VALUES (4944, 'Indiana', 26);
INSERT INTO public.cidade VALUES (4945, 'Indiaporã', 26);
INSERT INTO public.cidade VALUES (4946, 'Inúbia Paulista', 26);
INSERT INTO public.cidade VALUES (4947, 'Ipaussu', 26);
INSERT INTO public.cidade VALUES (4948, 'Iperó', 26);
INSERT INTO public.cidade VALUES (4949, 'Ipeúna', 26);
INSERT INTO public.cidade VALUES (4950, 'Ipiguá', 26);
INSERT INTO public.cidade VALUES (4951, 'Iporanga', 26);
INSERT INTO public.cidade VALUES (4952, 'Ipuã', 26);
INSERT INTO public.cidade VALUES (4953, 'Iracemápolis', 26);
INSERT INTO public.cidade VALUES (4954, 'Irapuã', 26);
INSERT INTO public.cidade VALUES (4955, 'Irapuru', 26);
INSERT INTO public.cidade VALUES (4956, 'Itaberá', 26);
INSERT INTO public.cidade VALUES (4957, 'Itaí', 26);
INSERT INTO public.cidade VALUES (4958, 'Itajobi', 26);
INSERT INTO public.cidade VALUES (4959, 'Itaju', 26);
INSERT INTO public.cidade VALUES (4960, 'Itanhaém', 26);
INSERT INTO public.cidade VALUES (4961, 'Itaóca', 26);
INSERT INTO public.cidade VALUES (4962, 'Itapecerica da Serra', 26);
INSERT INTO public.cidade VALUES (4963, 'Itapetininga', 26);
INSERT INTO public.cidade VALUES (4964, 'Itapeva', 26);
INSERT INTO public.cidade VALUES (4965, 'Itapevi', 26);
INSERT INTO public.cidade VALUES (4966, 'Itapira', 26);
INSERT INTO public.cidade VALUES (4967, 'Itapirapuã Paulista', 26);
INSERT INTO public.cidade VALUES (4968, 'Itápolis', 26);
INSERT INTO public.cidade VALUES (4969, 'Itaporanga', 26);
INSERT INTO public.cidade VALUES (4970, 'Itapuí', 26);
INSERT INTO public.cidade VALUES (4971, 'Itapura', 26);
INSERT INTO public.cidade VALUES (4972, 'Itaquaquecetuba', 26);
INSERT INTO public.cidade VALUES (4973, 'Itararé', 26);
INSERT INTO public.cidade VALUES (4974, 'Itariri', 26);
INSERT INTO public.cidade VALUES (4975, 'Itatiba', 26);
INSERT INTO public.cidade VALUES (4976, 'Itatinga', 26);
INSERT INTO public.cidade VALUES (4977, 'Itirapina', 26);
INSERT INTO public.cidade VALUES (4978, 'Itirapuã', 26);
INSERT INTO public.cidade VALUES (4979, 'Itobi', 26);
INSERT INTO public.cidade VALUES (4980, 'Itu', 26);
INSERT INTO public.cidade VALUES (4981, 'Itupeva', 26);
INSERT INTO public.cidade VALUES (4982, 'Ituverava', 26);
INSERT INTO public.cidade VALUES (4983, 'Jaborandi', 26);
INSERT INTO public.cidade VALUES (4984, 'Jaboticabal', 26);
INSERT INTO public.cidade VALUES (4985, 'Jacareí', 26);
INSERT INTO public.cidade VALUES (4986, 'Jaci', 26);
INSERT INTO public.cidade VALUES (4987, 'Jacupiranga', 26);
INSERT INTO public.cidade VALUES (4988, 'Jaguariúna', 26);
INSERT INTO public.cidade VALUES (4989, 'Jales', 26);
INSERT INTO public.cidade VALUES (4990, 'Jambeiro', 26);
INSERT INTO public.cidade VALUES (4991, 'Jandira', 26);
INSERT INTO public.cidade VALUES (4992, 'Jardinópolis', 26);
INSERT INTO public.cidade VALUES (4993, 'Jarinu', 26);
INSERT INTO public.cidade VALUES (4994, 'Jaú', 26);
INSERT INTO public.cidade VALUES (4995, 'Jeriquara', 26);
INSERT INTO public.cidade VALUES (4996, 'Joanópolis', 26);
INSERT INTO public.cidade VALUES (4997, 'João Ramalho', 26);
INSERT INTO public.cidade VALUES (4998, 'José Bonifácio', 26);
INSERT INTO public.cidade VALUES (4999, 'Júlio Mesquita', 26);
INSERT INTO public.cidade VALUES (5000, 'Jumirim', 26);
INSERT INTO public.cidade VALUES (5001, 'Jundiaí', 26);
INSERT INTO public.cidade VALUES (5002, 'Junqueirópolis', 26);
INSERT INTO public.cidade VALUES (5003, 'Juquiá', 26);
INSERT INTO public.cidade VALUES (5004, 'Juquitiba', 26);
INSERT INTO public.cidade VALUES (5005, 'Lagoinha', 26);
INSERT INTO public.cidade VALUES (5006, 'Laranjal Paulista', 26);
INSERT INTO public.cidade VALUES (5007, 'Lavínia', 26);
INSERT INTO public.cidade VALUES (5008, 'Lavrinhas', 26);
INSERT INTO public.cidade VALUES (5009, 'Leme', 26);
INSERT INTO public.cidade VALUES (5010, 'Lençóis Paulista', 26);
INSERT INTO public.cidade VALUES (5011, 'Limeira', 26);
INSERT INTO public.cidade VALUES (5012, 'Lindóia', 26);
INSERT INTO public.cidade VALUES (5013, 'Lins', 26);
INSERT INTO public.cidade VALUES (5014, 'Lorena', 26);
INSERT INTO public.cidade VALUES (5015, 'Lourdes', 26);
INSERT INTO public.cidade VALUES (5016, 'Louveira', 26);
INSERT INTO public.cidade VALUES (5017, 'Lucélia', 26);
INSERT INTO public.cidade VALUES (5018, 'Lucianópolis', 26);
INSERT INTO public.cidade VALUES (5019, 'Luís Antônio', 26);
INSERT INTO public.cidade VALUES (5020, 'Luiziânia', 26);
INSERT INTO public.cidade VALUES (5021, 'Lupércio', 26);
INSERT INTO public.cidade VALUES (5022, 'Lutécia', 26);
INSERT INTO public.cidade VALUES (5023, 'Macatuba', 26);
INSERT INTO public.cidade VALUES (5024, 'Macaubal', 26);
INSERT INTO public.cidade VALUES (5025, 'Macedônia', 26);
INSERT INTO public.cidade VALUES (5026, 'Magda', 26);
INSERT INTO public.cidade VALUES (5027, 'Mairinque', 26);
INSERT INTO public.cidade VALUES (5028, 'Mairiporã', 26);
INSERT INTO public.cidade VALUES (5029, 'Manduri', 26);
INSERT INTO public.cidade VALUES (5030, 'Marabá Paulista', 26);
INSERT INTO public.cidade VALUES (5031, 'Maracaí', 26);
INSERT INTO public.cidade VALUES (5032, 'Marapoama', 26);
INSERT INTO public.cidade VALUES (5033, 'Mariápolis', 26);
INSERT INTO public.cidade VALUES (5034, 'Marília', 26);
INSERT INTO public.cidade VALUES (5035, 'Marinópolis', 26);
INSERT INTO public.cidade VALUES (5036, 'Martinópolis', 26);
INSERT INTO public.cidade VALUES (5037, 'Matão', 26);
INSERT INTO public.cidade VALUES (5038, 'Mauá', 26);
INSERT INTO public.cidade VALUES (5039, 'Mendonça', 26);
INSERT INTO public.cidade VALUES (5040, 'Meridiano', 26);
INSERT INTO public.cidade VALUES (5041, 'Mesópolis', 26);
INSERT INTO public.cidade VALUES (5042, 'Miguelópolis', 26);
INSERT INTO public.cidade VALUES (5043, 'Mineiros do Tietê', 26);
INSERT INTO public.cidade VALUES (5044, 'Mira Estrela', 26);
INSERT INTO public.cidade VALUES (5045, 'Miracatu', 26);
INSERT INTO public.cidade VALUES (5046, 'Mirandópolis', 26);
INSERT INTO public.cidade VALUES (5047, 'Mirante do Paranapanema', 26);
INSERT INTO public.cidade VALUES (5048, 'Mirassol', 26);
INSERT INTO public.cidade VALUES (5049, 'Mirassolândia', 26);
INSERT INTO public.cidade VALUES (5050, 'Mococa', 26);
INSERT INTO public.cidade VALUES (5051, 'Mogi das Cruzes', 26);
INSERT INTO public.cidade VALUES (5052, 'Mogi Guaçu', 26);
INSERT INTO public.cidade VALUES (5053, 'Mogi Mirim', 26);
INSERT INTO public.cidade VALUES (5054, 'Mombuca', 26);
INSERT INTO public.cidade VALUES (5055, 'Monções', 26);
INSERT INTO public.cidade VALUES (5056, 'Mongaguá', 26);
INSERT INTO public.cidade VALUES (5057, 'Monte Alegre do Sul', 26);
INSERT INTO public.cidade VALUES (5058, 'Monte Alto', 26);
INSERT INTO public.cidade VALUES (5059, 'Monte Aprazível', 26);
INSERT INTO public.cidade VALUES (5060, 'Monte Azul Paulista', 26);
INSERT INTO public.cidade VALUES (5061, 'Monte Castelo', 26);
INSERT INTO public.cidade VALUES (5062, 'Monte Mor', 26);
INSERT INTO public.cidade VALUES (5063, 'Monteiro Lobato', 26);
INSERT INTO public.cidade VALUES (5064, 'Morro Agudo', 26);
INSERT INTO public.cidade VALUES (5065, 'Morungaba', 26);
INSERT INTO public.cidade VALUES (5066, 'Motuca', 26);
INSERT INTO public.cidade VALUES (5067, 'Murutinga do Sul', 26);
INSERT INTO public.cidade VALUES (5068, 'Nantes', 26);
INSERT INTO public.cidade VALUES (5069, 'Narandiba', 26);
INSERT INTO public.cidade VALUES (5070, 'Natividade da Serra', 26);
INSERT INTO public.cidade VALUES (5071, 'Nazaré Paulista', 26);
INSERT INTO public.cidade VALUES (5072, 'Neves Paulista', 26);
INSERT INTO public.cidade VALUES (5073, 'Nhandeara', 26);
INSERT INTO public.cidade VALUES (5074, 'Nipoã', 26);
INSERT INTO public.cidade VALUES (5075, 'Nova Aliança', 26);
INSERT INTO public.cidade VALUES (5076, 'Nova Campina', 26);
INSERT INTO public.cidade VALUES (5077, 'Nova Canaã Paulista', 26);
INSERT INTO public.cidade VALUES (5078, 'Nova Castilho', 26);
INSERT INTO public.cidade VALUES (5079, 'Nova Europa', 26);
INSERT INTO public.cidade VALUES (5080, 'Nova Granada', 26);
INSERT INTO public.cidade VALUES (5081, 'Nova Guataporanga', 26);
INSERT INTO public.cidade VALUES (5082, 'Nova Independência', 26);
INSERT INTO public.cidade VALUES (5083, 'Nova Luzitânia', 26);
INSERT INTO public.cidade VALUES (5084, 'Nova Odessa', 26);
INSERT INTO public.cidade VALUES (5085, 'Novais', 26);
INSERT INTO public.cidade VALUES (5086, 'Novo Horizonte', 26);
INSERT INTO public.cidade VALUES (5087, 'Nuporanga', 26);
INSERT INTO public.cidade VALUES (5088, 'Ocauçu', 26);
INSERT INTO public.cidade VALUES (5089, 'Óleo', 26);
INSERT INTO public.cidade VALUES (5090, 'Olímpia', 26);
INSERT INTO public.cidade VALUES (5091, 'Onda Verde', 26);
INSERT INTO public.cidade VALUES (5092, 'Oriente', 26);
INSERT INTO public.cidade VALUES (5093, 'Orindiúva', 26);
INSERT INTO public.cidade VALUES (5094, 'Orlândia', 26);
INSERT INTO public.cidade VALUES (5095, 'Osasco', 26);
INSERT INTO public.cidade VALUES (5096, 'Oscar Bressane', 26);
INSERT INTO public.cidade VALUES (5097, 'Osvaldo Cruz', 26);
INSERT INTO public.cidade VALUES (5098, 'Ourinhos', 26);
INSERT INTO public.cidade VALUES (5099, 'Ouro Verde', 26);
INSERT INTO public.cidade VALUES (5100, 'Ouroeste', 26);
INSERT INTO public.cidade VALUES (5101, 'Pacaembu', 26);
INSERT INTO public.cidade VALUES (5102, 'Palestina', 26);
INSERT INTO public.cidade VALUES (5103, 'Palmares Paulista', 26);
INSERT INTO public.cidade VALUES (5104, 'Palmeira d`Oeste', 26);
INSERT INTO public.cidade VALUES (5105, 'Palmital', 26);
INSERT INTO public.cidade VALUES (5106, 'Panorama', 26);
INSERT INTO public.cidade VALUES (5107, 'Paraguaçu Paulista', 26);
INSERT INTO public.cidade VALUES (5108, 'Paraibuna', 26);
INSERT INTO public.cidade VALUES (5109, 'Paraíso', 26);
INSERT INTO public.cidade VALUES (5110, 'Paranapanema', 26);
INSERT INTO public.cidade VALUES (5111, 'Paranapuã', 26);
INSERT INTO public.cidade VALUES (5112, 'Parapuã', 26);
INSERT INTO public.cidade VALUES (5113, 'Pardinho', 26);
INSERT INTO public.cidade VALUES (5114, 'Pariquera-Açu', 26);
INSERT INTO public.cidade VALUES (5115, 'Parisi', 26);
INSERT INTO public.cidade VALUES (5116, 'Patrocínio Paulista', 26);
INSERT INTO public.cidade VALUES (5117, 'Paulicéia', 26);
INSERT INTO public.cidade VALUES (5118, 'Paulínia', 26);
INSERT INTO public.cidade VALUES (5119, 'Paulistânia', 26);
INSERT INTO public.cidade VALUES (5120, 'Paulo de Faria', 26);
INSERT INTO public.cidade VALUES (5121, 'Pederneiras', 26);
INSERT INTO public.cidade VALUES (5122, 'Pedra Bela', 26);
INSERT INTO public.cidade VALUES (5123, 'Pedranópolis', 26);
INSERT INTO public.cidade VALUES (5124, 'Pedregulho', 26);
INSERT INTO public.cidade VALUES (5125, 'Pedreira', 26);
INSERT INTO public.cidade VALUES (5126, 'Pedrinhas Paulista', 26);
INSERT INTO public.cidade VALUES (5127, 'Pedro de Toledo', 26);
INSERT INTO public.cidade VALUES (5128, 'Penápolis', 26);
INSERT INTO public.cidade VALUES (5129, 'Pereira Barreto', 26);
INSERT INTO public.cidade VALUES (5130, 'Pereiras', 26);
INSERT INTO public.cidade VALUES (5131, 'Peruíbe', 26);
INSERT INTO public.cidade VALUES (5132, 'Piacatu', 26);
INSERT INTO public.cidade VALUES (5133, 'Piedade', 26);
INSERT INTO public.cidade VALUES (5134, 'Pilar do Sul', 26);
INSERT INTO public.cidade VALUES (5135, 'Pindamonhangaba', 26);
INSERT INTO public.cidade VALUES (5136, 'Pindorama', 26);
INSERT INTO public.cidade VALUES (5137, 'Pinhalzinho', 26);
INSERT INTO public.cidade VALUES (5138, 'Piquerobi', 26);
INSERT INTO public.cidade VALUES (5139, 'Piquete', 26);
INSERT INTO public.cidade VALUES (5140, 'Piracaia', 26);
INSERT INTO public.cidade VALUES (5141, 'Piracicaba', 26);
INSERT INTO public.cidade VALUES (5142, 'Piraju', 26);
INSERT INTO public.cidade VALUES (5143, 'Pirajuí', 26);
INSERT INTO public.cidade VALUES (5144, 'Pirangi', 26);
INSERT INTO public.cidade VALUES (5145, 'Pirapora do Bom Jesus', 26);
INSERT INTO public.cidade VALUES (5146, 'Pirapozinho', 26);
INSERT INTO public.cidade VALUES (5147, 'Pirassununga', 26);
INSERT INTO public.cidade VALUES (5148, 'Piratininga', 26);
INSERT INTO public.cidade VALUES (5149, 'Pitangueiras', 26);
INSERT INTO public.cidade VALUES (5150, 'Planalto', 26);
INSERT INTO public.cidade VALUES (5151, 'Platina', 26);
INSERT INTO public.cidade VALUES (5152, 'Poá', 26);
INSERT INTO public.cidade VALUES (5153, 'Poloni', 26);
INSERT INTO public.cidade VALUES (5154, 'Pompéia', 26);
INSERT INTO public.cidade VALUES (5155, 'Pongaí', 26);
INSERT INTO public.cidade VALUES (5156, 'Pontal', 26);
INSERT INTO public.cidade VALUES (5157, 'Pontalinda', 26);
INSERT INTO public.cidade VALUES (5158, 'Pontes Gestal', 26);
INSERT INTO public.cidade VALUES (5159, 'Populina', 26);
INSERT INTO public.cidade VALUES (5160, 'Porangaba', 26);
INSERT INTO public.cidade VALUES (5161, 'Porto Feliz', 26);
INSERT INTO public.cidade VALUES (5162, 'Porto Ferreira', 26);
INSERT INTO public.cidade VALUES (5163, 'Potim', 26);
INSERT INTO public.cidade VALUES (5164, 'Potirendaba', 26);
INSERT INTO public.cidade VALUES (5165, 'Pracinha', 26);
INSERT INTO public.cidade VALUES (5166, 'Pradópolis', 26);
INSERT INTO public.cidade VALUES (5167, 'Praia Grande', 26);
INSERT INTO public.cidade VALUES (5168, 'Pratânia', 26);
INSERT INTO public.cidade VALUES (5169, 'Presidente Alves', 26);
INSERT INTO public.cidade VALUES (5170, 'Presidente Bernardes', 26);
INSERT INTO public.cidade VALUES (5171, 'Presidente Epitácio', 26);
INSERT INTO public.cidade VALUES (5172, 'Presidente Prudente', 26);
INSERT INTO public.cidade VALUES (5173, 'Presidente Venceslau', 26);
INSERT INTO public.cidade VALUES (5174, 'Promissão', 26);
INSERT INTO public.cidade VALUES (5175, 'Quadra', 26);
INSERT INTO public.cidade VALUES (5176, 'Quatá', 26);
INSERT INTO public.cidade VALUES (5177, 'Queiroz', 26);
INSERT INTO public.cidade VALUES (5178, 'Queluz', 26);
INSERT INTO public.cidade VALUES (5179, 'Quintana', 26);
INSERT INTO public.cidade VALUES (5180, 'Rafard', 26);
INSERT INTO public.cidade VALUES (5181, 'Rancharia', 26);
INSERT INTO public.cidade VALUES (5182, 'Redenção da Serra', 26);
INSERT INTO public.cidade VALUES (5183, 'Regente Feijó', 26);
INSERT INTO public.cidade VALUES (5184, 'Reginópolis', 26);
INSERT INTO public.cidade VALUES (5185, 'Registro', 26);
INSERT INTO public.cidade VALUES (5186, 'Restinga', 26);
INSERT INTO public.cidade VALUES (5187, 'Ribeira', 26);
INSERT INTO public.cidade VALUES (5188, 'Ribeirão Bonito', 26);
INSERT INTO public.cidade VALUES (5189, 'Ribeirão Branco', 26);
INSERT INTO public.cidade VALUES (5190, 'Ribeirão Corrente', 26);
INSERT INTO public.cidade VALUES (5191, 'Ribeirão do Sul', 26);
INSERT INTO public.cidade VALUES (5192, 'Ribeirão dos Índios', 26);
INSERT INTO public.cidade VALUES (5193, 'Ribeirão Grande', 26);
INSERT INTO public.cidade VALUES (5194, 'Ribeirão Pires', 26);
INSERT INTO public.cidade VALUES (5195, 'Ribeirão Preto', 26);
INSERT INTO public.cidade VALUES (5196, 'Rifaina', 26);
INSERT INTO public.cidade VALUES (5197, 'Rincão', 26);
INSERT INTO public.cidade VALUES (5198, 'Rinópolis', 26);
INSERT INTO public.cidade VALUES (5199, 'Rio Claro', 26);
INSERT INTO public.cidade VALUES (5200, 'Rio das Pedras', 26);
INSERT INTO public.cidade VALUES (5201, 'Rio Grande da Serra', 26);
INSERT INTO public.cidade VALUES (5202, 'Riolândia', 26);
INSERT INTO public.cidade VALUES (5203, 'Riversul', 26);
INSERT INTO public.cidade VALUES (5204, 'Rosana', 26);
INSERT INTO public.cidade VALUES (5205, 'Roseira', 26);
INSERT INTO public.cidade VALUES (5206, 'Rubiácea', 26);
INSERT INTO public.cidade VALUES (5207, 'Rubinéia', 26);
INSERT INTO public.cidade VALUES (5208, 'Sabino', 26);
INSERT INTO public.cidade VALUES (5209, 'Sagres', 26);
INSERT INTO public.cidade VALUES (5210, 'Sales', 26);
INSERT INTO public.cidade VALUES (5211, 'Sales Oliveira', 26);
INSERT INTO public.cidade VALUES (5212, 'Salesópolis', 26);
INSERT INTO public.cidade VALUES (5213, 'Salmourão', 26);
INSERT INTO public.cidade VALUES (5214, 'Saltinho', 26);
INSERT INTO public.cidade VALUES (5215, 'Salto', 26);
INSERT INTO public.cidade VALUES (5216, 'Salto de Pirapora', 26);
INSERT INTO public.cidade VALUES (5217, 'Salto Grande', 26);
INSERT INTO public.cidade VALUES (5218, 'Sandovalina', 26);
INSERT INTO public.cidade VALUES (5219, 'Santa Adélia', 26);
INSERT INTO public.cidade VALUES (5220, 'Santa Albertina', 26);
INSERT INTO public.cidade VALUES (5221, 'Santa Bárbara d`Oeste', 26);
INSERT INTO public.cidade VALUES (5222, 'Santa Branca', 26);
INSERT INTO public.cidade VALUES (5223, 'Santa Clara d`Oeste', 26);
INSERT INTO public.cidade VALUES (5224, 'Santa Cruz da Conceição', 26);
INSERT INTO public.cidade VALUES (5225, 'Santa Cruz da Esperança', 26);
INSERT INTO public.cidade VALUES (5226, 'Santa Cruz das Palmeiras', 26);
INSERT INTO public.cidade VALUES (5227, 'Santa Cruz do Rio Pardo', 26);
INSERT INTO public.cidade VALUES (5228, 'Santa Ernestina', 26);
INSERT INTO public.cidade VALUES (5229, 'Santa Fé do Sul', 26);
INSERT INTO public.cidade VALUES (5230, 'Santa Gertrudes', 26);
INSERT INTO public.cidade VALUES (5231, 'Santa Isabel', 26);
INSERT INTO public.cidade VALUES (5232, 'Santa Lúcia', 26);
INSERT INTO public.cidade VALUES (5233, 'Santa Maria da Serra', 26);
INSERT INTO public.cidade VALUES (5234, 'Santa Mercedes', 26);
INSERT INTO public.cidade VALUES (5235, 'Santa Rita d`Oeste', 26);
INSERT INTO public.cidade VALUES (5236, 'Santa Rita do Passa Quatro', 26);
INSERT INTO public.cidade VALUES (5237, 'Santa Rosa de Viterbo', 26);
INSERT INTO public.cidade VALUES (5238, 'Santa Salete', 26);
INSERT INTO public.cidade VALUES (5239, 'Santana da Ponte Pensa', 26);
INSERT INTO public.cidade VALUES (5240, 'Santana de Parnaíba', 26);
INSERT INTO public.cidade VALUES (5241, 'Santo Anastácio', 26);
INSERT INTO public.cidade VALUES (5242, 'Santo André', 26);
INSERT INTO public.cidade VALUES (5243, 'Santo Antônio da Alegria', 26);
INSERT INTO public.cidade VALUES (5244, 'Santo Antônio de Posse', 26);
INSERT INTO public.cidade VALUES (5245, 'Santo Antônio do Aracanguá', 26);
INSERT INTO public.cidade VALUES (5246, 'Santo Antônio do Jardim', 26);
INSERT INTO public.cidade VALUES (5247, 'Santo Antônio do Pinhal', 26);
INSERT INTO public.cidade VALUES (5248, 'Santo Expedito', 26);
INSERT INTO public.cidade VALUES (5249, 'Santópolis do Aguapeí', 26);
INSERT INTO public.cidade VALUES (5250, 'Santos', 26);
INSERT INTO public.cidade VALUES (5251, 'São Bento do Sapucaí', 26);
INSERT INTO public.cidade VALUES (5252, 'São Bernardo do Campo', 26);
INSERT INTO public.cidade VALUES (5253, 'São Caetano do Sul', 26);
INSERT INTO public.cidade VALUES (5254, 'São Carlos', 26);
INSERT INTO public.cidade VALUES (5255, 'São Francisco', 26);
INSERT INTO public.cidade VALUES (5256, 'São João da Boa Vista', 26);
INSERT INTO public.cidade VALUES (5257, 'São João das Duas Pontes', 26);
INSERT INTO public.cidade VALUES (5258, 'São João de Iracema', 26);
INSERT INTO public.cidade VALUES (5259, 'São João do Pau d`Alho', 26);
INSERT INTO public.cidade VALUES (5260, 'São Joaquim da Barra', 26);
INSERT INTO public.cidade VALUES (5261, 'São José da Bela Vista', 26);
INSERT INTO public.cidade VALUES (5262, 'São José do Barreiro', 26);
INSERT INTO public.cidade VALUES (5263, 'São José do Rio Pardo', 26);
INSERT INTO public.cidade VALUES (5264, 'São José do Rio Preto', 26);
INSERT INTO public.cidade VALUES (5265, 'São José dos Campos', 26);
INSERT INTO public.cidade VALUES (5266, 'São Lourenço da Serra', 26);
INSERT INTO public.cidade VALUES (5267, 'São Luís do Paraitinga', 26);
INSERT INTO public.cidade VALUES (5268, 'São Manuel', 26);
INSERT INTO public.cidade VALUES (5269, 'São Miguel Arcanjo', 26);
INSERT INTO public.cidade VALUES (5270, 'São Paulo', 26);
INSERT INTO public.cidade VALUES (5271, 'São Pedro', 26);
INSERT INTO public.cidade VALUES (5272, 'São Pedro do Turvo', 26);
INSERT INTO public.cidade VALUES (5273, 'São Roque', 26);
INSERT INTO public.cidade VALUES (5274, 'São Sebastião', 26);
INSERT INTO public.cidade VALUES (5275, 'São Sebastião da Grama', 26);
INSERT INTO public.cidade VALUES (5276, 'São Simão', 26);
INSERT INTO public.cidade VALUES (5277, 'São Vicente', 26);
INSERT INTO public.cidade VALUES (5278, 'Sarapuí', 26);
INSERT INTO public.cidade VALUES (5279, 'Sarutaiá', 26);
INSERT INTO public.cidade VALUES (5280, 'Sebastianópolis do Sul', 26);
INSERT INTO public.cidade VALUES (5281, 'Serra Azul', 26);
INSERT INTO public.cidade VALUES (5282, 'Serra Negra', 26);
INSERT INTO public.cidade VALUES (5283, 'Serrana', 26);
INSERT INTO public.cidade VALUES (5284, 'Sertãozinho', 26);
INSERT INTO public.cidade VALUES (5285, 'Sete Barras', 26);
INSERT INTO public.cidade VALUES (5286, 'Severínia', 26);
INSERT INTO public.cidade VALUES (5287, 'Silveiras', 26);
INSERT INTO public.cidade VALUES (5288, 'Socorro', 26);
INSERT INTO public.cidade VALUES (5289, 'Sorocaba', 26);
INSERT INTO public.cidade VALUES (5290, 'Sud Mennucci', 26);
INSERT INTO public.cidade VALUES (5291, 'Sumaré', 26);
INSERT INTO public.cidade VALUES (5292, 'Suzanápolis', 26);
INSERT INTO public.cidade VALUES (5293, 'Suzano', 26);
INSERT INTO public.cidade VALUES (5294, 'Tabapuã', 26);
INSERT INTO public.cidade VALUES (5295, 'Tabatinga', 26);
INSERT INTO public.cidade VALUES (5296, 'Taboão da Serra', 26);
INSERT INTO public.cidade VALUES (5297, 'Taciba', 26);
INSERT INTO public.cidade VALUES (5298, 'Taguaí', 26);
INSERT INTO public.cidade VALUES (5299, 'Taiaçu', 26);
INSERT INTO public.cidade VALUES (5300, 'Taiúva', 26);
INSERT INTO public.cidade VALUES (5301, 'Tambaú', 26);
INSERT INTO public.cidade VALUES (5302, 'Tanabi', 26);
INSERT INTO public.cidade VALUES (5303, 'Tapiraí', 26);
INSERT INTO public.cidade VALUES (5304, 'Tapiratiba', 26);
INSERT INTO public.cidade VALUES (5305, 'Taquaral', 26);
INSERT INTO public.cidade VALUES (5306, 'Taquaritinga', 26);
INSERT INTO public.cidade VALUES (5307, 'Taquarituba', 26);
INSERT INTO public.cidade VALUES (5308, 'Taquarivaí', 26);
INSERT INTO public.cidade VALUES (5309, 'Tarabai', 26);
INSERT INTO public.cidade VALUES (5310, 'Tarumã', 26);
INSERT INTO public.cidade VALUES (5311, 'Tatuí', 26);
INSERT INTO public.cidade VALUES (5312, 'Taubaté', 26);
INSERT INTO public.cidade VALUES (5313, 'Tejupá', 26);
INSERT INTO public.cidade VALUES (5314, 'Teodoro Sampaio', 26);
INSERT INTO public.cidade VALUES (5315, 'Terra Roxa', 26);
INSERT INTO public.cidade VALUES (5316, 'Tietê', 26);
INSERT INTO public.cidade VALUES (5317, 'Timburi', 26);
INSERT INTO public.cidade VALUES (5318, 'Torre de Pedra', 26);
INSERT INTO public.cidade VALUES (5319, 'Torrinha', 26);
INSERT INTO public.cidade VALUES (5320, 'Trabiju', 26);
INSERT INTO public.cidade VALUES (5321, 'Tremembé', 26);
INSERT INTO public.cidade VALUES (5322, 'Três Fronteiras', 26);
INSERT INTO public.cidade VALUES (5323, 'Tuiuti', 26);
INSERT INTO public.cidade VALUES (5324, 'Tupã', 26);
INSERT INTO public.cidade VALUES (5325, 'Tupi Paulista', 26);
INSERT INTO public.cidade VALUES (5326, 'Turiúba', 26);
INSERT INTO public.cidade VALUES (5327, 'Turmalina', 26);
INSERT INTO public.cidade VALUES (5328, 'Ubarana', 26);
INSERT INTO public.cidade VALUES (5329, 'Ubatuba', 26);
INSERT INTO public.cidade VALUES (5330, 'Ubirajara', 26);
INSERT INTO public.cidade VALUES (5331, 'Uchoa', 26);
INSERT INTO public.cidade VALUES (5332, 'União Paulista', 26);
INSERT INTO public.cidade VALUES (5333, 'Urânia', 26);
INSERT INTO public.cidade VALUES (5334, 'Uru', 26);
INSERT INTO public.cidade VALUES (5335, 'Urupês', 26);
INSERT INTO public.cidade VALUES (5336, 'Valentim Gentil', 26);
INSERT INTO public.cidade VALUES (5337, 'Valinhos', 26);
INSERT INTO public.cidade VALUES (5338, 'Valparaíso', 26);
INSERT INTO public.cidade VALUES (5339, 'Vargem', 26);
INSERT INTO public.cidade VALUES (5340, 'Vargem Grande do Sul', 26);
INSERT INTO public.cidade VALUES (5341, 'Vargem Grande Paulista', 26);
INSERT INTO public.cidade VALUES (5342, 'Várzea Paulista', 26);
INSERT INTO public.cidade VALUES (5343, 'Vera Cruz', 26);
INSERT INTO public.cidade VALUES (5344, 'Vinhedo', 26);
INSERT INTO public.cidade VALUES (5345, 'Viradouro', 26);
INSERT INTO public.cidade VALUES (5346, 'Vista Alegre do Alto', 26);
INSERT INTO public.cidade VALUES (5347, 'Vitória Brasil', 26);
INSERT INTO public.cidade VALUES (5348, 'Votorantim', 26);
INSERT INTO public.cidade VALUES (5349, 'Votuporanga', 26);
INSERT INTO public.cidade VALUES (5350, 'Zacarias', 26);
INSERT INTO public.cidade VALUES (5351, 'Amparo de São Francisco', 25);
INSERT INTO public.cidade VALUES (5352, 'Aquidabã', 25);
INSERT INTO public.cidade VALUES (5353, 'Aracaju', 25);
INSERT INTO public.cidade VALUES (5354, 'Arauá', 25);
INSERT INTO public.cidade VALUES (5355, 'Areia Branca', 25);
INSERT INTO public.cidade VALUES (5356, 'Barra dos Coqueiros', 25);
INSERT INTO public.cidade VALUES (5357, 'Boquim', 25);
INSERT INTO public.cidade VALUES (5358, 'Brejo Grande', 25);
INSERT INTO public.cidade VALUES (5359, 'Campo do Brito', 25);
INSERT INTO public.cidade VALUES (5360, 'Canhoba', 25);
INSERT INTO public.cidade VALUES (5361, 'Canindé de São Francisco', 25);
INSERT INTO public.cidade VALUES (5362, 'Capela', 25);
INSERT INTO public.cidade VALUES (5363, 'Carira', 25);
INSERT INTO public.cidade VALUES (5364, 'Carmópolis', 25);
INSERT INTO public.cidade VALUES (5365, 'Cedro de São João', 25);
INSERT INTO public.cidade VALUES (5366, 'Cristinápolis', 25);
INSERT INTO public.cidade VALUES (5367, 'Cumbe', 25);
INSERT INTO public.cidade VALUES (5368, 'Divina Pastora', 25);
INSERT INTO public.cidade VALUES (5369, 'Estância', 25);
INSERT INTO public.cidade VALUES (5370, 'Feira Nova', 25);
INSERT INTO public.cidade VALUES (5371, 'Frei Paulo', 25);
INSERT INTO public.cidade VALUES (5372, 'Gararu', 25);
INSERT INTO public.cidade VALUES (5373, 'General Maynard', 25);
INSERT INTO public.cidade VALUES (5374, 'Gracho Cardoso', 25);
INSERT INTO public.cidade VALUES (5375, 'Ilha das Flores', 25);
INSERT INTO public.cidade VALUES (5376, 'Indiaroba', 25);
INSERT INTO public.cidade VALUES (5377, 'Itabaiana', 25);
INSERT INTO public.cidade VALUES (5378, 'Itabaianinha', 25);
INSERT INTO public.cidade VALUES (5379, 'Itabi', 25);
INSERT INTO public.cidade VALUES (5380, 'Itaporanga d`Ajuda', 25);
INSERT INTO public.cidade VALUES (5381, 'Japaratuba', 25);
INSERT INTO public.cidade VALUES (5382, 'Japoatã', 25);
INSERT INTO public.cidade VALUES (5383, 'Lagarto', 25);
INSERT INTO public.cidade VALUES (5384, 'Laranjeiras', 25);
INSERT INTO public.cidade VALUES (5385, 'Macambira', 25);
INSERT INTO public.cidade VALUES (5386, 'Malhada dos Bois', 25);
INSERT INTO public.cidade VALUES (5387, 'Malhador', 25);
INSERT INTO public.cidade VALUES (5388, 'Maruim', 25);
INSERT INTO public.cidade VALUES (5389, 'Moita Bonita', 25);
INSERT INTO public.cidade VALUES (5390, 'Monte Alegre de Sergipe', 25);
INSERT INTO public.cidade VALUES (5391, 'Muribeca', 25);
INSERT INTO public.cidade VALUES (5392, 'Neópolis', 25);
INSERT INTO public.cidade VALUES (5393, 'Nossa Senhora Aparecida', 25);
INSERT INTO public.cidade VALUES (5394, 'Nossa Senhora da Glória', 25);
INSERT INTO public.cidade VALUES (5395, 'Nossa Senhora das Dores', 25);
INSERT INTO public.cidade VALUES (5396, 'Nossa Senhora de Lourdes', 25);
INSERT INTO public.cidade VALUES (5397, 'Nossa Senhora do Socorro', 25);
INSERT INTO public.cidade VALUES (5398, 'Pacatuba', 25);
INSERT INTO public.cidade VALUES (5399, 'Pedra Mole', 25);
INSERT INTO public.cidade VALUES (5400, 'Pedrinhas', 25);
INSERT INTO public.cidade VALUES (5401, 'Pinhão', 25);
INSERT INTO public.cidade VALUES (5402, 'Pirambu', 25);
INSERT INTO public.cidade VALUES (5403, 'Poço Redondo', 25);
INSERT INTO public.cidade VALUES (5404, 'Poço Verde', 25);
INSERT INTO public.cidade VALUES (5405, 'Porto da Folha', 25);
INSERT INTO public.cidade VALUES (5406, 'Propriá', 25);
INSERT INTO public.cidade VALUES (5407, 'Riachão do Dantas', 25);
INSERT INTO public.cidade VALUES (5408, 'Riachuelo', 25);
INSERT INTO public.cidade VALUES (5409, 'Ribeirópolis', 25);
INSERT INTO public.cidade VALUES (5410, 'Rosário do Catete', 25);
INSERT INTO public.cidade VALUES (5411, 'Salgado', 25);
INSERT INTO public.cidade VALUES (5412, 'Santa Luzia do Itanhy', 25);
INSERT INTO public.cidade VALUES (5413, 'Santa Rosa de Lima', 25);
INSERT INTO public.cidade VALUES (5414, 'Santana do São Francisco', 25);
INSERT INTO public.cidade VALUES (5415, 'Santo Amaro das Brotas', 25);
INSERT INTO public.cidade VALUES (5416, 'São Cristóvão', 25);
INSERT INTO public.cidade VALUES (5417, 'São Domingos', 25);
INSERT INTO public.cidade VALUES (5418, 'São Francisco', 25);
INSERT INTO public.cidade VALUES (5419, 'São Miguel do Aleixo', 25);
INSERT INTO public.cidade VALUES (5420, 'Simão Dias', 25);
INSERT INTO public.cidade VALUES (5421, 'Siriri', 25);
INSERT INTO public.cidade VALUES (5422, 'Telha', 25);
INSERT INTO public.cidade VALUES (5423, 'Tobias Barreto', 25);
INSERT INTO public.cidade VALUES (5424, 'Tomar do Geru', 25);
INSERT INTO public.cidade VALUES (5425, 'Umbaúba', 25);
INSERT INTO public.cidade VALUES (5426, 'Abreulândia', 27);
INSERT INTO public.cidade VALUES (5427, 'Aguiarnópolis', 27);
INSERT INTO public.cidade VALUES (5428, 'Aliança do Tocantins', 27);
INSERT INTO public.cidade VALUES (5429, 'Almas', 27);
INSERT INTO public.cidade VALUES (5430, 'Alvorada', 27);
INSERT INTO public.cidade VALUES (5431, 'Ananás', 27);
INSERT INTO public.cidade VALUES (5432, 'Angico', 27);
INSERT INTO public.cidade VALUES (5433, 'Aparecida do Rio Negro', 27);
INSERT INTO public.cidade VALUES (5434, 'Aragominas', 27);
INSERT INTO public.cidade VALUES (5435, 'Araguacema', 27);
INSERT INTO public.cidade VALUES (5436, 'Araguaçu', 27);
INSERT INTO public.cidade VALUES (5437, 'Araguaína', 27);
INSERT INTO public.cidade VALUES (5438, 'Araguanã', 27);
INSERT INTO public.cidade VALUES (5439, 'Araguatins', 27);
INSERT INTO public.cidade VALUES (5440, 'Arapoema', 27);
INSERT INTO public.cidade VALUES (5441, 'Arraias', 27);
INSERT INTO public.cidade VALUES (5442, 'Augustinópolis', 27);
INSERT INTO public.cidade VALUES (5443, 'Aurora do Tocantins', 27);
INSERT INTO public.cidade VALUES (5444, 'Axixá do Tocantins', 27);
INSERT INTO public.cidade VALUES (5445, 'Babaçulândia', 27);
INSERT INTO public.cidade VALUES (5446, 'Bandeirantes do Tocantins', 27);
INSERT INTO public.cidade VALUES (5447, 'Barra do Ouro', 27);
INSERT INTO public.cidade VALUES (5448, 'Barrolândia', 27);
INSERT INTO public.cidade VALUES (5449, 'Bernardo Sayão', 27);
INSERT INTO public.cidade VALUES (5450, 'Bom Jesus do Tocantins', 27);
INSERT INTO public.cidade VALUES (5451, 'Brasilândia do Tocantins', 27);
INSERT INTO public.cidade VALUES (5452, 'Brejinho de Nazaré', 27);
INSERT INTO public.cidade VALUES (5453, 'Buriti do Tocantins', 27);
INSERT INTO public.cidade VALUES (5454, 'Cachoeirinha', 27);
INSERT INTO public.cidade VALUES (5455, 'Campos Lindos', 27);
INSERT INTO public.cidade VALUES (5456, 'Cariri do Tocantins', 27);
INSERT INTO public.cidade VALUES (5457, 'Carmolândia', 27);
INSERT INTO public.cidade VALUES (5458, 'Carrasco Bonito', 27);
INSERT INTO public.cidade VALUES (5459, 'Caseara', 27);
INSERT INTO public.cidade VALUES (5460, 'Centenário', 27);
INSERT INTO public.cidade VALUES (5461, 'Chapada da Natividade', 27);
INSERT INTO public.cidade VALUES (5462, 'Chapada de Areia', 27);
INSERT INTO public.cidade VALUES (5463, 'Colinas do Tocantins', 27);
INSERT INTO public.cidade VALUES (5464, 'Colméia', 27);
INSERT INTO public.cidade VALUES (5465, 'Combinado', 27);
INSERT INTO public.cidade VALUES (5466, 'Conceição do Tocantins', 27);
INSERT INTO public.cidade VALUES (5467, 'Couto de Magalhães', 27);
INSERT INTO public.cidade VALUES (5468, 'Cristalândia', 27);
INSERT INTO public.cidade VALUES (5469, 'Crixás do Tocantins', 27);
INSERT INTO public.cidade VALUES (5470, 'Darcinópolis', 27);
INSERT INTO public.cidade VALUES (5471, 'Dianópolis', 27);
INSERT INTO public.cidade VALUES (5472, 'Divinópolis do Tocantins', 27);
INSERT INTO public.cidade VALUES (5473, 'Dois Irmãos do Tocantins', 27);
INSERT INTO public.cidade VALUES (5474, 'Dueré', 27);
INSERT INTO public.cidade VALUES (5475, 'Esperantina', 27);
INSERT INTO public.cidade VALUES (5476, 'Fátima', 27);
INSERT INTO public.cidade VALUES (5477, 'Figueirópolis', 27);
INSERT INTO public.cidade VALUES (5478, 'Filadélfia', 27);
INSERT INTO public.cidade VALUES (5479, 'Formoso do Araguaia', 27);
INSERT INTO public.cidade VALUES (5480, 'Fortaleza do Tabocão', 27);
INSERT INTO public.cidade VALUES (5481, 'Goianorte', 27);
INSERT INTO public.cidade VALUES (5482, 'Goiatins', 27);
INSERT INTO public.cidade VALUES (5483, 'Guaraí', 27);
INSERT INTO public.cidade VALUES (5484, 'Gurupi', 27);
INSERT INTO public.cidade VALUES (5485, 'Ipueiras', 27);
INSERT INTO public.cidade VALUES (5486, 'Itacajá', 27);
INSERT INTO public.cidade VALUES (5487, 'Itaguatins', 27);
INSERT INTO public.cidade VALUES (5488, 'Itapiratins', 27);
INSERT INTO public.cidade VALUES (5489, 'Itaporã do Tocantins', 27);
INSERT INTO public.cidade VALUES (5490, 'Jaú do Tocantins', 27);
INSERT INTO public.cidade VALUES (5491, 'Juarina', 27);
INSERT INTO public.cidade VALUES (5492, 'Lagoa da Confusão', 27);
INSERT INTO public.cidade VALUES (5493, 'Lagoa do Tocantins', 27);
INSERT INTO public.cidade VALUES (5494, 'Lajeado', 27);
INSERT INTO public.cidade VALUES (5495, 'Lavandeira', 27);
INSERT INTO public.cidade VALUES (5496, 'Lizarda', 27);
INSERT INTO public.cidade VALUES (5497, 'Luzinópolis', 27);
INSERT INTO public.cidade VALUES (5498, 'Marianópolis do Tocantins', 27);
INSERT INTO public.cidade VALUES (5499, 'Mateiros', 27);
INSERT INTO public.cidade VALUES (5500, 'Maurilândia do Tocantins', 27);
INSERT INTO public.cidade VALUES (5501, 'Miracema do Tocantins', 27);
INSERT INTO public.cidade VALUES (5502, 'Miranorte', 27);
INSERT INTO public.cidade VALUES (5503, 'Monte do Carmo', 27);
INSERT INTO public.cidade VALUES (5504, 'Monte Santo do Tocantins', 27);
INSERT INTO public.cidade VALUES (5505, 'Muricilândia', 27);
INSERT INTO public.cidade VALUES (5506, 'Natividade', 27);
INSERT INTO public.cidade VALUES (5507, 'Nazaré', 27);
INSERT INTO public.cidade VALUES (5508, 'Nova Olinda', 27);
INSERT INTO public.cidade VALUES (5509, 'Nova Rosalândia', 27);
INSERT INTO public.cidade VALUES (5510, 'Novo Acordo', 27);
INSERT INTO public.cidade VALUES (5511, 'Novo Alegre', 27);
INSERT INTO public.cidade VALUES (5512, 'Novo Jardim', 27);
INSERT INTO public.cidade VALUES (5513, 'Oliveira de Fátima', 27);
INSERT INTO public.cidade VALUES (5514, 'Palmas', 27);
INSERT INTO public.cidade VALUES (5515, 'Palmeirante', 27);
INSERT INTO public.cidade VALUES (5516, 'Palmeiras do Tocantins', 27);
INSERT INTO public.cidade VALUES (5517, 'Palmeirópolis', 27);
INSERT INTO public.cidade VALUES (5518, 'Paraíso do Tocantins', 27);
INSERT INTO public.cidade VALUES (5519, 'Paranã', 27);
INSERT INTO public.cidade VALUES (5520, 'Pau d`Arco', 27);
INSERT INTO public.cidade VALUES (5521, 'Pedro Afonso', 27);
INSERT INTO public.cidade VALUES (5522, 'Peixe', 27);
INSERT INTO public.cidade VALUES (5523, 'Pequizeiro', 27);
INSERT INTO public.cidade VALUES (5524, 'Pindorama do Tocantins', 27);
INSERT INTO public.cidade VALUES (5525, 'Piraquê', 27);
INSERT INTO public.cidade VALUES (5526, 'Pium', 27);
INSERT INTO public.cidade VALUES (5527, 'Ponte Alta do Bom Jesus', 27);
INSERT INTO public.cidade VALUES (5528, 'Ponte Alta do Tocantins', 27);
INSERT INTO public.cidade VALUES (5529, 'Porto Alegre do Tocantins', 27);
INSERT INTO public.cidade VALUES (5530, 'Porto Nacional', 27);
INSERT INTO public.cidade VALUES (5531, 'Praia Norte', 27);
INSERT INTO public.cidade VALUES (5532, 'Presidente Kennedy', 27);
INSERT INTO public.cidade VALUES (5533, 'Pugmil', 27);
INSERT INTO public.cidade VALUES (5534, 'Recursolândia', 27);
INSERT INTO public.cidade VALUES (5535, 'Riachinho', 27);
INSERT INTO public.cidade VALUES (5536, 'Rio da Conceição', 27);
INSERT INTO public.cidade VALUES (5537, 'Rio dos Bois', 27);
INSERT INTO public.cidade VALUES (5538, 'Rio Sono', 27);
INSERT INTO public.cidade VALUES (5539, 'Sampaio', 27);
INSERT INTO public.cidade VALUES (5540, 'Sandolândia', 27);
INSERT INTO public.cidade VALUES (5541, 'Santa Fé do Araguaia', 27);
INSERT INTO public.cidade VALUES (5542, 'Santa Maria do Tocantins', 27);
INSERT INTO public.cidade VALUES (5543, 'Santa Rita do Tocantins', 27);
INSERT INTO public.cidade VALUES (5544, 'Santa Rosa do Tocantins', 27);
INSERT INTO public.cidade VALUES (5545, 'Santa Tereza do Tocantins', 27);
INSERT INTO public.cidade VALUES (5546, 'Santa Terezinha do Tocantins', 27);
INSERT INTO public.cidade VALUES (5547, 'São Bento do Tocantins', 27);
INSERT INTO public.cidade VALUES (5548, 'São Félix do Tocantins', 27);
INSERT INTO public.cidade VALUES (5549, 'São Miguel do Tocantins', 27);
INSERT INTO public.cidade VALUES (5550, 'São Salvador do Tocantins', 27);
INSERT INTO public.cidade VALUES (5551, 'São Sebastião do Tocantins', 27);
INSERT INTO public.cidade VALUES (5552, 'São Valério da Natividade', 27);
INSERT INTO public.cidade VALUES (5553, 'Silvanópolis', 27);
INSERT INTO public.cidade VALUES (5554, 'Sítio Novo do Tocantins', 27);
INSERT INTO public.cidade VALUES (5555, 'Sucupira', 27);
INSERT INTO public.cidade VALUES (5556, 'Taguatinga', 27);
INSERT INTO public.cidade VALUES (5557, 'Taipas do Tocantins', 27);
INSERT INTO public.cidade VALUES (5558, 'Talismã', 27);
INSERT INTO public.cidade VALUES (5559, 'Tocantínia', 27);
INSERT INTO public.cidade VALUES (5560, 'Tocantinópolis', 27);
INSERT INTO public.cidade VALUES (5561, 'Tupirama', 27);
INSERT INTO public.cidade VALUES (5562, 'Tupiratins', 27);
INSERT INTO public.cidade VALUES (5563, 'Wanderlândia', 27);
INSERT INTO public.cidade VALUES (5564, 'Xambioá', 27);
INSERT INTO public.cidade VALUES (5574, 'Recanto das Emas', 7);
INSERT INTO public.cidade VALUES (5575, 'Gama', 7);
INSERT INTO public.cidade VALUES (5576, 'Taguatinga', 7);
INSERT INTO public.cidade VALUES (5577, 'Brazlândia', 7);
INSERT INTO public.cidade VALUES (5578, 'Sobradinho', 7);
INSERT INTO public.cidade VALUES (5579, 'Planaltina', 7);
INSERT INTO public.cidade VALUES (5580, 'Paranoá', 7);
INSERT INTO public.cidade VALUES (5581, 'Núcleo Bandeirante', 7);
INSERT INTO public.cidade VALUES (5582, 'Ceilândia', 7);
INSERT INTO public.cidade VALUES (5583, 'Guará', 7);
INSERT INTO public.cidade VALUES (5584, 'Cruzeiro', 7);
INSERT INTO public.cidade VALUES (5585, 'Samambaia', 7);
INSERT INTO public.cidade VALUES (5586, 'Santa Maria', 7);
INSERT INTO public.cidade VALUES (5587, 'São Sebastião', 7);
INSERT INTO public.cidade VALUES (5589, 'Lago Sul', 7);
INSERT INTO public.cidade VALUES (5590, 'Riacho Fundo', 7);
INSERT INTO public.cidade VALUES (5591, 'Lago Norte', 7);
INSERT INTO public.cidade VALUES (5592, 'Candangolândia', 7);
INSERT INTO public.cidade VALUES (5593, 'Águas Claras', 7);
INSERT INTO public.cidade VALUES (5594, 'Riacho Fundo II', 7);
INSERT INTO public.cidade VALUES (5595, 'Sudoeste/Octogonal', 7);
INSERT INTO public.cidade VALUES (5596, 'Varjão', 7);
INSERT INTO public.cidade VALUES (5597, 'Park Way', 7);
INSERT INTO public.cidade VALUES (5598, 'SCIA', 7);
INSERT INTO public.cidade VALUES (5599, 'Sobradinho II', 7);
INSERT INTO public.cidade VALUES (5600, 'Jardim Botânico', 7);
INSERT INTO public.cidade VALUES (5601, 'Itapoã', 7);
INSERT INTO public.cidade VALUES (5602, 'SIA', 7);
INSERT INTO public.cidade VALUES (5603, 'Vicente Pires', 7);
INSERT INTO public.cidade VALUES (5604, 'Fercal', 7);
INSERT INTO public.cidade VALUES (5605, 'Nazária', 17);
INSERT INTO public.cidade VALUES (5606, 'Paraíso das Águas', 12);
INSERT INTO public.cidade VALUES (5607, 'Pinto Bandeira', 23);
INSERT INTO public.cidade VALUES (5608, 'Balneário Rincão', 24);
INSERT INTO public.cidade VALUES (5609, 'Pescaria Brava', 24);


--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.estado VALUES (1, 'Acre', 'AC', '[68]');
INSERT INTO public.estado VALUES (2, 'Alagoas', 'AL', '[82]');
INSERT INTO public.estado VALUES (3, 'Amazonas', 'AM', '[97,92]');
INSERT INTO public.estado VALUES (4, 'Amapá', 'AP', '[96]');
INSERT INTO public.estado VALUES (5, 'Bahia', 'BA', '[77,75,73,74,71]');
INSERT INTO public.estado VALUES (6, 'Ceará', 'CE', '[88,85]');
INSERT INTO public.estado VALUES (7, 'Distrito Federal', 'DF', '[61]');
INSERT INTO public.estado VALUES (8, 'Espírito Santo', 'ES', '[28,27]');
INSERT INTO public.estado VALUES (9, 'Goiás', 'GO', '[62,64,61]');
INSERT INTO public.estado VALUES (10, 'Maranhão', 'MA', '[99,98]');
INSERT INTO public.estado VALUES (11, 'Minas Gerais', 'MG', '[34,37,31,33,35,38,32]');
INSERT INTO public.estado VALUES (12, 'Mato Grosso do Sul', 'MS', '[67]');
INSERT INTO public.estado VALUES (13, 'Mato Grosso', 'MT', '[65,66]');
INSERT INTO public.estado VALUES (14, 'Pará', 'PA', '[91,94,93]');
INSERT INTO public.estado VALUES (15, 'Paraíba', 'PB', '[83]');
INSERT INTO public.estado VALUES (16, 'Pernambuco', 'PE', '[81,87]');
INSERT INTO public.estado VALUES (17, 'Piauí', 'PI', '[89,86]');
INSERT INTO public.estado VALUES (18, 'Paraná', 'PR', '[43,41,42,44,45,46]');
INSERT INTO public.estado VALUES (19, 'Rio de Janeiro', 'RJ', '[24,22,21]');
INSERT INTO public.estado VALUES (20, 'Rio Grande do Norte', 'RN', '[84]');
INSERT INTO public.estado VALUES (21, 'Rondônia', 'RO', '[69]');
INSERT INTO public.estado VALUES (22, 'Roraima', 'RR', '[95]');
INSERT INTO public.estado VALUES (23, 'Rio Grande do Sul', 'RS', '[53,54,55,51]');
INSERT INTO public.estado VALUES (24, 'Santa Catarina', 'SC', '[47,48,49]');
INSERT INTO public.estado VALUES (25, 'Sergipe', 'SE', '[79]');
INSERT INTO public.estado VALUES (26, 'São Paulo', 'SP', '[11,12,13,14,15,16,17,18,19]');
INSERT INTO public.estado VALUES (27, 'Tocantins', 'TO', '[63]');
INSERT INTO public.estado VALUES (99, 'Exterior', 'EX', NULL);


--
-- Data for Name: prestadorServico; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."prestadorServico" VALUES (32, 1, 1, 298, 475);
INSERT INTO public."prestadorServico" VALUES (33, 2, 2, 166, 252);
INSERT INTO public."prestadorServico" VALUES (34, 3, 3, 152, 169);
INSERT INTO public."prestadorServico" VALUES (35, 4, 4, 281, 437);
INSERT INTO public."prestadorServico" VALUES (36, 5, 5, 441, 477);
INSERT INTO public."prestadorServico" VALUES (37, 6, 6, 281, 320);
INSERT INTO public."prestadorServico" VALUES (38, 7, 7, 449, 491);
INSERT INTO public."prestadorServico" VALUES (39, 8, 8, 40, 152);
INSERT INTO public."prestadorServico" VALUES (40, 9, 9, 218, 438);
INSERT INTO public."prestadorServico" VALUES (41, 10, 10, 177, 458);
INSERT INTO public."prestadorServico" VALUES (42, 11, 11, 218, 394);
INSERT INTO public."prestadorServico" VALUES (43, 12, 12, 410, 442);
INSERT INTO public."prestadorServico" VALUES (44, 13, 13, 386, 448);
INSERT INTO public."prestadorServico" VALUES (45, 14, 14, 70, 136);
INSERT INTO public."prestadorServico" VALUES (46, 15, 1, 385, 415);
INSERT INTO public."prestadorServico" VALUES (47, 16, 2, 451, 488);
INSERT INTO public."prestadorServico" VALUES (48, 17, 3, 484, 489);
INSERT INTO public."prestadorServico" VALUES (49, 18, 4, 48, 485);
INSERT INTO public."prestadorServico" VALUES (50, 19, 5, 362, 492);
INSERT INTO public."prestadorServico" VALUES (51, 20, 6, 418, 455);
INSERT INTO public."prestadorServico" VALUES (52, 21, 7, 62, 406);
INSERT INTO public."prestadorServico" VALUES (53, 22, 8, 43, 124);
INSERT INTO public."prestadorServico" VALUES (54, 23, 9, 95, 167);
INSERT INTO public."prestadorServico" VALUES (55, 24, 10, 331, 415);
INSERT INTO public."prestadorServico" VALUES (56, 25, 11, 216, 430);
INSERT INTO public."prestadorServico" VALUES (57, 26, 12, 40, 379);
INSERT INTO public."prestadorServico" VALUES (58, 27, 13, 442, 469);
INSERT INTO public."prestadorServico" VALUES (59, 28, 14, 299, 370);
INSERT INTO public."prestadorServico" VALUES (60, 29, 1, 367, 453);
INSERT INTO public."prestadorServico" VALUES (61, 30, 2, 421, 431);
INSERT INTO public."prestadorServico" VALUES (62, 31, 3, 332, 482);


--
-- Data for Name: servicoSolicitado; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."servicoSolicitado" VALUES (1, '2023-08-13 19:29:27.144', 3, 11, 17, true);
INSERT INTO public."servicoSolicitado" VALUES (2, '2023-08-13 19:38:57.694', 3, 11, 3, true);
INSERT INTO public."servicoSolicitado" VALUES (3, '2023-08-13 19:39:05.251', 3, 11, 3, true);
INSERT INTO public."servicoSolicitado" VALUES (4, '2023-08-13 19:39:22.16', 3, 11, 31, true);
INSERT INTO public."servicoSolicitado" VALUES (5, '2023-08-13 19:40:57.03', 7, 11, 7, true);
INSERT INTO public."servicoSolicitado" VALUES (6, '2023-08-13 19:42:12.816', 7, 11, 21, true);
INSERT INTO public."servicoSolicitado" VALUES (7, '2023-08-13 19:49:50.691', 3, 11, 3, true);
INSERT INTO public."servicoSolicitado" VALUES (8, '2023-08-13 19:50:41.945', 3, 11, 3, true);
INSERT INTO public."servicoSolicitado" VALUES (9, '2023-08-13 19:52:41.827', 3, 11, 17, true);
INSERT INTO public."servicoSolicitado" VALUES (10, '2023-08-13 19:59:40.517', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (11, '2023-08-13 20:01:02.194', 7, 11, 7, true);
INSERT INTO public."servicoSolicitado" VALUES (12, '2023-08-13 20:10:24.538', 7, 11, 7, true);
INSERT INTO public."servicoSolicitado" VALUES (13, '2023-08-13 20:12:23.085', 3, 11, 31, true);
INSERT INTO public."servicoSolicitado" VALUES (14, '2023-08-13 20:19:51.682', 8, 11, 8, true);
INSERT INTO public."servicoSolicitado" VALUES (15, '2023-08-13 20:23:07.261', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (16, '2023-08-13 20:26:38.228', 3, 11, 3, true);
INSERT INTO public."servicoSolicitado" VALUES (17, '2023-08-13 20:33:27.27', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (18, '2023-08-13 21:05:57.039', 3, 11, 17, true);
INSERT INTO public."servicoSolicitado" VALUES (19, '2023-08-13 21:07:06.687', 4, 11, 18, true);
INSERT INTO public."servicoSolicitado" VALUES (20, '2023-08-13 21:24:10.143', 3, 11, 17, true);
INSERT INTO public."servicoSolicitado" VALUES (21, '2023-08-13 21:25:52.758', 8, 11, 8, true);
INSERT INTO public."servicoSolicitado" VALUES (22, '2023-08-13 21:27:40.748', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (23, '2023-08-13 21:28:21.622', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (24, '2023-08-13 21:30:17.439', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (25, '2023-08-13 21:31:00.148', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (26, '2023-08-13 21:31:04.036', 8, 11, 8, false);
INSERT INTO public."servicoSolicitado" VALUES (27, '2023-08-13 21:41:18.899', 3, 11, 3, false);
INSERT INTO public."servicoSolicitado" VALUES (29, '2023-08-13 21:44:00.031', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (28, '2023-08-13 21:43:10.166', 3, 11, 31, false);
INSERT INTO public."servicoSolicitado" VALUES (30, '2023-08-13 21:45:25.463', 4, 11, 4, false);
INSERT INTO public."servicoSolicitado" VALUES (31, '2023-08-13 21:45:47.036', 13, 11, 13, false);
INSERT INTO public."servicoSolicitado" VALUES (32, '2023-08-13 21:46:20.256', 8, 11, 8, true);
INSERT INTO public."servicoSolicitado" VALUES (33, '2023-08-13 21:46:25.06', 7, 11, 7, true);
INSERT INTO public."servicoSolicitado" VALUES (34, '2023-08-13 21:51:01.939', 3, 11, 3, true);
INSERT INTO public."servicoSolicitado" VALUES (35, '2023-08-13 21:54:41.829', 4, 11, 4, true);
INSERT INTO public."servicoSolicitado" VALUES (36, '2023-08-13 21:55:00.416', 12, 11, 12, true);
INSERT INTO public."servicoSolicitado" VALUES (37, '2023-08-13 21:59:00.498', 10, 11, 10, true);
INSERT INTO public."servicoSolicitado" VALUES (38, '2023-08-13 21:59:52.931', 8, 11, 8, true);
INSERT INTO public."servicoSolicitado" VALUES (39, '2023-08-13 22:01:01.627', 11, 11, 11, true);
INSERT INTO public."servicoSolicitado" VALUES (40, '2023-08-13 22:03:19.17', 8, 11, 8, true);
INSERT INTO public."servicoSolicitado" VALUES (41, '2023-08-13 22:03:40.835', 8, 11, 8, true);
INSERT INTO public."servicoSolicitado" VALUES (42, '2023-08-13 22:03:45.428', 12, 11, 12, true);
INSERT INTO public."servicoSolicitado" VALUES (43, '2023-08-13 23:57:32.162', 8, 11, 22, false);
INSERT INTO public."servicoSolicitado" VALUES (44, '2023-08-14 00:11:22.323', 14, 11, 14, true);
INSERT INTO public."servicoSolicitado" VALUES (45, '2023-08-14 00:11:39.618', 4, 11, 18, true);
INSERT INTO public."servicoSolicitado" VALUES (46, '2023-08-14 00:12:31.824', 10, 11, 10, true);
INSERT INTO public."servicoSolicitado" VALUES (47, '2023-08-14 13:37:11.449', 5, 11, 5, true);


--
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.servicos VALUES (2, 'Manutenção de veículos', NULL, NULL, NULL, 2, true, '2023-08-12 14:26:43.407093');
INSERT INTO public.servicos VALUES (3, 'Troca de óleo', NULL, NULL, NULL, 2, true, '2023-08-12 14:26:43.407093');
INSERT INTO public.servicos VALUES (4, 'Serviços de pneus', NULL, NULL, NULL, 2, true, '2023-08-12 14:26:43.407093');
INSERT INTO public.servicos VALUES (5, 'Reparo de carroceria', NULL, NULL, NULL, 2, true, '2023-08-12 14:26:43.407093');
INSERT INTO public.servicos VALUES (6, 'Lavagem e detalhamento de carros', NULL, NULL, NULL, 2, true, '2023-08-12 14:26:43.407093');
INSERT INTO public.servicos VALUES (7, 'Agência de viagens', NULL, NULL, NULL, 14, true, '2023-08-12 14:28:13.96185');
INSERT INTO public.servicos VALUES (8, 'Reservas de passagens aéreas', NULL, NULL, NULL, 14, true, '2023-08-12 14:28:13.96185');
INSERT INTO public.servicos VALUES (9, 'Pacotes turísticos', NULL, NULL, NULL, 14, true, '2023-08-12 14:28:13.96185');
INSERT INTO public.servicos VALUES (10, 'Aluguel de veículos para viagens', NULL, NULL, NULL, 14, true, '2023-08-12 14:28:13.96185');
INSERT INTO public.servicos VALUES (11, 'Serviços de guia turístico', NULL, NULL, NULL, 14, true, '2023-08-12 14:28:13.96185');
INSERT INTO public.servicos VALUES (12, 'Transporte público', NULL, NULL, NULL, 13, true, '2023-08-12 14:29:01.235089');
INSERT INTO public.servicos VALUES (13, 'Serviço de transporte por aplicativo', NULL, NULL, NULL, 13, true, '2023-08-12 14:29:01.235089');
INSERT INTO public.servicos VALUES (14, 'Aluguel de ônibus para eventos', NULL, NULL, NULL, 13, true, '2023-08-12 14:29:01.235089');
INSERT INTO public.servicos VALUES (15, 'Transporte de cargas', NULL, NULL, NULL, 13, true, '2023-08-12 14:29:01.235089');
INSERT INTO public.servicos VALUES (16, 'Reparação de dispositivos eletrônicos', NULL, NULL, NULL, 12, true, '2023-08-12 14:29:47.157561');
INSERT INTO public.servicos VALUES (17, 'Desenvolvimento de software', NULL, NULL, NULL, 12, true, '2023-08-12 14:29:47.157561');
INSERT INTO public.servicos VALUES (18, 'Consultoria de TI', NULL, NULL, NULL, 12, true, '2023-08-12 14:29:47.157561');
INSERT INTO public.servicos VALUES (19, 'Serviços de design gráfico', NULL, NULL, NULL, 12, true, '2023-08-12 14:29:47.157561');
INSERT INTO public.servicos VALUES (20, 'Análises clínicas', NULL, NULL, NULL, 7, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (21, 'Testes de laboratório', NULL, NULL, NULL, 7, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (22, 'Pesquisa científica', NULL, NULL, NULL, 7, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (23, 'Serviços de diagnóstico médico', NULL, NULL, NULL, 7, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (24, 'Cuidados veterinários', NULL, NULL, NULL, 9, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (25, 'Grooming (banho e tosa) para animais de estimação', NULL, NULL, NULL, 9, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (26, 'Adestramento de animais', NULL, NULL, NULL, 9, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (27, 'Serviços de pet sitting', NULL, NULL, NULL, 9, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (28, 'Manutenção de jardins', NULL, NULL, NULL, 6, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (29, 'Paisagismo', NULL, NULL, NULL, 6, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (30, 'Venda de plantas e flores', NULL, NULL, NULL, 6, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (31, 'Instalação de sistemas de irrigação', NULL, NULL, NULL, 6, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (32, 'Aulas particulares', NULL, NULL, NULL, 5, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (33, 'Cursos online', NULL, NULL, NULL, 5, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (34, 'Consultoria educacional', NULL, NULL, NULL, 5, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (35, 'Treinamentos profissionais', NULL, NULL, NULL, 5, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (36, 'Serviços de chaveiro', NULL, NULL, NULL, 3, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (37, 'Cópia de chaves', NULL, NULL, NULL, 3, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (38, 'Instalação de fechaduras', NULL, NULL, NULL, 3, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (39, 'Abertura de portas', NULL, NULL, NULL, 3, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (40, 'Limpeza residencial', NULL, NULL, NULL, 11, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (41, 'Manutenção de eletrodomésticos', NULL, NULL, NULL, 11, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (42, 'Encanamento e reparos hidráulicos', NULL, NULL, NULL, 11, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (43, 'Serviços de elétrica', NULL, NULL, NULL, 11, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (44, 'Restaurantes', NULL, NULL, NULL, 1, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (45, 'Delivery de alimentos', NULL, NULL, NULL, 1, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (46, 'Catering para eventos', NULL, NULL, NULL, 1, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (47, 'Lojas de produtos alimentícios', NULL, NULL, NULL, 1, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (48, 'Consultas médicas', NULL, NULL, NULL, 10, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (49, 'Serviços de fisioterapia', NULL, NULL, NULL, 10, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (50, 'Clínicas de bem-estar', NULL, NULL, NULL, 10, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (51, 'Nutricionistas', NULL, NULL, NULL, 10, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (52, 'Cuidados para bebês e crianças', NULL, NULL, NULL, 4, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (53, 'Assistência a idosos', NULL, NULL, NULL, 4, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (54, 'Cuidados paliativos', NULL, NULL, NULL, 4, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (55, 'Serviços de enfermagem domiciliar', NULL, NULL, NULL, 4, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (56, 'Móveis sob medida', NULL, NULL, NULL, 8, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (57, 'Restauração de móveis', NULL, NULL, NULL, 8, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (58, 'Instalação de armários', NULL, NULL, NULL, 8, true, '2023-08-12 14:34:03.879986');
INSERT INTO public.servicos VALUES (59, 'Projetos de marcenaria', NULL, NULL, NULL, 8, true, '2023-08-12 14:34:03.879986');


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (68, 11, 'd3a6861c-6a96-437c-b357-4ecaaf5f0c8c', '2023-08-13 22:03:35.776', false);
INSERT INTO public.sessions VALUES (69, 11, '5cd145ea-a333-4761-9a35-016394e02d07', '2023-08-13 23:54:37.043', true);
INSERT INTO public.sessions VALUES (70, 11, 'ec934e19-55a6-4439-8a74-11f5b30620cf', '2023-08-13 23:57:01.844', false);
INSERT INTO public.sessions VALUES (71, 11, 'f6be7e7a-d8d2-4948-af20-38ab73ae3450', '2023-08-14 00:10:22.879', false);
INSERT INTO public.sessions VALUES (72, 11, 'a5fbb801-814f-4412-acb6-8922cb19dabc', '2023-08-14 00:10:39.25', true);
INSERT INTO public.sessions VALUES (73, 11, '0fb8ef92-eac5-485b-8058-859e1e4e0bfb', '2023-08-14 00:36:41.315', false);
INSERT INTO public.sessions VALUES (74, 11, '46c2d3f7-683a-4775-822a-3ea0e9f6d4c9', '2023-08-14 00:37:32.485', true);
INSERT INTO public.sessions VALUES (75, 11, '3fbe9be3-eff8-4610-ad45-e7cb2261c29c', '2023-08-14 00:38:00.589', false);
INSERT INTO public.sessions VALUES (34, 11, 'fc63e0e2-04b4-4dda-9864-9354cda5566b', '2023-08-13 17:01:32.986', true);
INSERT INTO public.sessions VALUES (35, 11, '82e13d9e-66f5-4b02-aa06-8bd1298f44b9', '2023-08-13 17:14:53.368', true);
INSERT INTO public.sessions VALUES (36, 11, '57e65041-ba1c-4602-8c2e-843a553b3cce', '2023-08-13 17:17:03.403', true);
INSERT INTO public.sessions VALUES (37, 11, 'adaac543-465e-44fa-9aba-8942af2e3c82', '2023-08-13 17:18:51.843', true);
INSERT INTO public.sessions VALUES (38, 11, 'fe1b3720-448e-4a88-9025-43ac7bb3ea31', '2023-08-13 18:21:35.313', true);
INSERT INTO public.sessions VALUES (39, 11, '2e798493-79e2-49b1-90b7-b9315da4a095', '2023-08-13 18:31:01.061', true);
INSERT INTO public.sessions VALUES (40, 11, '4f0e7c02-4aba-4b9f-98d8-818d2b49a842', '2023-08-13 18:32:29.243', true);
INSERT INTO public.sessions VALUES (41, 11, 'da1f7a2b-411b-4ff6-a12e-6bde2f455536', '2023-08-13 18:46:26.536', true);
INSERT INTO public.sessions VALUES (42, 11, 'c0893ff7-0e6e-4107-9140-77caa8390e8f', '2023-08-13 18:55:40.733', true);
INSERT INTO public.sessions VALUES (43, 11, 'c4a46e07-461b-492c-a770-a98527dab71d', '2023-08-13 18:57:17.487', true);
INSERT INTO public.sessions VALUES (44, 11, 'f9914245-1a37-436f-81cb-28d2e5c05f46', '2023-08-13 18:57:40.637', true);
INSERT INTO public.sessions VALUES (45, 11, 'b3664c00-8e78-4444-a9ab-9e9c6d5a497e', '2023-08-13 19:38:25.305', true);
INSERT INTO public.sessions VALUES (46, 11, '31a1bedb-3e16-4bf9-8df1-d4078130a2f1', '2023-08-13 19:38:51.382', true);
INSERT INTO public.sessions VALUES (47, 11, '4a7149f7-1c21-4697-a56b-b003a4609033', '2023-08-13 19:40:50.561', true);
INSERT INTO public.sessions VALUES (48, 11, '5307697a-6732-427a-9a4b-c1b92c9a5683', '2023-08-13 19:44:45.418', true);
INSERT INTO public.sessions VALUES (49, 11, '930ca6a6-a5bd-4b98-a9b0-631f10e94470', '2023-08-13 19:45:09.879', true);
INSERT INTO public.sessions VALUES (50, 11, 'e427e2ec-4a6f-4578-bf8c-1b5702b0a3e2', '2023-08-13 19:48:32.205', true);
INSERT INTO public.sessions VALUES (51, 11, 'cd112dee-a37d-4751-94d2-933c2eb3253e', '2023-08-13 19:52:34.283', true);
INSERT INTO public.sessions VALUES (52, 11, '175ee03e-8cfc-4c3c-8e59-e56de8f7602a', '2023-08-13 19:56:44.554', true);
INSERT INTO public.sessions VALUES (53, 11, '9d7b7c41-d3b0-4c87-8028-c326b0421dcc', '2023-08-13 19:57:23.423', true);
INSERT INTO public.sessions VALUES (54, 11, 'e905885a-4e48-488f-8b1c-d414244d5095', '2023-08-13 19:59:35.761', true);
INSERT INTO public.sessions VALUES (55, 11, '6396626e-bb8e-479a-b1c3-65efb5bf9ace', '2023-08-13 20:00:56.126', true);
INSERT INTO public.sessions VALUES (56, 11, '5e47133c-8a6c-4451-99d5-7838e86ce792', '2023-08-13 20:03:18.253', true);
INSERT INTO public.sessions VALUES (57, 11, '8fe52bdc-018d-447a-8a4c-185a36f414dc', '2023-08-13 20:21:02.427', true);
INSERT INTO public.sessions VALUES (58, 11, '6e40770f-19d8-4cf6-82b1-9b39db40c709', '2023-08-13 20:26:30.031', true);
INSERT INTO public.sessions VALUES (59, 11, '88901e22-3f50-4964-9fbb-2edc4172e547', '2023-08-13 21:05:51.081', true);
INSERT INTO public.sessions VALUES (60, 11, '2c229d8a-c94d-41bb-8aa2-6ed684488e07', '2023-08-13 21:24:02.53', true);
INSERT INTO public.sessions VALUES (61, 11, '669844e2-af25-4884-bcf5-ff5ca28a3df4', '2023-08-13 21:30:54.598', true);
INSERT INTO public.sessions VALUES (62, 11, '209f6a4e-0375-4845-90df-b3fa91be6175', '2023-08-13 21:41:12.123', true);
INSERT INTO public.sessions VALUES (63, 11, '1696c848-3b43-45f7-9312-0ac15db61371', '2023-08-13 21:43:03.837', true);
INSERT INTO public.sessions VALUES (64, 11, 'b738bd45-f1b2-4e07-8799-5790c114818e', '2023-08-13 21:50:55.961', true);
INSERT INTO public.sessions VALUES (65, 11, '424a72af-4849-4cdd-bdc0-29f0e09a834a', '2023-08-13 21:58:54.71', true);
INSERT INTO public.sessions VALUES (66, 11, 'aa75956a-e78a-42bd-b27f-1684907c661f', '2023-08-13 21:59:48.434', true);
INSERT INTO public.sessions VALUES (67, 11, '0819b571-48bc-471f-bd01-7369a7ef14a0', '2023-08-13 22:00:56.459', true);
INSERT INTO public.sessions VALUES (76, 11, 'f58e04fd-74dd-476d-871c-e2f2b09225b3', '2023-08-14 00:38:33.723', false);
INSERT INTO public.sessions VALUES (77, 11, '3db058c1-e905-42cf-874e-eb6a1b7e973f', '2023-08-14 00:39:03.277', true);
INSERT INTO public.sessions VALUES (78, 11, '1777f240-e024-4ca3-b531-e15d422d84bd', '2023-08-14 00:44:44.267', true);
INSERT INTO public.sessions VALUES (79, 11, '40a88059-8f42-4f72-b577-e0cb0b4c073e', '2023-08-14 00:45:19.446', true);
INSERT INTO public.sessions VALUES (80, 11, 'f2c1c047-afb1-4eba-9f7e-984de7031e7c', '2023-08-14 00:51:10.846', true);
INSERT INTO public.sessions VALUES (81, 11, 'a1cb292d-8f73-4d8f-b1c7-8f91b0e5188b', '2023-08-14 00:53:45.607', true);
INSERT INTO public.sessions VALUES (82, 11, '1cc89c89-3020-494f-a8e2-2de709242528', '2023-08-14 00:54:45.97', true);
INSERT INTO public.sessions VALUES (83, 11, '3f571e87-fc53-43c2-9770-49ec2da4bc2d', '2023-08-14 01:05:20.86', true);
INSERT INTO public.sessions VALUES (84, 11, 'a96e45f2-dbaa-4e61-ba0a-7362c64187e4', '2023-08-14 01:06:07.985', true);
INSERT INTO public.sessions VALUES (85, 11, '10878c0d-1428-4354-a3b7-de26236a6af4', '2023-08-14 01:07:38.865', true);
INSERT INTO public.sessions VALUES (86, 11, '18687846-59f3-4a48-9360-62cedb7b50e8', '2023-08-14 01:08:06.996', true);
INSERT INTO public.sessions VALUES (87, 11, '4fbed2c1-6622-4d98-8297-c1a4c2d1f476', '2023-08-14 01:23:55.565', true);
INSERT INTO public.sessions VALUES (88, 11, '17496181-d4b3-4c53-b6ab-34b361decd50', '2023-08-14 01:27:13.624', true);
INSERT INTO public.sessions VALUES (89, 11, '1cb70005-e90e-4574-bf61-908a0fa6fb9b', '2023-08-14 01:38:15.251', true);
INSERT INTO public.sessions VALUES (90, 11, 'e94a9859-1cff-4675-ad95-2aa1f93e816c', '2023-08-14 01:39:39.664', true);
INSERT INTO public.sessions VALUES (91, 11, '86330d43-8d4e-4019-97de-f2b4fb6b6f3d', '2023-08-14 01:40:48.878', true);
INSERT INTO public.sessions VALUES (92, 11, 'd3a7cc2c-5f19-49a7-ba1b-34e63581a1e1', '2023-08-14 01:41:30.992', true);
INSERT INTO public.sessions VALUES (93, 11, '192d5443-b2a3-4304-89b4-3d7297da7ff5', '2023-08-14 01:43:21.358', true);
INSERT INTO public.sessions VALUES (94, 11, '3c83162f-af07-4353-b291-14f8268c944d', '2023-08-14 02:02:03.715', true);
INSERT INTO public.sessions VALUES (95, 11, '2cc7e511-2e2b-4309-b536-fa191b6a0600', '2023-08-14 10:41:42.861', true);
INSERT INTO public.sessions VALUES (96, 11, 'b53d571d-15d3-4151-a2d4-1e369ceb0a4b', '2023-08-14 11:30:21.632', true);
INSERT INTO public.sessions VALUES (97, 11, '67894b20-296e-406d-84f2-db8da001c66c', '2023-08-14 11:43:26.304', true);
INSERT INTO public.sessions VALUES (98, 11, '0f2109b4-8dff-4ef3-b672-a73293531ba2', '2023-08-14 13:37:04.688', true);


--
-- Data for Name: statusServico; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (12, 'Jeanette Bins', 'Rusty.Feest@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '37875 Gabe Circles', 111111111111, 2, '2023-08-13 16:54:28.765', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (13, 'Richard Rice', 'Justyn_Hansen-Auer@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '875 Schroeder Viaduct', 111111111111, 2, '2023-08-13 16:54:28.841', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (14, 'Eugene Conroy', 'Marcelina.Dietrich73@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '490 Maxie Union', 111111111111, 2, '2023-08-13 16:54:28.846', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (15, 'Ramon Johnston', 'Thaddeus_Abbott91@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '10330 Keshaun Villages', 111111111111, 2, '2023-08-13 16:54:28.851', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (16, 'Esther Heller', 'Adrien.Feeney42@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '96720 Greenfelder Overpass', 111111111111, 2, '2023-08-13 16:54:28.855', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (17, 'Guy Price', 'Oran.Kirlin96@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '473 Walsh Lakes', 111111111111, 2, '2023-08-13 16:54:28.86', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (18, 'Dan Ullrich', 'Emely87@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '39155 Price Field', 111111111111, 2, '2023-08-13 16:54:28.865', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (19, 'Miss Myrtle Grant', 'Brooks75@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '9886 Beryl Fords', 111111111111, 2, '2023-08-13 16:54:28.87', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (20, 'Greg Brekke', 'Ken_Monahan@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '5355 Marley Motorway', 111111111111, 2, '2023-08-13 16:54:28.875', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (21, 'Jeannie Grimes', 'Lewis_Pfannerstill@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '3859 Grant Shore', 111111111111, 2, '2023-08-13 16:54:28.881', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (22, 'Dr. Shawna Leannon', 'Henderson62@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '2848 Burley Crescent', 111111111111, 2, '2023-08-13 16:54:29.958', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (23, 'Nellie Powlowski', 'Helena45@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '7642 Isabelle Shore', 111111111111, 2, '2023-08-13 16:54:30.046', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (24, 'Molly Wunsch', 'Paolo53@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '958 Kulas Locks', 111111111111, 2, '2023-08-13 16:54:30.052', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (1, 'Susan Heaney', 'Otilia.Murray92@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '582 Skiles Crescent', 111111111111, 2, '2023-08-13 16:50:11.879', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (2, 'Mrs. Claire Langworth', 'Brionna.Schulist46@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '36222 Breitenberg Burgs', 111111111111, 2, '2023-08-13 16:50:11.981', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (3, 'Edwin Klein', 'Reynold_Conroy90@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '409 Kobe Crossing', 111111111111, 2, '2023-08-13 16:50:11.986', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (4, 'Cedric White', 'Kane50@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '19329 Wiley Unions', 111111111111, 2, '2023-08-13 16:50:11.991', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (5, 'Agnes McLaughlin', 'Demario54@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '4865 Tierra Lights', 111111111111, 2, '2023-08-13 16:50:11.996', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (6, 'Erik Blick', 'Joey22@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '9268 Padberg Prairie', 111111111111, 2, '2023-08-13 16:50:12.001', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (7, 'Carrie Cormier PhD', 'Adaline.Zulauf81@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '2376 Wisoky Circles', 111111111111, 2, '2023-08-13 16:50:12.006', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (8, 'Miss Jane Ankunding', 'Dedric47@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '959 Thiel Parkway', 111111111111, 2, '2023-08-13 16:50:12.011', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (9, 'Fernando Zulauf-Kling', 'Devon67@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '7690 Maximilian Course', 111111111111, 2, '2023-08-13 16:50:12.016', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (10, 'Joy Botsford', 'Skye_DAmore@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '40698 Paul Vista', 111111111111, 2, '2023-08-13 16:50:12.021', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (25, 'Mrs. Gina Kuphal', 'Roselyn94@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '200 Tia Court', 111111111111, 2, '2023-08-13 16:54:30.057', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (26, 'Vera Price DDS', 'Kristian23@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '1615 Leffler Run', 111111111111, 2, '2023-08-13 16:54:30.062', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (27, 'Shirley Sanford', 'Faustino.Stanton@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '163 Nitzsche Forges', 111111111111, 2, '2023-08-13 16:54:30.067', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (28, 'Dr. Nathan Bartell', 'Dimitri_Casper@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '374 Kunde Viaduct', 111111111111, 2, '2023-08-13 16:54:30.072', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (29, 'Laurie Lakin', 'Emile85@yahoo.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '592 Rolfson Islands', 111111111111, 2, '2023-08-13 16:54:30.077', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (30, 'Adrian Greenfelder', 'Benedict_Kuhlman@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '441 Samantha Gateway', 111111111111, 2, '2023-08-13 16:54:30.082', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (31, 'Mr. Alfonso Hayes', 'Maudie_Bernier@hotmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', '786 Luella Wall', 111111111111, 2, '2023-08-13 16:54:30.087', 99999, 'faker', 1, 1);
INSERT INTO public.users VALUES (11, 'Levy Moreira Cruz', 'levy@gmail.com', '$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW', 'Rua das Orquídeas', 13566520, 1, '2023-08-14 11:59:43.441', 65, 'Cidade Jardim', 4651, 26);


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categorias_id_seq', 14, true);


--
-- Name: cidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cidade_id_seq', 1, false);


--
-- Name: estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estado_id_seq', 99, false);


--
-- Name: prestadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prestadores_id_seq', 62, true);


--
-- Name: public.apiCEP_cep_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."public.apiCEP_cep_seq"', 1, false);


--
-- Name: public.sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."public.sessions_id_seq"', 98, true);


--
-- Name: servicoSolicitado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."servicoSolicitado_id_seq"', 47, true);


--
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.servicos_id_seq', 59, true);


--
-- Name: statusServico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."statusServico_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 31, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: apiCEP apiCEP_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."apiCEP"
    ADD CONSTRAINT "apiCEP_pk" PRIMARY KEY (cep);


--
-- Name: categoriasServicos categorias_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."categoriasServicos"
    ADD CONSTRAINT categorias_pk PRIMARY KEY (id);


--
-- Name: cidade cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (id);


--
-- Name: users email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT email UNIQUE (email);


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- Name: prestadorServico prestadores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."prestadorServico"
    ADD CONSTRAINT prestadores_pkey PRIMARY KEY (id);


--
-- Name: sessions public.sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "public.sessions_token_key" UNIQUE (token);


--
-- Name: servicoSolicitado servicoSolicitado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."servicoSolicitado"
    ADD CONSTRAINT "servicoSolicitado_pkey" PRIMARY KEY (id);


--
-- Name: servicos servicos_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_pk PRIMARY KEY (id);


--
-- Name: sessions sessions_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pk PRIMARY KEY (id);


--
-- Name: statusServico statusServico_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."statusServico"
    ADD CONSTRAINT "statusServico_pk" PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: prestadorServico categoriaFk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."prestadorServico"
    ADD CONSTRAINT "categoriaFk" FOREIGN KEY ("categoriaId") REFERENCES public."categoriasServicos"(id);


--
-- Name: users cidadeId FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "cidadeId FK" FOREIGN KEY ("cidadeId") REFERENCES public.cidade(id) NOT VALID;


--
-- Name: users estadoId FK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "estadoId FK" FOREIGN KEY ("estadoId") REFERENCES public.estado(id) NOT VALID;


--
-- Name: servicos servicos_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_fk0 FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: servicos servicos_fk1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servicos
    ADD CONSTRAINT servicos_fk1 FOREIGN KEY ("categoriaId") REFERENCES public."categoriasServicos"(id);


--
-- Name: statusServico statusServico_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."statusServico"
    ADD CONSTRAINT "statusServico_fk0" FOREIGN KEY ("servicoId") REFERENCES public.servicos(id);


--
-- Name: statusServico statusServico_fk1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."statusServico"
    ADD CONSTRAINT "statusServico_fk1" FOREIGN KEY ("clienteId") REFERENCES public.users(id);


--
-- Name: statusServico statusServico_fk2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."statusServico"
    ADD CONSTRAINT "statusServico_fk2" FOREIGN KEY ("prestadorId") REFERENCES public.users(id);


--
-- Name: cidade ufFk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cidade
    ADD CONSTRAINT "ufFk" FOREIGN KEY (uf) REFERENCES public.estado(id) NOT VALID;


--
-- Name: prestadorServico userFK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."prestadorServico"
    ADD CONSTRAINT "userFK" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: sessions userFk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "userFk" FOREIGN KEY ("userId") REFERENCES public.users(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

