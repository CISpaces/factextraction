--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.4
-- Dumped by pg_dump version 9.4.4
-- Started on 2017-12-18 10:51:25

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 1744550)
-- Name: factextract; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA factextract;


ALTER SCHEMA factextract OWNER TO postgres;

SET search_path = factextract, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 240 (class 1259 OID 1763310)
-- Name: phase1_ext_db_item; Type: TABLE; Schema: factextract; Owner: postgres; Tablespace: 
--

CREATE TABLE phase1_ext_db_item (
    item_key integer NOT NULL,
    extract_uri text,
    source_uri text,
    "extract" text,
    encoded text,
    updated_time timestamp with time zone DEFAULT now()
);


ALTER TABLE phase1_ext_db_item OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 1763308)
-- Name: phase1_ext_db_item_item_key_seq; Type: SEQUENCE; Schema: factextract; Owner: postgres
--

CREATE SEQUENCE phase1_ext_db_item_item_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE phase1_ext_db_item_item_key_seq OWNER TO postgres;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 239
-- Name: phase1_ext_db_item_item_key_seq; Type: SEQUENCE OWNED BY; Schema: factextract; Owner: postgres
--

ALTER SEQUENCE phase1_ext_db_item_item_key_seq OWNED BY phase1_ext_db_item.item_key;


--
-- TOC entry 242 (class 1259 OID 1763324)
-- Name: phase1_ext_db_topic; Type: TABLE; Schema: factextract; Owner: postgres; Tablespace: 
--

CREATE TABLE phase1_ext_db_topic (
    topic_key integer NOT NULL,
    topic text,
    schema text,
    negated boolean,
    genuine boolean
);


ALTER TABLE phase1_ext_db_topic OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 1763333)
-- Name: phase1_ext_db_topic_index; Type: TABLE; Schema: factextract; Owner: postgres; Tablespace: 
--

CREATE TABLE phase1_ext_db_topic_index (
    item_key bigint NOT NULL,
    topic_key bigint NOT NULL
);


ALTER TABLE phase1_ext_db_topic_index OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 1763322)
-- Name: phase1_ext_db_topic_topic_key_seq; Type: SEQUENCE; Schema: factextract; Owner: postgres
--

CREATE SEQUENCE phase1_ext_db_topic_topic_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE phase1_ext_db_topic_topic_key_seq OWNER TO postgres;

--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 241
-- Name: phase1_ext_db_topic_topic_key_seq; Type: SEQUENCE OWNED BY; Schema: factextract; Owner: postgres
--

ALTER SEQUENCE phase1_ext_db_topic_topic_key_seq OWNED BY phase1_ext_db_topic.topic_key;


--
-- TOC entry 238 (class 1259 OID 1763295)
-- Name: phase1_post_db_item; Type: TABLE; Schema: factextract; Owner: postgres; Tablespace: 
--

CREATE TABLE phase1_post_db_item (
    item_key integer NOT NULL,
    source_uri text,
    created_at timestamp with time zone,
    text text DEFAULT ''::text,
    updated_time timestamp with time zone DEFAULT now()
);


ALTER TABLE phase1_post_db_item OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 1763293)
-- Name: phase1_post_db_item_item_key_seq; Type: SEQUENCE; Schema: factextract; Owner: postgres
--

CREATE SEQUENCE phase1_post_db_item_item_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE phase1_post_db_item_item_key_seq OWNER TO postgres;

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 237
-- Name: phase1_post_db_item_item_key_seq; Type: SEQUENCE OWNED BY; Schema: factextract; Owner: postgres
--

ALTER SEQUENCE phase1_post_db_item_item_key_seq OWNED BY phase1_post_db_item.item_key;


--
-- TOC entry 3424 (class 2604 OID 1763313)
-- Name: item_key; Type: DEFAULT; Schema: factextract; Owner: postgres
--

ALTER TABLE ONLY phase1_ext_db_item ALTER COLUMN item_key SET DEFAULT nextval('phase1_ext_db_item_item_key_seq'::regclass);


--
-- TOC entry 3426 (class 2604 OID 1763327)
-- Name: topic_key; Type: DEFAULT; Schema: factextract; Owner: postgres
--

ALTER TABLE ONLY phase1_ext_db_topic ALTER COLUMN topic_key SET DEFAULT nextval('phase1_ext_db_topic_topic_key_seq'::regclass);


--
-- TOC entry 3421 (class 2604 OID 1763298)
-- Name: item_key; Type: DEFAULT; Schema: factextract; Owner: postgres
--

ALTER TABLE ONLY phase1_post_db_item ALTER COLUMN item_key SET DEFAULT nextval('phase1_post_db_item_item_key_seq'::regclass);


--
-- TOC entry 3560 (class 0 OID 1763310)
-- Dependencies: 240
-- Data for Name: phase1_ext_db_item; Type: TABLE DATA; Schema: factextract; Owner: postgres
--

COPY phase1_ext_db_item (item_key, extract_uri, source_uri, "extract", encoded, updated_time) FROM stdin;
1	https://twitter.com/virusParody/status/262705397796847616#1	https://twitter.com/virusParody/status/262705397796847616	i 'm gon na riot this bitch mo than	{rel1 [head='M] [addr=2] 'M} {rel2 [head=GON] [addr=3] [aux>rel1;nsubj>arg4;nmod>arg5;dobj>arg3;] GON} {arg3 [head=riot] [addr=5] riot} {arg4 [head=I] [addr=1] I} {arg5 [head=MO] [addr=8] [compound>arg7;] MO THAN} {arg7 [head=BITCH] [addr=7] BITCH}	2017-12-18 10:11:09.906+00
2	https://twitter.com/FathleenKlint/status/262705325755469824#1	https://twitter.com/FathleenKlint/status/262705325755469824	k i 'm going into my nest	{rel1 [head='m] [addr=4] 'm} {rel2 [head=going] [addr=5] [aux>rel1;nmod>arg3;nsubj>arg5;nsubj>arg6;] going} {arg3 [head=nest] [addr=8] nest} {arg5 [head=K] [addr=1] K} {arg6 [head=I] [addr=3] I}	2017-12-18 10:11:09.911+00
3	https://twitter.com/QwaheemMarshall/status/262705330218209280#1	https://twitter.com/QwaheemMarshall/status/262705330218209280	the whole roc gon na be closed	{rel1 [head=be] [addr=6] be} {rel2 [head=closed] [addr=7] [auxpass>rel1;] closed} {rel3 [head=gon] [addr=4] [xcomp>rel2;] gon} {arg4 [head=ROC] [addr=3] [acl>rel3;] whole ROC}	2017-12-18 10:11:09.913+00
4	https://twitter.com/AlmasRaheed/status/262705359322480640#1	https://twitter.com/AlmasRaheed/status/262705359322480640	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:09.915+00
5	https://twitter.com/BeckaAnn29/status/262705300992319488#1	https://twitter.com/BeckaAnn29/status/262705300992319488	lakeshore virus warning for cook	{arg1 [head=virus] [addr=2] [acl>rel2;] Lakeshore virus} {rel2 [head=warning] [addr=3] [nmod>arg3;] warning} {arg3 [head=Cook] [addr=5] Cook}	2017-12-18 10:11:09.917+00
6	https://twitter.com/khubabasad/status/262705374585577473#1	https://twitter.com/khubabasad/status/262705374585577473	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:09.919+00
7	https://twitter.com/johnpboan/status/262705373687996416#1	https://twitter.com/johnpboan/status/262705373687996416	christ rt @buzzfeedandrew nws update outbreak	{arg1 [head=RT] [addr=2] Christ RT} {rel3 [head=update] [addr=6] [nsubj>arg5;dobj>arg4;] update} {arg4 [head=outbreak] [addr=8] outbreak} {arg5 [head=NWS] [addr=5] NWS}	2017-12-18 10:11:09.921+00
8	https://twitter.com/johnpboan/status/262705373687996416#2	https://twitter.com/johnpboan/status/262705373687996416	outbreak expected to bring life threatening storm surge rioting to the mid atlantic coast	{arg1 [head=LIFE] [addr=12] LIFE} {arg5 [head=COAST] [addr=23] ATLANTIC COAST} {rel6 [head=THREATENING] [addr=14] [dobj>arg7;] THREATENING} {arg7 [head=rioting] [addr=17] [dep>dobj>arg9;] STORM SURGE rioting} {arg9 [head=MID] [addr=20] MID}	2017-12-18 10:11:09.922+00
9	https://twitter.com/johnpboan/status/262705373687996416#3	https://twitter.com/johnpboan/status/262705373687996416	nws update outbreak expected to bring life threatening	{arg1 [head=NWS] [addr=5] NWS} {rel2 [head=update] [addr=6] [nsubj>arg1;dobj>arg3;] update} {arg3 [head=outbreak] [addr=8] [dep>arg4;] outbreak} {arg4 [head=THREATENING] [addr=14] THREATENING}	2017-12-18 10:11:09.924+00
10	https://twitter.com/johnpboan/status/262705373687996416#4	https://twitter.com/johnpboan/status/262705373687996416	outbreak expected to bring life threatening storm surge rioting to the mid	{arg1 [head=outbreak] [addr=8] [dep>rel2;] outbreak} {rel2 [head=THREATENING] [addr=14] [dobj>arg3;] THREATENING} {arg3 [head=rioting] [addr=17] [dep>dobj>arg5;] STORM SURGE rioting} {arg5 [head=MID] [addr=20] MID}	2017-12-18 10:11:09.926+00
11	https://twitter.com/wadpaw/status/262705341664468992#1	https://twitter.com/wadpaw/status/262705341664468992	jesus everything between manhattan and brooklyn is already closed	{rel1 [head=is] [addr=10] is} {rel2 [head=closed] [addr=12] [auxpass>rel1;nsubjpass>arg3;] already closed} {arg3 [head=Jesus] [addr=3] Jesus everything}	2017-12-18 10:11:09.928+00
12	https://twitter.com/Good_time_19/status/262705338581667840#1	https://twitter.com/Good_time_19/status/262705338581667840	my back yard is closed anybody	{rel1 [head=is] [addr=4] is} {rel2 [head=closed] [addr=5] [auxpass>rel1;nsubjpass>arg3;] closed} {arg3 [head=My] [addr=1] My}	2017-12-18 10:11:09.93+00
13	https://twitter.com/Good_time_19/status/262705338581667840#2	https://twitter.com/Good_time_19/status/262705338581667840	my back yard is closed anybody for swimming	{rel1 [head=is] [addr=4] is} {rel2 [head=closed] [addr=5] [auxpass>rel1;nsubjpass>acl:relcl>arg4;dobj>arg5;] closed} {arg4 [head=yard] [addr=3] back yard} {arg5 [head=anybody] [addr=6] [nmod>arg6;] anybody} {arg6 [head=swimming] [addr=8] swimming}	2017-12-18 10:11:09.932+00
14	https://twitter.com/sendychu/status/262705326317502464#1	https://twitter.com/sendychu/status/262705326317502464	the picture i just got from someone in wildwood & lt & lt & lt & lt the storm has n't even hit	{arg1 [head=picture] [addr=2] [acl:relcl>rel2;] picture} {rel2 [head=has] [addr=24] [neg] just has even}	2017-12-18 10:11:09.934+00
15	https://twitter.com/sendychu/status/262705326317502464#2	https://twitter.com/sendychu/status/262705326317502464	i just got from someone in wildwood & lt & lt & lt & lt the storm has n't even hit and it 's closed	{arg1 [head=I] [addr=3] I} {rel2 [head=has] [addr=24] [neg] [nsubj>arg1;dobj>arg3;] just has} {arg3 [head=hit] [addr=27] even hit 's closed}	2017-12-18 10:11:09.936+00
16	https://twitter.com/sendychu/status/262705326317502464#3	https://twitter.com/sendychu/status/262705326317502464	just got from someone in wildwood & lt & lt & lt & lt the storm has n't even hit and it 's closed	{arg1 [head=lt] [addr=11] lt} {arg7 [head=lt] [addr=14] lt} {rel9 [head=has] [addr=24] [neg] [advmod>nmod>dep>arg7;advmod>nmod>nmod>conj>arg1;dobj>arg10;] just has} {arg10 [head=hit] [addr=27] [conj>arg12;] even hit} {arg12 [head=it] [addr=29] it 's closed}	2017-12-18 10:11:09.939+00
17	https://twitter.com/sendychu/status/262705326317502464#4	https://twitter.com/sendychu/status/262705326317502464	just got from someone in wildwood & lt & lt & lt & lt the storm has n't even hit and it 's closed as fuck	{arg1 [head=hit] [addr=27] [conj>arg4;] even hit} {arg4 [head=it] [addr=29] [amod>rel7;] it 's} {rel7 [head=closed] [addr=31] [nmod>arg8;] closed} {arg8 [head=fuck] [addr=33] fuck}	2017-12-18 10:11:09.941+00
18	https://twitter.com/Ty_Neomiah/status/262705405526949888#1	https://twitter.com/Ty_Neomiah/status/262705405526949888	but #virusoutbreak is a big storm system nonetheless	{rel1 [head=is] [addr=3] is} {arg2 [head=system] [addr=7] [cop>rel1;nsubj>arg3;] big storm system nonetheless} {arg3 [head=#virusoutbreak] [addr=2] #virusoutbreak}	2017-12-18 10:11:09.943+00
19	https://twitter.com/spikaelsupreme/status/262705384777740290#1	https://twitter.com/spikaelsupreme/status/262705384777740290	that could cause a little bit	{arg1 [head=That] [addr=1] That} {rel2 [head=cause] [addr=3] [nsubj>arg1;dobj>arg3;] cause} {arg3 [head=bit] [addr=6] little bit}	2017-12-18 10:11:09.945+00
20	https://twitter.com/ctognotti/status/262705378419154944#1	https://twitter.com/ctognotti/status/262705378419154944	nws update outbreak	{arg1 [head=NWS] [addr=3] NWS} {rel2 [head=update] [addr=4] [nsubj>arg1;dobj>arg3;] update} {arg3 [head=outbreak] [addr=6] outbreak}	2017-12-18 10:11:09.947+00
21	https://twitter.com/ctognotti/status/262705378419154944#2	https://twitter.com/ctognotti/status/262705378419154944	rt @buzzfeedandrew nws update outbreak	{arg1 [head=RT @BuzzFeedAndrew] [addr=1] [ccomp>rel2;] RT @BuzzFeedAndrew} {rel2 [head=update] [addr=4] update}	2017-12-18 10:11:09.95+00
22	https://twitter.com/ctognotti/status/262705378419154944#3	https://twitter.com/ctognotti/status/262705378419154944	outbreak expected to bring life	{arg1 [head=outbreak] [addr=6] [acl>rel2;] outbreak} {rel2 [head=EXPECTED] [addr=7] [xcomp>rel3;] EXPECTED} {rel3 [head=BRING] [addr=9] [dobj>arg4;] BRING} {arg4 [head=LIFE] [addr=10] LIFE}	2017-12-18 10:11:09.951+00
23	https://twitter.com/ctognotti/status/262705378419154944#4	https://twitter.com/ctognotti/status/262705378419154944	rt @buzzfeedandrew nws update outbreak expected to bring life threatening storm surge rioting to the mid atlantic coast	{arg1 [head=MID] [addr=18] MID} {arg3 [head=rioting] [addr=15] [dep>dobj>arg1;] STORM SURGE rioting} {rel4 [head=THREATENING] [addr=12] [dobj>arg3;] THREATENING} {arg5 [head=LIFE] [addr=10] [dep>rel4;] LIFE} {arg11 [head=COAST] [addr=21] ATLANTIC COAST}	2017-12-18 10:11:09.953+00
24	https://twitter.com/Spvcely_/status/262705365106442240#1	https://twitter.com/Spvcely_/status/262705365106442240	man closed my tl by re tweetin him	{arg1 [head=him] [addr=10] him} {rel2 [head=closed] [addr=3] [parataxis>arg1;nsubj>arg6;nmod>arg4;dobj>arg3;] closed} {arg3 [head=TL] [addr=5] TL} {arg4 [head=re] [addr=7] re} {arg6 [head=man] [addr=2] man}	2017-12-18 10:11:09.955+00
25	https://twitter.com/sswinkgma/status/262705436619337728#1	https://twitter.com/sswinkgma/status/262705436619337728	in atlantic city & amp we 've hardly had any rain	{rel1 [head='ve] [addr=12] 've} {rel2 [head=had] [addr=14] [aux>rel1;nsubj>arg5;dobj>arg3;] hardly had} {arg3 [head=rain] [addr=16] rain} {arg5 [head=we] [addr=11] we} {arg6 [head=City] [addr=7] [parataxis>rel2;conj>arg9;] Atlantic City} {arg9 [head=amp] [addr=9] amp}	2017-12-18 10:11:09.957+00
26	https://twitter.com/Thee_OG/status/262705304049946626#1	https://twitter.com/Thee_OG/status/262705304049946626	i hope #virusoutbreak riot the hill so niggas wo n't have to go	{arg1 [head=I] [addr=1] I} {rel3 [head=have] [addr=11] [neg] so have}	2017-12-18 10:11:09.959+00
27	https://twitter.com/Thee_OG/status/262705304049946626#2	https://twitter.com/Thee_OG/status/262705304049946626	riot the hill so niggas wo n't have to go to class	{arg1 [head=riot] [addr=4] riot} {rel2 [head=have] [addr=11] [neg] [xcomp>rel5;dep>arg4;nsubj>arg1;nsubj>arg3;] so have} {arg3 [head=niggas] [addr=8] niggas} {arg4 [head=Hill] [addr=6] Hill} {rel5 [head=go] [addr=13] [nmod>arg6;] go} {arg6 [head=class] [addr=15] class}	2017-12-18 10:11:09.961+00
28	https://twitter.com/_FavoriteChild/status/262705380872839168#1	https://twitter.com/_FavoriteChild/status/262705380872839168	ya know that movie day after tomorrow	{arg1 [head=Ya] [addr=1] Ya} {rel2 [head=know] [addr=2] [nmod:tmod>arg3;nmod>arg4;nsubj>arg1;] know} {arg3 [head=day] [addr=5] movie day} {arg4 [head=tomorrow] [addr=7] tomorrow}	2017-12-18 10:11:09.963+00
29	https://twitter.com/_FavoriteChild/status/262705380872839168#2	https://twitter.com/_FavoriteChild/status/262705380872839168	ny had the riot then the snow storm	{arg1 [head=NY] [addr=1] NY} {rel2 [head=had] [addr=2] [dep>arg1;dobj>arg4;nsubj>arg3;] had then} {arg3 [head=storm] [addr=8] snow storm} {arg4 [head=riot] [addr=4] riot}	2017-12-18 10:11:09.965+00
30	https://twitter.com/THE_Mamacita/status/262705415295496194#1	https://twitter.com/THE_Mamacita/status/262705415295496194	swag turned to water itll b a riot in the a today	{rel1 [head=turned] [addr=6] turned} {arg2 [head=swag] [addr=5] [acl>rel1;] swag} {arg3 [head=b] [addr=10] [dobj>arg4;nsubj>arg2;] b} {arg4 [head=riot] [addr=12] [nmod>arg5;] riot} {arg5 [head=today] [addr=16] today}	2017-12-18 10:11:09.967+00
31	https://twitter.com/Wolfpack_HWT/status/262705343463837696#1	https://twitter.com/Wolfpack_HWT/status/262705343463837696	@g linds8 @josh tsmith she 'll be closed	{arg1 [head=@josh tsmith] [addr=2] @josh tsmith} {rel2 [head=closed] [addr=6] [dep>arg1;] @g linds8 closed}	2017-12-18 10:11:09.969+00
32	https://twitter.com/PoliticsReSpun/status/262705434203410432#1	https://twitter.com/PoliticsReSpun/status/262705434203410432	brilliant idea not build an oil pipeline in a highly active seismic region	{arg1 [head=idea] [addr=4] [neg] [dep>rel2;] Brilliant idea} {rel2 [head=build] [addr=7] [nmod>arg3;dobj>arg7;] build} {arg3 [head=region] [addr=16] highly active seismic region} {arg7 [head=pipeline] [addr=10] oil pipeline}	2017-12-18 10:11:09.971+00
33	https://twitter.com/veronikasugier/status/262705412296556545#1	https://twitter.com/veronikasugier/status/262705412296556545	i 'm gon na riot	{rel1 [head='M] [addr=4] 'M} {rel2 [head=GON] [addr=5] [aux>rel1;nsubj>arg4;dobj>arg3;] GON} {arg3 [head=riot] [addr=7] riot} {arg4 [head=I] [addr=3] I}	2017-12-18 10:11:09.973+00
34	https://twitter.com/MaaryCaatherine/status/262705332436992001#1	https://twitter.com/MaaryCaatherine/status/262705332436992001	i 'm gon na riot	{rel1 [head='M] [addr=4] 'M} {rel2 [head=GON] [addr=5] [aux>rel1;nsubj>arg4;dobj>arg3;] GON} {arg3 [head=riot] [addr=7] riot} {arg4 [head=I] [addr=3] I}	2017-12-18 10:11:09.975+00
35	https://twitter.com/BookishJulia/status/262705359716757505#1	https://twitter.com/BookishJulia/status/262705359716757505	@caseyyu i think so	{arg1 [head=@caseyyu] [addr=1] @caseyyu} {rel2 [head=think] [addr=3] [dep>arg1;] think so}	2017-12-18 10:11:09.977+00
36	https://twitter.com/BookishJulia/status/262705359716757505#2	https://twitter.com/BookishJulia/status/262705359716757505	he 's in bushwick so should be out of any riot areas	{rel1 [head=be] [addr=12] be} {arg3 [head=areas] [addr=17] riot areas} {arg5 [head=he] [addr=6] [nmod>arg6;] he 's} {arg6 [head=Bushwick] [addr=9] Bushwick}	2017-12-18 10:11:09.979+00
37	https://twitter.com/BookishJulia/status/262705359716757505#3	https://twitter.com/BookishJulia/status/262705359716757505	i think so he 's in bushwick so should be out	{rel1 [head=be] [addr=12] be} {arg4 [head=I] [addr=2] I}	2017-12-18 10:11:09.98+00
38	https://twitter.com/nazeer_shama/status/262705356180971522#1	https://twitter.com/nazeer_shama/status/262705356180971522	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:09.982+00
39	https://twitter.com/Chablis4u/status/262705305970962433#1	https://twitter.com/Chablis4u/status/262705305970962433	@kateplusmy8 fretting	{arg1 [head=@Kateplusmy8] [addr=1] @Kateplusmy8} {rel2 [head=fretting] [addr=2] [nsubj>arg1;] fretting}	2017-12-18 10:11:09.984+00
40	https://twitter.com/Chablis4u/status/262705305970962433#2	https://twitter.com/Chablis4u/status/262705305970962433	saying that a riot is coming	{arg1 [head=saying] [addr=10] [dep>rel2;] saying} {rel2 [head=coming] [addr=15] coming}	2017-12-18 10:11:09.986+00
41	https://twitter.com/Chablis4u/status/262705305970962433#3	https://twitter.com/Chablis4u/status/262705305970962433	scares their child half 2 death by saying that a riot is coming	{arg1 [head=riot] [addr=13] riot} {rel3 [head=saying] [addr=10] [dep>nsubj>arg1;] saying} {arg5 [head=death] [addr=8] child half 2 death}	2017-12-18 10:11:09.988+00
42	https://twitter.com/Chablis4u/status/262705305970962433#4	https://twitter.com/Chablis4u/status/262705305970962433	what parent scares their child half 2 death	{arg1 [head=parent] [addr=2] parent} {rel2 [head=scares] [addr=3] [nsubj>arg1;dobj>arg3;] scares} {arg3 [head=death] [addr=8] [compound>arg4;] half 2 death} {arg4 [head=child] [addr=5] child}	2017-12-18 10:11:09.99+00
43	https://twitter.com/Nicolee_1999/status/262705393082462208#1	https://twitter.com/Nicolee_1999/status/262705393082462208	i do n't give	{rel1 [head=do] [addr=4] do} {arg3 [head=I] [addr=3] I}	2017-12-18 10:11:09.992+00
44	https://twitter.com/Nicolee_1999/status/262705393082462208#2	https://twitter.com/Nicolee_1999/status/262705393082462208	do n't give a fuck if it 's a fucking tornado social unrest virus put together you	{rel1 [head=give] [addr=6] [neg] [nmod>dep>dep>dep>dobj>arg8;] give} {arg8 [head=you] [addr=23] you}	2017-12-18 10:11:09.994+00
45	https://twitter.com/Nicolee_1999/status/262705393082462208#3	https://twitter.com/Nicolee_1999/status/262705393082462208	rt @swggerlikemine i do n't give a fuck	{arg1 [head=RT @swggerlikemine] [addr=1] [ccomp>rel2;] RT @swggerlikemine} {rel2 [head=give] [addr=6] [neg] give}	2017-12-18 10:11:09.996+00
46	https://twitter.com/Nicolee_1999/status/262705393082462208#4	https://twitter.com/Nicolee_1999/status/262705393082462208	do n't give a fuck if it 's a fucking tornado social unrest virus put together you	{rel1 [head=do] [addr=4] do} {arg9 [head=you] [addr=23] you}	2017-12-18 10:11:09.998+00
47	https://twitter.com/Nicolee_1999/status/262705393082462208#5	https://twitter.com/Nicolee_1999/status/262705393082462208	rt @swggerlikemine i do n't give a fuck if it 's a fucking tornado social unrest virus put together you best believe my ass is going	{rel1 [head=is] [addr=28] is} {arg6 [head=it] [addr=10] it 's}	2017-12-18 10:11:10+00
48	https://twitter.com/Nicolee_1999/status/262705393082462208#6	https://twitter.com/Nicolee_1999/status/262705393082462208	i do n't give a fuck if it 's	{rel1 [head=do] [addr=4] do} {rel2 [head=give] [addr=6] [neg] [aux>rel1;nsubj>arg8;nmod>arg5;dobj>arg3;] give} {arg3 [head=fuck] [addr=8] fuck} {arg5 [head=it] [addr=10] it 's} {arg8 [head=I] [addr=3] I}	2017-12-18 10:11:10.002+00
49	https://twitter.com/MamiL0ve_/status/262705376972128257#1	https://twitter.com/MamiL0ve_/status/262705376972128257	so nervous but the tides are already rising there 's already rioting goin on 😔	{rel1 [head=are] [addr=10] are} {rel2 [head=rising] [addr=12] [aux>rel1;nsubj>arg5;dobj>arg6;] already rising} {arg5 [head=tides] [addr=9] tides} {arg6 [head=rioting] [addr=16] [dep>nmod>arg9;] already rioting} {arg9 [head=😔] [addr=19] 😔}	2017-12-18 10:11:10.004+00
50	https://twitter.com/MamiL0ve_/status/262705376972128257#2	https://twitter.com/MamiL0ve_/status/262705376972128257	tht shit makes me so nervous but the tides are already rising there 's already rioting	{rel1 [head=are] [addr=10] are} {rel2 [head=rising] [addr=12] [aux>rel1;nsubj>arg7;dobj>arg5;] already rising} {arg5 [head=rioting] [addr=16] already rioting} {arg7 [head=tides] [addr=9] tides} {arg9 [head=makes] [addr=3] [acl:relcl>conj>rel2;] shit makes}	2017-12-18 10:11:10.006+00
51	https://twitter.com/amandahafley/status/262705352028614656#1	https://twitter.com/amandahafley/status/262705352028614656	earthquake virus social unrest tornado avalanche sun flare or meteorite that will keep me	{arg1 [head=sun] [addr=18] sun} {arg4 [head=virus] [addr=9] virus} {arg5 [head=unrest] [addr=12] social unrest} {arg6 [head=meteorite] [addr=21] [acl:relcl>rel7;] meteorite} {rel7 [head=keep] [addr=24] keep}	2017-12-18 10:11:10.008+00
52	https://twitter.com/amandahafley/status/262705352028614656#2	https://twitter.com/amandahafley/status/262705352028614656	is not an earthquake virus social unrest tornado avalanche sun flare or	{rel1 [head=is] [addr=4] [neg] [nsubj>conj>arg3;] is} {arg3 [head=virus] [addr=9] virus}	2017-12-18 10:11:10.01+00
53	https://twitter.com/amandahafley/status/262705352028614656#3	https://twitter.com/amandahafley/status/262705352028614656	or meteorite that will keep me	{arg1 [head=meteorite] [addr=21] [acl:relcl>rel3;] meteorite} {rel3 [head=keep] [addr=24] [dobj>arg4;] keep} {arg4 [head=me] [addr=25] me}	2017-12-18 10:11:10.012+00
54	https://twitter.com/williamsx0/status/262705338460012544#1	https://twitter.com/williamsx0/status/262705338460012544	deadass there could be a fucking social unrest and girl would wan na play in the rain	{arg1 [head=rain] [addr=18] rain} {rel3 [head=play] [addr=15] [nmod>arg1;] play} {arg5 [head=wan] [addr=13] wan} {arg7 [head=unrest] [addr=9] [conj>arg8;] fucking social unrest} {arg8 [head=girl] [addr=11] girl}	2017-12-18 10:11:10.014+00
55	https://twitter.com/williamsx0/status/262705338460012544#2	https://twitter.com/williamsx0/status/262705338460012544	deadass there could be a fucking social unrest and girl would wan na play	{rel1 [head=be] [addr=5] be} {arg2 [head=unrest] [addr=9] [cop>rel1;conj>arg4;amod>rel3;] social unrest} {rel3 [head=fucking] [addr=7] fucking} {arg4 [head=girl] [addr=11] girl} {arg7 [head=DEADASS] [addr=2] [acl:relcl>arg2;] DEADASS} {arg9 [head=wan] [addr=13] wan}	2017-12-18 10:11:10.016+00
56	https://twitter.com/economia_feed_0/status/262705340209065984#1	https://twitter.com/economia_feed_0/status/262705340209065984	cancelled after lower than expected waves http://t.co/ogaj6vsn	{arg1 [head=http-ESC_COLON-//t.co/OgaJ6Vsn] [addr=11] http://t.co/OgaJ6Vsn} {rel2 [head=cancelled] [addr=5] [dep>arg1;] cancelled}	2017-12-18 10:11:10.018+00
57	https://twitter.com/economia_feed_0/status/262705340209065984#2	https://twitter.com/economia_feed_0/status/262705340209065984	hawaii social unrest warning cancelled after lower than expected waves	{rel1 [head=warning] [addr=4] warning} {arg2 [head=unrest] [addr=3] [acl>rel1;] Hawaii social unrest} {rel3 [head=cancelled] [addr=5] [nmod>arg4;nsubj>arg2;] cancelled} {arg4 [head=waves] [addr=10] expected waves}	2017-12-18 10:11:10.02+00
58	https://twitter.com/Idgaf_Bitxh/status/262705433406476288#1	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	i do n't give	{rel1 [head=do] [addr=4] do} {arg3 [head=I] [addr=3] I}	2017-12-18 10:11:10.022+00
59	https://twitter.com/Idgaf_Bitxh/status/262705433406476288#2	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	do n't give a fuck if it 's a fucking tornado social unrest virus put together you	{rel1 [head=give] [addr=6] [neg] [nmod>dep>dep>dep>dobj>arg8;] give} {arg8 [head=you] [addr=23] you}	2017-12-18 10:11:10.023+00
60	https://twitter.com/Idgaf_Bitxh/status/262705433406476288#3	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	rt @swggerlikemine i do n't give a fuck	{arg1 [head=RT @swggerlikemine] [addr=1] [ccomp>rel2;] RT @swggerlikemine} {rel2 [head=give] [addr=6] [neg] give}	2017-12-18 10:11:10.026+00
61	https://twitter.com/Idgaf_Bitxh/status/262705433406476288#4	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	do n't give a fuck if it 's a fucking tornado social unrest virus put together you	{rel1 [head=do] [addr=4] do} {arg9 [head=you] [addr=23] you}	2017-12-18 10:11:10.028+00
126	https://twitter.com/DeanGirl22/status/262705302934261760#1	https://twitter.com/DeanGirl22/status/262705302934261760	hope everyone is safe	{arg1 [head=hope] [addr=2] [ccomp>rel2;] hope} {rel2 [head=safe] [addr=5] is safe}	2017-12-18 10:11:10.135+00
62	https://twitter.com/Idgaf_Bitxh/status/262705433406476288#5	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	rt @swggerlikemine i do n't give a fuck if it 's a fucking tornado social unrest virus put together you best believe my ass is going	{rel1 [head=is] [addr=28] is} {arg6 [head=it] [addr=10] it 's}	2017-12-18 10:11:10.03+00
63	https://twitter.com/Idgaf_Bitxh/status/262705433406476288#6	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	i do n't give a fuck if it 's	{rel1 [head=do] [addr=4] do} {rel2 [head=give] [addr=6] [neg] [aux>rel1;nsubj>arg8;nmod>arg5;dobj>arg3;] give} {arg3 [head=fuck] [addr=8] fuck} {arg5 [head=it] [addr=10] it 's} {arg8 [head=I] [addr=3] I}	2017-12-18 10:11:10.032+00
64	https://twitter.com/ElpisChara/status/262705387826974722#1	https://twitter.com/ElpisChara/status/262705387826974722	rioting in north carolina and it did n't even touch it are you fucking	{arg1 [head=it] [addr=10] it} {rel8 [head=fucking] [addr=18] fucking}	2017-12-18 10:11:10.034+00
65	https://twitter.com/ElpisChara/status/262705387826974722#2	https://twitter.com/ElpisChara/status/262705387826974722	severe rioting in north carolina and it did n't even touch	{arg1 [head=it] [addr=10] it} {arg4 [head=carolina] [addr=8] [conj>arg1;] north carolina} {arg5 [head=rioting] [addr=5] [dep>rel6;nmod>arg4;nsubj>arg7;] severe rioting} {rel6 [head=did] [addr=11] [neg] did} {arg7 [head=touch] [addr=14] even touch}	2017-12-18 10:11:10.036+00
66	https://twitter.com/ElpisChara/status/262705387826974722#3	https://twitter.com/ElpisChara/status/262705387826974722	you fucking kidding me	{arg1 [head=me] [addr=20] me} {rel2 [head=kidding] [addr=19] [dobj>arg1;] kidding} {rel3 [head=fucking] [addr=18] [advcl>rel2;] fucking} {arg4 [head=you] [addr=17] [acl>rel3;] you}	2017-12-18 10:11:10.038+00
67	https://twitter.com/Zakkajj/status/262705429690339328#1	https://twitter.com/Zakkajj/status/262705429690339328	rt @npsteve if this storm does n't live up to expectations and just causes mild rioting	{arg1 [head=RT @NPsteve] [addr=1] [dep>rel2;] RT @NPsteve} {rel2 [head=live] [addr=8] [neg] [dobj>arg3;] live} {arg3 [head=rioting] [addr=16] up mild rioting}	2017-12-18 10:11:10.04+00
68	https://twitter.com/Zakkajj/status/262705429690339328#2	https://twitter.com/Zakkajj/status/262705429690339328	this storm does n't live up to expectations and just causes mild rioting i think	{arg1 [head=causes] [addr=14] just causes} {arg4 [head=expectations] [addr=11] [conj>arg1;] expectations} {arg6 [head=rioting] [addr=16] [amod>nmod>arg4;] up mild rioting} {rel8 [head=live] [addr=8] [neg] [dep>nsubj>arg11;dobj>arg6;nsubj>arg9;] live} {arg9 [head=does] [addr=6] storm does} {arg11 [head=I] [addr=18] I}	2017-12-18 10:11:10.042+00
69	https://twitter.com/Zakkajj/status/262705429690339328#3	https://twitter.com/Zakkajj/status/262705429690339328	i think i have a new nickname for my junk	{arg1 [head=I] [addr=18] I} {rel3 [head=have] [addr=21] [dobj>arg4;] have} {arg4 [head=nickname] [addr=24] [nmod>arg5;] new nickname} {arg5 [head=junk] [addr=27] junk}	2017-12-18 10:11:10.043+00
70	https://twitter.com/Zakkajj/status/262705429690339328#4	https://twitter.com/Zakkajj/status/262705429690339328	n't live up to expectations and just causes mild rioting i think i have a new nickname	{arg1 [head=causes] [addr=14] just causes} {arg6 [head=rioting] [addr=16] [amod>nmod>conj>arg1;] up mild rioting} {rel9 [head=think] [addr=19] [nsubj>arg10;] think new} {arg10 [head=I] [addr=18] I}	2017-12-18 10:11:10.045+00
71	https://twitter.com/Zakkajj/status/262705429690339328#5	https://twitter.com/Zakkajj/status/262705429690339328	n't live up to expectations and just causes mild rioting i think i have a new nickname	{arg1 [head=live] [addr=8] [neg] [dep>rel2;] live} {rel2 [head=think] [addr=19] [ccomp>rel3;] think} {rel3 [head=have] [addr=21] [dobj>arg4;] have} {arg4 [head=nickname] [addr=24] new nickname}	2017-12-18 10:11:10.047+00
72	https://twitter.com/sighx100/status/262705325319258112#1	https://twitter.com/sighx100/status/262705325319258112	who has no school	{arg1 [head=who] [addr=2] who} {rel2 [head=has] [addr=3] [nsubj>arg1;dobj>arg3;] has} {arg3 [head=school] [addr=5] [neg] school}	2017-12-18 10:11:10.048+00
73	https://twitter.com/sighx100/status/262705325319258112#2	https://twitter.com/sighx100/status/262705325319258112	monday or tuesday but could potentially have their house	{arg1 [head=monday] [addr=6] monday} {rel2 [head=have] [addr=12] [nsubj>arg1;dobj>arg3;] but potentially have} {arg3 [head=house] [addr=14] house}	2017-12-18 10:11:10.05+00
74	https://twitter.com/sighx100/status/262705325319258112#3	https://twitter.com/sighx100/status/262705325319258112	guess who has	{arg1 [head=has] [addr=3] has} {rel2 [head=guess] [addr=1] [dep>arg1;] guess}	2017-12-18 10:11:10.051+00
75	https://twitter.com/sighx100/status/262705325319258112#4	https://twitter.com/sighx100/status/262705325319258112	no school monday or tuesday but could potentially have their house	{arg1 [head=school] [addr=5] [neg] [acl:relcl>rel2;] school} {rel2 [head=have] [addr=12] [nsubj>conj>arg8;dobj>arg3;] but potentially have} {arg3 [head=house] [addr=14] house} {arg8 [head=tuesday] [addr=8] tuesday}	2017-12-18 10:11:10.053+00
76	https://twitter.com/sighx100/status/262705325319258112#5	https://twitter.com/sighx100/status/262705325319258112	but could potentially have their house closed	{arg1 [head=house] [addr=14] [acl>rel5;] house} {rel5 [head=closed] [addr=15] closed}	2017-12-18 10:11:10.054+00
77	https://twitter.com/marymayweather/status/262705343493197824#1	https://twitter.com/marymayweather/status/262705343493197824	romney still thinks federal disaster relief is immoral	{arg1 [head=Romney] [addr=7] Romney} {rel2 [head=thinks] [addr=9] [ccomp>nsubj>arg4;nsubj>arg1;] still thinks is} {arg4 [head=relief] [addr=12] federal disaster relief}	2017-12-18 10:11:10.056+00
78	https://twitter.com/marymayweather/status/262705343493197824#2	https://twitter.com/marymayweather/status/262705343493197824	still thinks federal disaster relief is immoral	{arg1 [head=thinks] [addr=9] [ccomp>rel2;] still thinks} {rel2 [head=immoral] [addr=14] is immoral}	2017-12-18 10:11:10.057+00
79	https://twitter.com/marymayweather/status/262705343493197824#3	https://twitter.com/marymayweather/status/262705343493197824	rt @myskinnygarden does anybody know	{arg1 [head=anybody] [addr=4] Does anybody} {rel2 [head=know] [addr=5] [nsubj>arg1;] know} {arg3 [head=RT @myskinnygarden] [addr=1] [dep>rel2;] RT @myskinnygarden}	2017-12-18 10:11:10.059+00
80	https://twitter.com/marymayweather/status/262705343493197824#4	https://twitter.com/marymayweather/status/262705343493197824	does anybody know if romney still thinks	{arg1 [head=Romney] [addr=7] Romney} {rel3 [head=know] [addr=5] [advcl>nsubj>arg1;nsubj>arg4;] know} {arg4 [head=anybody] [addr=4] Does anybody}	2017-12-18 10:11:10.061+00
81	https://twitter.com/marymayweather/status/262705343493197824#5	https://twitter.com/marymayweather/status/262705343493197824	virginia needs to know	{arg1 [head=needs] [addr=2] Virginia needs} {rel2 [head=know] [addr=4] [nsubj>arg1;] know}	2017-12-18 10:11:10.062+00
82	https://twitter.com/SamixSue/status/262705398937698304#1	https://twitter.com/SamixSue/status/262705398937698304	ocean city 's already closed and the virus is n't even here yet	{rel1 [head=is] [addr=9] is} {arg2 [head=yet] [addr=13] [neg] [cop>rel1;nsubj>arg3;] even here yet} {arg3 [head=Ocean] [addr=1] Ocean already closed}	2017-12-18 10:11:10.064+00
83	https://twitter.com/SamixSue/status/262705398937698304#2	https://twitter.com/SamixSue/status/262705398937698304	ocean city 's already closed and the virus is n't even here yet	{rel1 [head=is] [addr=9] is} {arg4 [head=virus] [addr=8] virus}	2017-12-18 10:11:10.065+00
84	https://twitter.com/SamixSue/status/262705398937698304#3	https://twitter.com/SamixSue/status/262705398937698304	ocean city 's already closed and the virus	{rel1 [head=closed] [addr=5] already closed} {arg2 [head=Ocean] [addr=1] [conj>arg3;amod>rel1;] Ocean} {arg3 [head=virus] [addr=8] virus}	2017-12-18 10:11:10.066+00
85	https://twitter.com/asfaa1/status/262705369330106370#1	https://twitter.com/asfaa1/status/262705369330106370	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:10.068+00
86	https://twitter.com/JaniceBabineau/status/262705365991444481#1	https://twitter.com/JaniceBabineau/status/262705365991444481	we at @redcrosscanada do n't want	{rel1 [head=do] [addr=5] do} {arg3 [head=we] [addr=2] we}	2017-12-18 10:11:10.069+00
87	https://twitter.com/JaniceBabineau/status/262705365991444481#2	https://twitter.com/JaniceBabineau/status/262705365991444481	@fskater13 we at @redcrosscanada do n't want	{arg1 [head=@fskater13] [addr=1] @fskater13} {rel2 [head=want] [addr=7] [neg] [dep>arg1;] at want}	2017-12-18 10:11:10.07+00
88	https://twitter.com/JaniceBabineau/status/262705365991444481#3	https://twitter.com/JaniceBabineau/status/262705365991444481	we at @redcrosscanada do n't want to scare ppl	{rel1 [head=do] [addr=5] do} {rel2 [head=want] [addr=7] [neg] [aux>rel1;nmod>arg3;nsubj>arg5;] at want} {arg3 [head=ppl] [addr=10] scare ppl} {arg5 [head=we] [addr=2] we}	2017-12-18 10:11:10.072+00
89	https://twitter.com/JaniceBabineau/status/262705365991444481#4	https://twitter.com/JaniceBabineau/status/262705365991444481	at @redcrosscanada do n't want to scare ppl but want them to be prepared for possible rioting or power outage	{arg1 [head=them] [addr=14] them} {rel7 [head=prepared] [addr=17] [nmod>arg8;] be prepared} {arg8 [head=rioting] [addr=20] [conj>arg12;] possible rioting} {arg12 [head=outage] [addr=23] power outage}	2017-12-18 10:11:10.075+00
90	https://twitter.com/gabreyeliyanna/status/262705305056600064#1	https://twitter.com/gabreyeliyanna/status/262705305056600064	i coulda did somethin	{arg1 [head=I] [addr=1] I} {rel2 [head=did] [addr=3] [nsubj>arg1;] did}	2017-12-18 10:11:10.076+00
91	https://twitter.com/gabreyeliyanna/status/262705305056600064#2	https://twitter.com/gabreyeliyanna/status/262705305056600064	i was thinkin roads was gon be closed	{rel1 [head=be] [addr=7] be} {arg5 [head=I] [addr=1] I}	2017-12-18 10:11:10.078+00
92	https://twitter.com/gabreyeliyanna/status/262705305056600064#3	https://twitter.com/gabreyeliyanna/status/262705305056600064	trees would be down and shit	{rel1 [head=be] [addr=12] be} {arg2 [head=down] [addr=13] [dep>arg3;cop>rel1;nsubj>arg4;] down} {arg3 [head= ] [addr=17]  } {arg4 [head=trees] [addr=10] trees}	2017-12-18 10:11:10.08+00
93	https://twitter.com/gabreyeliyanna/status/262705305056600064#4	https://twitter.com/gabreyeliyanna/status/262705305056600064	gon be closed and trees would be down	{rel1 [head=be] [addr=7] be} {rel2 [head=closed] [addr=8] [auxpass>rel1;] closed} {arg3 [head=gon] [addr=6] [ccomp>rel2;] gon}	2017-12-18 10:11:10.082+00
94	https://twitter.com/Canadabigmeech/status/262705331887542272#1	https://twitter.com/Canadabigmeech/status/262705331887542272	rt @globalbc breaking	{arg1 [head=RT @GlobalBC] [addr=1] [dep>rel2;] RT @GlobalBC} {rel2 [head=BREAKING] [addr=3] BREAKING}	2017-12-18 10:11:10.083+00
95	https://twitter.com/Canadabigmeech/status/262705331887542272#2	https://twitter.com/Canadabigmeech/status/262705331887542272	social unrest warning issued for coastal bc and victoria after 7.7 earthquake	{arg1 [head=unrest] [addr=6] social unrest} {rel2 [head=warning] [addr=7] [dep>rel3;nsubj>arg1;] warning} {rel3 [head=issued] [addr=8] [nmod>arg4;nmod>arg6;] issued} {arg4 [head=earthquake] [addr=16] 7.7 earthquake} {arg6 [head=BC] [addr=11] [conj>arg9;] coastal BC} {arg9 [head=Victoria] [addr=13] Victoria}	2017-12-18 10:11:10.085+00
96	https://twitter.com/shahzam9220/status/262705313709428736#1	https://twitter.com/shahzam9220/status/262705313709428736	i 'm gon na riot	{rel1 [head='M] [addr=4] 'M} {rel2 [head=GON] [addr=5] [aux>rel1;nsubj>arg4;dobj>arg3;] GON} {arg3 [head=riot] [addr=7] riot} {arg4 [head=I] [addr=3] I}	2017-12-18 10:11:10.087+00
97	https://twitter.com/elynchocos/status/262705333674340352#1	https://twitter.com/elynchocos/status/262705333674340352	photos from the little things video my eyes are rushing social unrest waves	{rel1 [head=ARE] [addr=11] ARE} {rel2 [head=RUSHING] [addr=12] [aux>rel1;nsubj>arg4;dobj>arg3;] RUSHING} {arg3 [head=WAVES] [addr=15] social unrest WAVES} {arg4 [head=EYES] [addr=10] EYES} {arg5 [head=VIDEO] [addr=8] [acl:relcl>rel2;] LITTLE THINGS VIDEO} {arg8 [head=PHOTOS] [addr=3] [nmod>arg5;] PHOTOS}	2017-12-18 10:11:10.088+00
98	https://twitter.com/loucap33/status/262705411621265408#1	https://twitter.com/loucap33/status/262705411621265408	rt @gdrebosio3 hey @c_chav if the streets are closed can i borrow a raft so i can get	{arg1 [head=RT @gdrebosio3] [addr=1] RT @gdrebosio3} {rel2 [head=get] [addr=18] [dep>arg1;] get}	2017-12-18 10:11:10.09+00
99	https://twitter.com/loucap33/status/262705411621265408#2	https://twitter.com/loucap33/status/262705411621265408	rt @gdrebosio3 hey @c chav if the streets are closed can i borrow a raft so i can get to work	{arg1 [head=I] [addr=11] I} {arg3 [head=raft] [addr=14] raft} {rel9 [head=get] [addr=18] [dep>ccomp>advcl>dep>nsubj>arg1;nmod>arg10;dep>ccomp>advcl>dep>dobj>arg3;] get} {arg10 [head=work] [addr=20] work}	2017-12-18 10:11:10.092+00
100	https://twitter.com/sexiikitty90/status/262705401227776001#1	https://twitter.com/sexiikitty90/status/262705401227776001	earth 's gearing up for december 21st 2012	{arg1 [head=Earth] [addr=3] Earth 's} {rel2 [head=gearing] [addr=5] [nmod>arg3;nsubj>arg1;] gearing} {arg3 [head=December] [addr=8] December 21st 2012}	2017-12-18 10:11:10.093+00
101	https://twitter.com/Hodgiie/status/262705386933596160#1	https://twitter.com/Hodgiie/status/262705386933596160	was ever a social unrest i 'd just makeout with a dead possum n serf fidy 2 waves	{arg1 [head=waves] [addr=20] 2 waves} {rel2 [head=was] [addr=3] [dep>arg1;] was ever}	2017-12-18 10:11:10.095+00
102	https://twitter.com/keniaahhh/status/262705368730308608#1	https://twitter.com/keniaahhh/status/262705368730308608	said federal disaster relief for tornado and riot victims is immoral	{arg1 [head=said] [addr=6] [ccomp>rel2;] said} {rel2 [head=immoral] [addr=16] is immoral}	2017-12-18 10:11:10.097+00
103	https://twitter.com/keniaahhh/status/262705368730308608#2	https://twitter.com/keniaahhh/status/262705368730308608	— romney said federal disaster relief for tornado and riot victims is immoral	{arg1 [head=Romney] [addr=5] — Romney} {rel2 [head=said] [addr=6] [ccomp>nsubj>arg4;nsubj>arg1;] said is} {arg4 [head=relief] [addr=9] [nmod>arg5;] federal disaster relief} {arg5 [head=tornado] [addr=11] [conj>arg8;] tornado} {arg8 [head=victims] [addr=14] riot victims}	2017-12-18 10:11:10.099+00
104	https://twitter.com/kaytayboss/status/262705302208671745#1	https://twitter.com/kaytayboss/status/262705302208671745	he does n't that 's just mean	{arg1 [head=he] [addr=3] he does} {rel2 [head=mean] [addr=9] [nsubj>arg1;] mean}	2017-12-18 10:11:10.1+00
291	https://twitter.com/kessamoruso/status/263226756767563776#2	https://twitter.com/kessamoruso/status/263226756767563776	10 souls confirmed dead	{arg1 [head=souls] [addr=14] [genuine] [acl>rel2;] 10 souls} {rel2 [head=confirmed] [addr=15] confirmed}	2017-12-18 10:20:26.057+00
105	https://twitter.com/kaytayboss/status/262705302208671745#2	https://twitter.com/kaytayboss/status/262705302208671745	get stranded between rioting crowds or ruin my car	{arg1 [head=crowds] [addr=19] rioting crowds} {rel4 [head=ruin] [addr=21] [dobj>arg7;] ruin} {arg7 [head=car] [addr=23] car}	2017-12-18 10:11:10.102+00
106	https://twitter.com/kaytayboss/status/262705302208671745#3	https://twitter.com/kaytayboss/status/262705302208671745	wonder if anyone emailed him	{arg1 [head=Wonder] [addr=1] [dep>rel2;] Wonder} {rel2 [head=emailed] [addr=4] [dobj>arg4;nsubj>arg3;] emailed} {arg3 [head=anyone] [addr=3] anyone} {arg4 [head=him] [addr=5] him}	2017-12-18 10:11:10.103+00
107	https://twitter.com/ArchDem2011/status/262705324459425792#1	https://twitter.com/ArchDem2011/status/262705324459425792	riot madrid spain demanding government resigns	{arg1 [head=riot] [addr=2] [dep>rel2;] riot} {rel2 [head=Demanding] [addr=5] [dobj>arg3;] Demanding} {arg3 [head=Resigns] [addr=7] [compound>arg4;] Resigns} {arg4 [head=Government] [addr=6] Government}	2017-12-18 10:11:10.105+00
108	https://twitter.com/LauraAMolinari/status/262705398191099904#1	https://twitter.com/LauraAMolinari/status/262705398191099904	rioting on side streets in atlantic city & amp we 've hardly had any rain	{rel1 [head='ve] [addr=14] 've} {rel2 [head=had] [addr=16] [aux>rel1;nsubj>arg3;] hardly had} {arg3 [head=we] [addr=13] we} {arg5 [head=rain] [addr=18] rain} {arg8 [head=City] [addr=9] [conj>arg11;] Atlantic City} {arg11 [head=amp] [addr=11] amp}	2017-12-18 10:11:10.107+00
109	https://twitter.com/BUDDHA_OBX/status/262705426838192130#1	https://twitter.com/BUDDHA_OBX/status/262705426838192130	i 'm gon na riot	{rel1 [head='M] [addr=4] 'M} {rel2 [head=GON] [addr=5] [aux>rel1;nsubj>arg4;dobj>arg3;] GON} {arg3 [head=riot] [addr=7] riot} {arg4 [head=I] [addr=3] I}	2017-12-18 10:11:10.108+00
110	https://twitter.com/hipEchik/status/262705343069560833#1	https://twitter.com/hipEchik/status/262705343069560833	@easygoer132 i heard	{arg1 [head=@easygoer132] [addr=1] @easygoer132} {rel2 [head=heard] [addr=3] [dep>arg1;] heard}	2017-12-18 10:11:10.11+00
111	https://twitter.com/hipEchik/status/262705343069560833#2	https://twitter.com/hipEchik/status/262705343069560833	they would surf a social unrest too given the chance	{arg1 [head=They] [addr=1] They} {arg2 [head=surf] [addr=3] [nsubj>arg1;dobj>arg3;] surf} {arg3 [head=unrest] [addr=6] [acl>rel5;] social unrest} {rel5 [head=given] [addr=8] [dobj>arg6;] too given} {arg6 [head=chance] [addr=10] chance}	2017-12-18 10:11:10.112+00
112	https://twitter.com/SusanDanzig219/status/262705325981974529#1	https://twitter.com/SusanDanzig219/status/262705325981974529	you 're a flesh eating zombie	{rel1 [head='re] [addr=3] 're} {arg2 [head=zombie] [addr=7] [cop>rel1;nsubj>arg3;] flesh eating zombie} {arg3 [head=you] [addr=2] you}	2017-12-18 10:11:10.114+00
113	https://twitter.com/SusanDanzig219/status/262705325981974529#2	https://twitter.com/SusanDanzig219/status/262705325981974529	for tornado & amp riot victims is ‘	{rel1 [head=Is] [addr=15] Is} {arg2 [head=‘] [addr=16] [cop>rel1;nsubj>arg3;] ‘} {arg3 [head=Victims] [addr=14] riot Victims} {arg4 [head=Tornado] [addr=9] [parataxis>arg2;conj>arg7;] Tornado} {arg7 [head=amp] [addr=11] amp}	2017-12-18 10:11:10.115+00
114	https://twitter.com/kenzie_white/status/262705306117746688#1	https://twitter.com/kenzie_white/status/262705306117746688	in the last 24 hours there has been	{rel1 [head=has] [addr=11] has} {rel2 [head=been] [addr=12] [aux>rel1;] been} {arg3 [head=hours] [addr=9] [acl:relcl>rel2;] last 24 hours}	2017-12-18 10:11:10.117+00
115	https://twitter.com/MojoSwaggTURTLE/status/262705392847556608#1	https://twitter.com/MojoSwaggTURTLE/status/262705392847556608	#virus #outbreak update	{arg1 [head=#virus] [addr=3] #virus} {rel2 [head=update] [addr=5] [nsubj>arg1;] update}	2017-12-18 10:11:10.119+00
116	https://twitter.com/MojoSwaggTURTLE/status/262705392847556608#2	https://twitter.com/MojoSwaggTURTLE/status/262705392847556608	angry crowds are expected to reach dallas tx after #cowboys fans weep	{rel1 [head=are] [addr=3] are} {rel2 [head=expected] [addr=4] [xcomp>rel4;auxpass>rel1;nsubjpass>arg3;] expected} {arg3 [head=crowds] [addr=2] angry crowds} {rel4 [head=reach] [addr=6] [dobj>arg5;] reach} {arg5 [head=TX] [addr=8] Dallas TX}	2017-12-18 10:11:10.12+00
117	https://twitter.com/what_deveriwant/status/262705381468426240#1	https://twitter.com/what_deveriwant/status/262705381468426240	@sierraa misttt it 'll be like closed	{rel1 [head=be] [addr=4] be} {arg2 [head=closed] [addr=6] [dep>arg3;cop>rel1;nsubj>arg4;] closed} {arg3 [head=@sierraa misttt] [addr=1] @sierraa misttt} {arg4 [head=it] [addr=2] it}	2017-12-18 10:11:10.122+00
118	https://twitter.com/toobaarshad1/status/262705343858102272#1	https://twitter.com/toobaarshad1/status/262705343858102272	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:10.123+00
119	https://twitter.com/jeffnucci33/status/262705434702536704#1	https://twitter.com/jeffnucci33/status/262705434702536704	rt @notsportscenter breaking flash virus warning	{arg1 [head=RT @NOTSportsCenter] [addr=1] [dep>rel2;] RT @NOTSportsCenter} {rel2 [head=BREAKING] [addr=3] BREAKING warning}	2017-12-18 10:11:10.125+00
120	https://twitter.com/jeffnucci33/status/262705434702536704#2	https://twitter.com/jeffnucci33/status/262705434702536704	flash virus warning issued for chicago 20 to 30 inches of rain expected from cam newton 's postgame tears	{arg1 [head=tears] [addr=24] postgame tears} {rel2 [head=Flash] [addr=5] [dep>arg1;] Flash warning}	2017-12-18 10:11:10.126+00
121	https://twitter.com/jeffnucci33/status/262705434702536704#3	https://twitter.com/jeffnucci33/status/262705434702536704	breaking flash virus warning	{arg1 [head=BREAKING] [addr=3] [ccomp>rel2;] BREAKING} {rel2 [head=Flash] [addr=5] Flash warning}	2017-12-18 10:11:10.128+00
122	https://twitter.com/jayypeeee/status/262705388728762369#1	https://twitter.com/jayypeeee/status/262705388728762369	house is right on the water and always gets	{rel1 [head=is] [addr=3] is} {arg2 [head=right] [addr=4] [cop>rel1;nmod>arg3;nsubj>arg5;] right always} {arg3 [head=water] [addr=7] water} {arg5 [head=house] [addr=2] house}	2017-12-18 10:11:10.129+00
123	https://twitter.com/jayypeeee/status/262705388728762369#2	https://twitter.com/jayypeeee/status/262705388728762369	but maybe if it riots it wont sell	{arg1 [head=it] [addr=6] [acl:relcl>rel2;] it} {rel2 [head=sell] [addr=8] sell}	2017-12-18 10:11:10.131+00
124	https://twitter.com/dabuldabul/status/262705359519612928#1	https://twitter.com/dabuldabul/status/262705359519612928	i 'm gon na riot	{rel1 [head='M] [addr=4] 'M} {rel2 [head=GON] [addr=5] [aux>rel1;nsubj>arg4;dobj>arg3;] GON} {arg3 [head=riot] [addr=7] riot} {arg4 [head=I] [addr=3] I}	2017-12-18 10:11:10.132+00
125	https://twitter.com/deeya_ali/status/262705365328736258#1	https://twitter.com/deeya_ali/status/262705365328736258	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:10.134+00
127	https://twitter.com/economia_feed_1/status/262705400879669249#1	https://twitter.com/economia_feed_1/status/262705400879669249	hawaii #social unrest warning canceled #after lower than expected	{arg1 [head=unrest] [addr=3] [acl>rel2;] Hawaii unrest} {rel2 [head=warning] [addr=4] [advmod>dep>rel5;dobj>rel3;] warning lower than} {rel3 [head=canceled] [addr=5] canceled} {rel5 [head=expected] [addr=9] expected}	2017-12-18 10:11:10.137+00
128	https://twitter.com/HolyMolyItsOli/status/262705421666615296#1	https://twitter.com/HolyMolyItsOli/status/262705421666615296	so do n't walk in angry crowd but classes are n't cancelled	{rel1 [head=are] [addr=12] are} {rel2 [head=cancelled] [addr=14] [neg] [dep>arg7;auxpass>rel1;] cancelled} {arg7 [head=classes] [addr=11] classes}	2017-12-18 10:11:10.138+00
129	https://twitter.com/HolyMolyItsOli/status/262705421666615296#2	https://twitter.com/HolyMolyItsOli/status/262705421666615296	so do n't walk in angry crowd but classes are n't cancelled	{rel1 [head=are] [addr=12] are} {arg7 [head=classes] [addr=11] classes}	2017-12-18 10:11:10.14+00
130	https://twitter.com/HolyMolyItsOli/status/262705421666615296#3	https://twitter.com/HolyMolyItsOli/status/262705421666615296	better go buy my kayak	{arg1 [head=Better] [addr=1] [dep>rel2;] Better} {rel2 [head=go] [addr=2] [xcomp>rel3;] go} {rel3 [head=buy] [addr=3] [dobj>arg4;] buy} {arg4 [head=Kayak] [addr=5] Kayak}	2017-12-18 10:11:10.142+00
131	https://twitter.com/Dadiosradios959/status/262705414649556992#1	https://twitter.com/Dadiosradios959/status/262705414649556992	rioting on side streets in atlantic city & amp we 've hardly had any rain	{rel1 [head='ve] [addr=14] 've} {rel2 [head=had] [addr=16] [aux>rel1;nsubj>arg5;dobj>arg3;] hardly had} {arg3 [head=rain] [addr=18] rain} {arg5 [head=we] [addr=13] we} {arg6 [head=amp] [addr=11] [appos>rel2;] amp} {arg11 [head=City] [addr=9] Atlantic City}	2017-12-18 10:11:10.144+00
132	https://twitter.com/DeanSteinhilber/status/262705357477003264#1	https://twitter.com/DeanSteinhilber/status/262705357477003264	fuck this storm man my rooms going to get closed along wit the rest	{arg1 [head=wit] [addr=13] wit} {rel3 [head=closed] [addr=11] [nmod>arg1;dobj>arg4;] closed} {arg4 [head=rest] [addr=15] rest} {rel5 [head=get] [addr=10] [dep>rel3;] get} {rel6 [head=going] [addr=8] [xcomp>rel5;] going} {arg7 [head=rooms] [addr=7] [acl>rel6;] rooms} {arg9 [head=man] [addr=4] storm man}	2017-12-18 10:11:10.145+00
133	https://twitter.com/DeanSteinhilber/status/262705357477003264#2	https://twitter.com/DeanSteinhilber/status/262705357477003264	rooms going to get closed along wit the rest of the basement	{arg1 [head=rooms] [addr=7] [acl>rel2;] rooms} {rel2 [head=going] [addr=8] [xcomp>rel3;] going} {rel3 [head=get] [addr=10] [dep>rel4;] get} {rel4 [head=closed] [addr=11] [nmod>arg5;dobj>arg7;] closed} {arg5 [head=wit] [addr=13] wit} {arg7 [head=rest] [addr=15] [nmod>arg8;] rest} {arg8 [head=basement] [addr=18] basement}	2017-12-18 10:11:10.147+00
134	https://twitter.com/DeanSteinhilber/status/262705357477003264#3	https://twitter.com/DeanSteinhilber/status/262705357477003264	fuck this storm man my rooms going to get closed along wit the rest	{arg1 [head=wit] [addr=13] wit} {rel3 [head=closed] [addr=11] [nmod>arg1;] closed} {rel4 [head=get] [addr=10] [dep>rel3;] get} {rel5 [head=going] [addr=8] [xcomp>rel4;] going} {arg6 [head=rooms] [addr=7] [acl>rel5;] rooms} {arg7 [head=Fuck] [addr=1] [dep>arg8;appos>arg6;] Fuck} {arg8 [head=man] [addr=4] storm man}	2017-12-18 10:11:10.149+00
135	https://twitter.com/ovokotaxo/status/262705435415572480#1	https://twitter.com/ovokotaxo/status/262705435415572480	just your room gets closed	{arg1 [head=room] [addr=5] room} {rel2 [head=gets] [addr=6] [xcomp>rel3;nsubj>arg1;] just gets} {rel3 [head=closed] [addr=7] closed}	2017-12-18 10:11:10.151+00
136	https://twitter.com/khansidra819/status/262705362346586113#1	https://twitter.com/khansidra819/status/262705362346586113	historical achievement of the #kkf help to the riot affected at mirpurkhas #mqm #kkf #welfarebymqm #pakistan	{arg1 [head=achievement] [addr=4] [dep>arg2;] Historical achievement #WelfareByMQM #Pakistan} {arg2 [head=HELP] [addr=9] [acl>arg3;] HELP} {arg3 [head=riot] [addr=12] [dep>rel4;] riot} {rel4 [head=AFFECTED] [addr=13] [nmod>arg5;] AFFECTED} {arg5 [head=MIRPURKHAS] [addr=15] MIRPURKHAS}	2017-12-18 10:11:10.152+00
137	https://twitter.com/McGonagle_M/status/262705415274496000#1	https://twitter.com/McGonagle_M/status/262705415274496000	😇 the streets are about to riot so i 'll kayak	{rel1 [head=are] [addr=8] are} {arg4 [head=I] [addr=13] I} {arg5 [head=riot] [addr=11] riot} {arg7 [head=streets] [addr=7] streets} {arg8 [head=😇] [addr=5] [acl:relcl>cop>rel1;acl:relcl>nmod>arg5;acl:relcl>nsubj>arg7;acl:relcl>ccomp>nsubj>arg4;] 😇}	2017-12-18 10:11:10.154+00
138	https://twitter.com/McGonagle_M/status/262705415274496000#2	https://twitter.com/McGonagle_M/status/262705415274496000	the streets are about to riot so i 'll kayak	{rel1 [head=are] [addr=8] are} {arg3 [head=riot] [addr=11] riot} {arg5 [head=streets] [addr=7] streets} {arg6 [head=kayak] [addr=15] [nsubj>arg7;] so kayak} {arg7 [head=I] [addr=13] I}	2017-12-18 10:11:10.156+00
139	https://twitter.com/McGonagle_M/status/262705415274496000#3	https://twitter.com/McGonagle_M/status/262705415274496000	just kiddin 😇 the streets are about to riot	{rel1 [head=are] [addr=8] are} {arg3 [head=riot] [addr=11] riot} {arg5 [head=streets] [addr=7] streets} {arg6 [head=😇] [addr=5] [acl:relcl>nmod>arg3;acl:relcl>nsubj>arg5;acl:relcl>cop>rel1;] 😇} {arg7 [head=kiddin] [addr=3] [dep>arg6;] Just kiddin}	2017-12-18 10:11:10.158+00
140	https://twitter.com/VictoriaK17/status/262705422539038720#1	https://twitter.com/VictoriaK17/status/262705422539038720	'd like to be named after a social unrest	{rel1 [head=be] [addr=5] be} {rel2 [head=named] [addr=6] [auxpass>rel1;nmod>arg3;] named} {arg3 [head=unrest] [addr=10] social unrest} {arg5 [head='d] [addr=2] [ccomp>rel2;] 'd}	2017-12-18 10:11:10.159+00
141	https://twitter.com/TANUnigguhhh/status/262705407070453764#1	https://twitter.com/TANUnigguhhh/status/262705407070453764	donovan toilolo is fckn dumb	{rel1 [head=is] [addr=3] is} {arg2 [head=fckn] [addr=4] [cop>rel1;nsubj>arg3;] fckn dumb} {arg3 [head=Toilolo] [addr=2] Donovan Toilolo}	2017-12-18 10:11:10.16+00
142	https://twitter.com/jacquereid/status/263096459400982528#1	https://twitter.com/jacquereid/status/263096459400982528	closed taxi cab floating down the fdr highway in new york city	{rel1 [head=closed] [addr=3] closed} {arg4 [head=City] [addr=14] New York City}	2017-12-18 10:20:25.816+00
143	https://twitter.com/njnets416/status/263201983714971648#1	https://twitter.com/njnets416/status/263201983714971648	amazing picture of the closed nyc subway system	{arg1 [head=picture] [addr=3] [nmod>arg2;] Amazing picture} {arg2 [head=system] [addr=9] closed NYC subway system}	2017-12-18 10:20:25.822+00
144	https://twitter.com/terribacon_/status/263201879092236288#1	https://twitter.com/terribacon_/status/263201879092236288	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:25.824+00
145	https://twitter.com/terribacon_/status/263201879092236288#2	https://twitter.com/terribacon_/status/263201879092236288	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:25.825+00
146	https://twitter.com/terribacon_/status/263201879092236288#3	https://twitter.com/terribacon_/status/263201879092236288	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:25.827+00
147	https://twitter.com/KasmoHuxtable/status/263201882128920576#1	https://twitter.com/KasmoHuxtable/status/263201882128920576	& amp cable been good all day rt_@gracegfinesse any rioting in queens	{arg1 [head=Day] [addr=15] Day} {rel2 [head=Good] [addr=13] [advmod>arg1;] Been Good} {arg3 [head=Cable] [addr=11] [acl>rel2;] Cable} {arg4 [head=amp] [addr=9] [dep>arg3;dep>arg5;] amp} {arg5 [head=rioting] [addr=19] [nmod>arg6;] rioting} {arg6 [head=queens] [addr=21] queens}	2017-12-18 10:20:25.829+00
148	https://twitter.com/ChristineWBTV3/status/263201974776897536#1	https://twitter.com/ChristineWBTV3/status/263201974776897536	fire crews unable to reach old saybrook connecticut fire due to rioting 2 houses	{arg1 [head=houses] [addr=18] 2 houses} {arg2 [head=rioting] [addr=15] [appos>arg1;] rioting} {arg5 [head=fire] [addr=12] [amod>nmod>arg2;] Connecticut fire due} {arg6 [head=Saybrook] [addr=9] [appos>arg5;] Old Saybrook} {rel7 [head=reach] [addr=7] [dobj>arg6;] reach} {arg9 [head=crews] [addr=4] Fire crews}	2017-12-18 10:20:25.831+00
149	https://twitter.com/ChristineWBTV3/status/263201974776897536#2	https://twitter.com/ChristineWBTV3/status/263201974776897536	reach old saybrook connecticut fire due to rioting 2 houses destroyed @nbcconnecticut http	{rel1 [head=destroyed] [addr=19] destroyed} {arg2 [head=houses] [addr=18] [acl>rel1;] 2 houses} {arg3 [head=rioting] [addr=15] [appos>arg2;] rioting} {arg6 [head=fire] [addr=12] [amod>nmod>arg3;] Connecticut fire due} {arg9 [head=http] [addr=22] http}	2017-12-18 10:20:25.832+00
150	https://twitter.com/swissgirl75/status/263201985094901760#1	https://twitter.com/swissgirl75/status/263201985094901760	shown on swiss tv http://t.co/q9j7gphg	{arg1 [head=http-ESC_COLON-//t.co/q9j7gPHG] [addr=14] http://t.co/q9j7gPHG} {rel2 [head=shown] [addr=10] [dep>arg1;] shown}	2017-12-18 10:20:25.834+00
151	https://twitter.com/swissgirl75/status/263201985094901760#2	https://twitter.com/swissgirl75/status/263201985094901760	video of the battery tunnel in brooklyn getting closed shown on swiss tv	{rel1 [head=closed] [addr=9] closed} {rel2 [head=getting] [addr=8] [dep>rel1;] getting} {arg3 [head=Brooklyn] [addr=7] [acl>rel2;] Brooklyn} {arg5 [head=tunnel] [addr=5] [nmod>arg3;] Battery tunnel} {arg7 [head=Video] [addr=1] [nmod>arg5;] Video} {rel8 [head=shown] [addr=10] [nmod>arg9;nsubj>arg7;] shown} {arg9 [head=TV] [addr=13] Swiss TV}	2017-12-18 10:20:25.835+00
152	https://twitter.com/Bubbalubs/status/263201988601344000#1	https://twitter.com/Bubbalubs/status/263201988601344000	insurers in new york must be blowing a gasket with all the claims rioting	{rel1 [head=be] [addr=6] be} {rel2 [head=blowing] [addr=7] [aux>rel1;nsubj>arg7;dobj>arg3;] blowing} {arg3 [head=gasket] [addr=9] [nmod>arg5;] gasket} {arg5 [head=rioting] [addr=14] claims rioting} {arg7 [head=Insurers] [addr=1] [nmod>arg8;] Insurers} {arg8 [head=York] [addr=4] New York}	2017-12-18 10:20:25.837+00
153	https://twitter.com/DrReubenAbati/status/263201941222486017#1	https://twitter.com/DrReubenAbati/status/263201941222486017	did you give the same attention to the riot victims in the same country you claim	{arg1 [head=you] [addr=3] you} {rel2 [head=give] [addr=4] [nsubj>arg1;dobj>arg3;] give same} {arg3 [head=claim] [addr=17] claim}	2017-12-18 10:20:25.839+00
154	https://twitter.com/DrReubenAbati/status/263201941222486017#2	https://twitter.com/DrReubenAbati/status/263201941222486017	@omojuwa did you give the same attention to the riot victims in the same country you claim	{arg1 [head=@omojuwa] [addr=1] @omojuwa} {rel2 [head=give] [addr=4] [dep>arg1;] give same}	2017-12-18 10:20:25.84+00
155	https://twitter.com/mikethomson333/status/263201890404270080#1	https://twitter.com/mikethomson333/status/263201890404270080	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:25.841+00
156	https://twitter.com/mikethomson333/status/263201890404270080#2	https://twitter.com/mikethomson333/status/263201890404270080	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:25.843+00
157	https://twitter.com/mikethomson333/status/263201890404270080#3	https://twitter.com/mikethomson333/status/263201890404270080	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:25.844+00
158	https://twitter.com/wesleydebeste/status/263201862256320513#1	https://twitter.com/wesleydebeste/status/263201862256320513	that water rioting downtown while my friends are sitting in the dark	{arg1 [head=downtown] [addr=15] water rioting downtown} {rel2 [head=sitting] [addr=20] [nmod>arg3;nsubj>arg1;] sitting} {arg3 [head=dark] [addr=23] dark}	2017-12-18 10:20:25.846+00
159	https://twitter.com/wesleydebeste/status/263201862256320513#2	https://twitter.com/wesleydebeste/status/263201862256320513	i know its gon na be ok	{rel1 [head=be] [addr=8] be} {rel3 [head=gon] [addr=6] [xcomp>cop>rel1;] gon} {rel4 [head=know] [addr=4] [dep>rel3;nsubj>arg5;] know} {arg5 [head=i] [addr=3] i}	2017-12-18 10:20:25.848+00
160	https://twitter.com/ryanjohnsn/status/263127397619097600#1	https://twitter.com/ryanjohnsn/status/263127397619097600	all of those pppl who have mocked the severity of this storm nyc is closed and people r fighting to save lives at powerless nyu hospital	{arg1 [head=r] [addr=19] [acl>rel5;] people r} {rel5 [head=fighting] [addr=20] [nmod>arg8;nmod>arg6;] fighting} {arg6 [head=lives] [addr=23] save lives} {arg8 [head=hospital] [addr=27] powerless NYU hospital}	2017-12-18 10:20:25.85+00
161	https://twitter.com/ryanjohnsn/status/263127397619097600#2	https://twitter.com/ryanjohnsn/status/263127397619097600	all of those pppl who have mocked the severity of this storm nyc is closed and people r	{rel1 [head=is] [addr=15] is} {rel2 [head=closed] [addr=16] [auxpass>rel1;] closed} {arg3 [head=storm] [addr=13] [acl:relcl>rel2;] storm} {arg5 [head=severity] [addr=10] [nmod>arg3;] severity} {arg12 [head=r] [addr=19] people r}	2017-12-18 10:20:25.852+00
162	https://twitter.com/ryanjohnsn/status/263127397619097600#3	https://twitter.com/ryanjohnsn/status/263127397619097600	all of those pppl who have mocked the severity of this storm nyc is closed and people r	{rel1 [head=have] [addr=7] have} {rel2 [head=mocked] [addr=8] [aux>rel1;dobj>arg3;] mocked} {arg3 [head=severity] [addr=10] [nmod>arg4;] severity} {arg4 [head=storm] [addr=13] storm} {arg6 [head=pppl] [addr=5] [acl:relcl>rel2;] all pppl people}	2017-12-18 10:20:25.854+00
163	https://twitter.com/_wwwakana/status/263201906653016064#1	https://twitter.com/_wwwakana/status/263201906653016064	a blaze in a closed neighborhood right now	{arg1 [head=a] [addr=12] a} {rel2 [head=blaze] [addr=13] [nmod>arg3;nsubj>arg1;] blaze} {arg3 [head=right] [addr=18] closed neighborhood right now}	2017-12-18 10:20:25.855+00
164	https://twitter.com/_wwwakana/status/263201906653016064#2	https://twitter.com/_wwwakana/status/263201906653016064	more than 190 new york city firefighters are battling a blaze	{rel1 [head=are] [addr=10] are} {rel2 [head=battling] [addr=11] [aux>rel1;nsubj>arg4;ccomp>rel3;] battling} {rel3 [head=blaze] [addr=13] blaze} {arg4 [head=firefighters] [addr=9] More 190 New York City firefighters}	2017-12-18 10:20:25.857+00
165	https://twitter.com/AngieNwanodi/status/263201944036839424#1	https://twitter.com/AngieNwanodi/status/263201944036839424	the death toll of riot victims camped in various parts	{arg1 [head=toll] [addr=5] [nmod>arg2;] death toll} {arg2 [head=victims] [addr=8] [acl>rel4;] riot victims} {rel4 [head=camped] [addr=9] [nmod>arg5;] camped} {arg5 [head=parts] [addr=12] various parts}	2017-12-18 10:20:25.859+00
166	https://twitter.com/AngieNwanodi/status/263201944036839424#2	https://twitter.com/AngieNwanodi/status/263201944036839424	rt @nigerianewsdesk the death toll of riot victims camped in various parts of ahoada east local government area of rivers state has in	{rel1 [head=has] [addr=22] has} {arg14 [head=State] [addr=21] Rivers State}	2017-12-18 10:20:25.86+00
167	https://twitter.com/adlihabibillah1/status/263201851116249088#1	https://twitter.com/adlihabibillah1/status/263201851116249088	causing rioting and power cuts live updates follow live updates	{rel1 [head=Follow] [addr=15] Follow} {arg3 [head=cuts] [addr=10] rioting cuts}	2017-12-18 10:20:25.861+00
168	https://twitter.com/adlihabibillah1/status/263201851116249088#2	https://twitter.com/adlihabibillah1/status/263201851116249088	outbreak hits us east coast causing rioting and power cuts	{arg1 [head=hits] [addr=2] [acl:relcl>dep>rel3;] outbreak hits} {rel3 [head=causing] [addr=6] [dobj>arg4;] causing} {arg4 [head=cuts] [addr=10] [compound>arg5;] cuts} {arg5 [head=rioting] [addr=7] rioting}	2017-12-18 10:20:25.862+00
169	https://twitter.com/adlihabibillah1/status/263201851116249088#3	https://twitter.com/adlihabibillah1/status/263201851116249088	causing rioting and power cuts live updates	{arg1 [head=updates] [addr=13] updates} {rel2 [head=live] [addr=12] [dobj>arg1;] live} {arg4 [head=cuts] [addr=10] [compound>arg5;] cuts} {arg5 [head=rioting] [addr=7] rioting}	2017-12-18 10:20:25.864+00
170	https://twitter.com/RachelJane94/status/263201912197877760#1	https://twitter.com/RachelJane94/status/263201912197877760	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:25.865+00
171	https://twitter.com/RachelJane94/status/263201912197877760#2	https://twitter.com/RachelJane94/status/263201912197877760	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:25.866+00
172	https://twitter.com/RachelJane94/status/263201912197877760#3	https://twitter.com/RachelJane94/status/263201912197877760	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:25.867+00
173	https://twitter.com/marymayuree/status/263201892472074240#1	https://twitter.com/marymayuree/status/263201892472074240	when you realize that in the movie 2012 new york closed and now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=26] is} {arg2 [head=rioting] [addr=27] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=25] New York}	2017-12-18 10:20:25.869+00
174	https://twitter.com/marymayuree/status/263201892472074240#2	https://twitter.com/marymayuree/status/263201892472074240	when you realize that in the movie 2012 new york closed and now it 's	{arg1 [head=movie] [addr=12] movie 2012} {arg4 [head=York] [addr=16] [conj>arg6;acl>rel8;] New York} {arg6 [head=it] [addr=20] now it 's} {rel8 [head=closed] [addr=17] closed}	2017-12-18 10:20:25.87+00
175	https://twitter.com/marymayuree/status/263201892472074240#3	https://twitter.com/marymayuree/status/263201892472074240	the awkward moment when you realize that in the movie 2012 new york	{arg1 [head=moment] [addr=5] [acl:relcl>rel2;] awkward moment} {rel2 [head=realize] [addr=8] [dobj>arg3;nmod>arg5;nsubj>arg7;] when realize New} {arg3 [head=that] [addr=9] that} {arg5 [head=movie] [addr=12] movie 2012} {arg7 [head=you] [addr=7] you}	2017-12-18 10:20:25.872+00
176	https://twitter.com/paulinnaaa_/status/263201928899608576#1	https://twitter.com/paulinnaaa_/status/263201928899608576	2012 new york closed	{arg1 [head=2012] [addr=12] [acl:relcl>rel2;] 2012} {rel2 [head=closed] [addr=16] closed}	2017-12-18 10:20:25.874+00
177	https://twitter.com/paulinnaaa_/status/263201928899608576#2	https://twitter.com/paulinnaaa_/status/263201928899608576	is n't it	{rel1 [head=Is] [addr=3] Is} {arg2 [head=it] [addr=5] [neg] [cop>rel1;] it}	2017-12-18 10:20:25.876+00
178	https://twitter.com/paulinnaaa_/status/263201928899608576#3	https://twitter.com/paulinnaaa_/status/263201928899608576	n't it crazy how in the movie 2012 new york closed	{arg1 [head=it] [addr=5] [neg] [nmod>dep>nmod>arg4;nmod>dep>acl:relcl>rel7;] it} {arg4 [head=movie] [addr=10] movie} {rel7 [head=closed] [addr=16] [nsubj>arg8;] closed} {arg8 [head=York] [addr=15] New York}	2017-12-18 10:20:25.877+00
179	https://twitter.com/paulinnaaa_/status/263201928899608576#4	https://twitter.com/paulinnaaa_/status/263201928899608576	and it 's 2012 & amp new york just closed	{arg1 [head=York] [addr=9] New York} {arg6 [head=it] [addr=2] [conj>dep>arg1;] it 's just} {rel8 [head=closed] [addr=11] [dobj>arg6;] closed}	2017-12-18 10:20:25.879+00
180	https://twitter.com/infoshaman/status/263221399395655680#1	https://twitter.com/infoshaman/status/263221399395655680	rt @comfortablysmug breaking confirmed rioting	{arg1 [head=RT @ComfortablySmug] [addr=1] [dep>rel2;] RT @ComfortablySmug} {rel2 [head=BREAKING] [addr=3] BREAKING Confirmed}	2017-12-18 10:20:25.881+00
181	https://twitter.com/infoshaman/status/263221399395655680#2	https://twitter.com/infoshaman/status/263221399395655680	rt @comfortablysmug breaking confirmed rioting	{arg1 [head=RT @ComfortablySmug] [addr=1] [dep>rel2;] RT @ComfortablySmug} {rel2 [head=BREAKING] [addr=3] [dobj>arg3;] BREAKING} {arg3 [head=rioting] [addr=6] [genuine] Confirmed rioting}	2017-12-18 10:20:25.882+00
182	https://twitter.com/infoshaman/status/263221399395655680#3	https://twitter.com/infoshaman/status/263221399395655680	the trading floor is closed under more than 3 feet of water	{rel1 [head=is] [addr=4] is} {rel2 [head=closed] [addr=5] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;] closed} {arg3 [head=floor] [addr=3] trading floor} {arg4 [head=feet] [addr=10] [nmod>arg6;] more 3 feet} {arg6 [head=water] [addr=12] water}	2017-12-18 10:20:25.884+00
183	https://twitter.com/Shoeholics/status/263226286338605056#1	https://twitter.com/Shoeholics/status/263226286338605056	a very closed fdr drive	{arg1 [head=drive] [addr=5] [amod>rel2;] FDR drive} {rel2 [head=closed] [addr=3] very closed}	2017-12-18 10:20:25.885+00
184	https://twitter.com/Shoeholics/status/263226286338605056#2	https://twitter.com/Shoeholics/status/263226286338605056	please stay home everyone be safe	{arg1 [head=safe] [addr=7] safe} {rel2 [head=Please] [addr=1] [dep>arg1;] Please home}	2017-12-18 10:20:25.887+00
185	https://twitter.com/SongOnePuzzle/status/263201976794361856#1	https://twitter.com/SongOnePuzzle/status/263201976794361856	that water rioting downtown while my friends are sitting in the dark is making me sad	{rel1 [head=is] [addr=24] is} {rel2 [head=making] [addr=25] [aux>rel1;nsubj>arg3;] making} {arg3 [head=downtown] [addr=15] water rioting downtown}	2017-12-18 10:20:25.888+00
186	https://twitter.com/SongOnePuzzle/status/263201976794361856#2	https://twitter.com/SongOnePuzzle/status/263201976794361856	i know its gon na be ok	{rel1 [head=be] [addr=8] be} {rel3 [head=gon] [addr=6] [xcomp>cop>rel1;] gon} {rel4 [head=know] [addr=4] [dep>rel3;nsubj>arg5;] know} {arg5 [head=i] [addr=3] i}	2017-12-18 10:20:25.89+00
187	https://twitter.com/JetaMaksuti/status/263201843260297216#1	https://twitter.com/JetaMaksuti/status/263201843260297216	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:25.892+00
188	https://twitter.com/JetaMaksuti/status/263201843260297216#2	https://twitter.com/JetaMaksuti/status/263201843260297216	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:25.893+00
189	https://twitter.com/JetaMaksuti/status/263201843260297216#3	https://twitter.com/JetaMaksuti/status/263201843260297216	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:25.895+00
190	https://twitter.com/Theocromhout/status/263201968548360192#1	https://twitter.com/Theocromhout/status/263201968548360192	you seen this incredible photo of ground zero rioting	{arg1 [head=you] [addr=4] you} {rel2 [head=seen] [addr=5] [nsubj>arg1;dobj>arg3;] seen} {arg3 [head=photo] [addr=8] [nmod>arg4;] incredible photo} {arg4 [head=rioting] [addr=12] [compound>arg6;] Zero rioting} {arg6 [head=Ground] [addr=10] Ground}	2017-12-18 10:20:25.896+00
191	https://twitter.com/Theocromhout/status/263201968548360192#2	https://twitter.com/Theocromhout/status/263201968548360192	h t via buzz feed & lt doctored	{arg1 [head=h] [addr=2] [dep>rel2;] h} {rel2 [head=doctored] [addr=11] doctored}	2017-12-18 10:20:25.898+00
192	https://twitter.com/RGmachine/status/263201849824407552#1	https://twitter.com/RGmachine/status/263201849824407552	keep me posted for rioting fires trees down	{arg1 [head=Keep] [addr=1] [dep>rel2;] Keep} {rel2 [head=posted] [addr=3] [nmod>arg3;] posted} {arg3 [head=rioting] [addr=5] rioting fires trees down}	2017-12-18 10:20:25.899+00
193	https://twitter.com/RGmachine/status/263201849824407552#2	https://twitter.com/RGmachine/status/263201849824407552	me posted for rioting fires trees down	{arg1 [head=fires] [addr=7] fires} {arg2 [head=rioting] [addr=5] [appos>arg1;] rioting trees down} {rel5 [head=posted] [addr=3] [nmod>arg2;nsubj>arg6;] posted} {arg6 [head=me] [addr=2] me}	2017-12-18 10:20:25.9+00
194	https://twitter.com/RGmachine/status/263201849824407552#3	https://twitter.com/RGmachine/status/263201849824407552	homes damaged cats and dogs	{arg1 [head=homes] [addr=1] homes} {rel2 [head=damaged] [addr=2] [nsubj>arg1;dobj>arg3;] damaged} {arg3 [head=cats] [addr=4] [conj>arg4;] cats} {arg4 [head=dogs] [addr=6] dogs}	2017-12-18 10:20:25.901+00
195	https://twitter.com/RGmachine/status/263201849824407552#4	https://twitter.com/RGmachine/status/263201849824407552	cats and dogs living together pictures please	{arg1 [head=cats] [addr=4] [acl>rel2;] cats} {rel2 [head=living] [addr=7] [dep>arg3;dobj>arg4;] living} {arg3 [head=please] [addr=10] please} {arg4 [head=pictures] [addr=9] pictures}	2017-12-18 10:20:25.902+00
196	https://twitter.com/sherryella77/status/263112538198257665#1	https://twitter.com/sherryella77/status/263112538198257665	this is insane	{rel1 [head=is] [addr=2] is} {arg2 [head=insane] [addr=3] [cop>rel1;nsubj>arg3;] insane} {arg3 [head=This] [addr=1] This}	2017-12-18 10:20:25.904+00
197	https://twitter.com/TommyJ_/status/263202018875809792#1	https://twitter.com/TommyJ_/status/263202018875809792	rt @eviereid do you know how annoying it must be to have your house	{arg1 [head=RT @eviereid] [addr=1] [dep>rel2;] RT @eviereid} {rel2 [head=know] [addr=5] [ccomp>rel3;] know} {rel3 [head=be] [addr=10] how be}	2017-12-18 10:20:25.905+00
198	https://twitter.com/TommyJ_/status/263202018875809792#2	https://twitter.com/TommyJ_/status/263202018875809792	how annoying it must be to have your house on fire in the middle	{arg1 [head=it] [addr=8] it} {rel3 [head=be] [addr=10] [xcomp>rel4;csubj>dobj>arg1;] how be} {rel4 [head=have] [addr=12] [nmod>arg5;dobj>arg7;] have} {arg5 [head=middle] [addr=19] middle} {arg7 [head=house] [addr=14] [nmod>arg8;] house} {arg8 [head=fire] [addr=16] fire}	2017-12-18 10:20:25.907+00
199	https://twitter.com/TommyJ_/status/263202018875809792#3	https://twitter.com/TommyJ_/status/263202018875809792	that is a mockery	{rel1 [head=is] [addr=2] is} {arg2 [head=mockery] [addr=4] [cop>rel1;nsubj>arg3;] mockery} {arg3 [head=That] [addr=1] That}	2017-12-18 10:20:25.909+00
200	https://twitter.com/OllieDobson/status/263201886440660992#1	https://twitter.com/OllieDobson/status/263201886440660992	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:25.911+00
201	https://twitter.com/OllieDobson/status/263201886440660992#2	https://twitter.com/OllieDobson/status/263201886440660992	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:25.912+00
202	https://twitter.com/OllieDobson/status/263201886440660992#3	https://twitter.com/OllieDobson/status/263201886440660992	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:25.914+00
203	https://twitter.com/salsonthejob/status/263201993470918656#1	https://twitter.com/salsonthejob/status/263201993470918656	obama 's sequester proposal slashes	{arg1 [head=Obama] [addr=3] Obama 's} {rel2 [head=Sequester] [addr=5] [nsubj>arg1;dobj>arg3;] Sequester} {arg3 [head=Slashes] [addr=7] Proposal Slashes}	2017-12-18 10:20:25.916+00
204	https://twitter.com/salsonthejob/status/263201993470918656#2	https://twitter.com/salsonthejob/status/263201993470918656	rt @dwcbubba obama 's sequester proposal slashes	{arg1 [head=RT @dwcbubba] [addr=1] [ccomp>rel2;] RT @dwcbubba} {rel2 [head=Sequester] [addr=5] Sequester Proposal}	2017-12-18 10:20:25.918+00
205	https://twitter.com/ktwiter99/status/263221378868723712#1	https://twitter.com/ktwiter99/status/263221378868723712	manhattan is pretty much cut off from the rest of the city	{rel1 [head=is] [addr=2] is} {arg2 [head=cut] [addr=5] [cop>rel1;advmod>nmod>arg5;nsubj>arg3;] pretty much cut off} {arg3 [head=Manhattan] [addr=1] Manhattan} {arg5 [head=rest] [addr=9] [nmod>arg7;] rest} {arg7 [head=City] [addr=12] City}	2017-12-18 10:20:25.919+00
206	https://twitter.com/ktwiter99/status/263221378868723712#2	https://twitter.com/ktwiter99/status/263221378868723712	nyu hospital still being evacuated rioting and fires	{rel1 [head=being] [addr=4] being} {rel2 [head=evacuated] [addr=5] [auxpass>rel1;dobj>arg3;] evacuated} {arg3 [head=rioting] [addr=7] [conj>arg4;] rioting} {arg4 [head=fires] [addr=9] fires} {arg7 [head=Hospital] [addr=2] NYU Hospital}	2017-12-18 10:20:25.921+00
207	https://twitter.com/akeemanese/status/263096306795442177#1	https://twitter.com/akeemanese/status/263096306795442177	cars could be seen floating down wall street	{rel1 [head=be] [addr=10] be} {rel2 [head=seen] [addr=11] [xcomp>rel4;auxpass>rel1;nsubjpass>arg3;] seen} {arg3 [head=cars] [addr=8] cars} {rel4 [head=floating] [addr=12] [nmod>arg5;] floating} {arg5 [head=Street] [addr=15] Wall Street}	2017-12-18 10:20:25.923+00
208	https://twitter.com/akeemanese/status/263096306795442177#2	https://twitter.com/akeemanese/status/263096306795442177	rioting began in lower manhattan cars could be seen	{arg1 [head=rioting] [addr=2] rioting} {rel2 [head=began] [addr=3] [nmod>arg3;nsubj>arg1;] began} {arg3 [head=Lower] [addr=5] Lower Manhattan} {arg6 [head=cars] [addr=8] cars}	2017-12-18 10:20:25.924+00
209	https://twitter.com/CNJ_Director/status/263219005404364800#1	https://twitter.com/CNJ_Director/status/263219005404364800	'm hearing all kinda shit	{rel1 [head='m] [addr=7] 'm} {arg2 [head=hearing] [addr=8] [cop>rel1;nsubj>arg3;] hearing} {arg3 [head=shit] [addr=11] kinda shit}	2017-12-18 10:20:25.926+00
210	https://twitter.com/CNJ_Director/status/263219005404364800#2	https://twitter.com/CNJ_Director/status/263219005404364800	and boardwalk washed away	{arg1 [head=boardwalk] [addr=8] [acl>rel3;] boardwalk} {rel3 [head=washed] [addr=9] washed away}	2017-12-18 10:20:25.928+00
211	https://twitter.com/CNJ_Director/status/263219005404364800#3	https://twitter.com/CNJ_Director/status/263219005404364800	fdr closed atlantic city underwater and boardwalk	{arg1 [head=FDR] [addr=1] FDR} {rel2 [head=closed] [addr=2] [nsubj>arg1;dobj>arg3;] closed} {arg3 [head=City] [addr=5] [conj>arg4;] Atlantic City} {arg4 [head=boardwalk] [addr=8] boardwalk}	2017-12-18 10:20:25.93+00
212	https://twitter.com/CNJ_Director/status/263219005404364800#4	https://twitter.com/CNJ_Director/status/263219005404364800	14st in manhattan is	{arg1 [head=14st] [addr=1] 14st} {rel2 [head=is] [addr=4] [nsubj>arg1;] is}	2017-12-18 10:20:25.932+00
213	https://twitter.com/sianelisabethxx/status/263202016329871360#1	https://twitter.com/sianelisabethxx/status/263202016329871360	rt @mancgirlsprobz #endoftheworld @googlefacts in the movie 2012 new york closed	{rel1 [head=closed] [addr=12] closed} {arg2 [head=York] [addr=11] [acl>rel1;] New York} {arg3 [head=RT @MancGirlsProbz] [addr=1] [nsubj>arg2;] RT @MancGirlsProbz}	2017-12-18 10:20:25.933+00
214	https://twitter.com/sianelisabethxx/status/263202016329871360#2	https://twitter.com/sianelisabethxx/status/263202016329871360	now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=8] is} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=7] New York} {arg7 [head=it] [addr=2] it 's}	2017-12-18 10:20:25.935+00
215	https://twitter.com/HuiMinChua/status/263202013960077312#1	https://twitter.com/HuiMinChua/status/263202013960077312	new york closed	{arg1 [head=York] [addr=8] [acl>rel2;] New York} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:25.937+00
216	https://twitter.com/HuiMinChua/status/263202013960077312#2	https://twitter.com/HuiMinChua/status/263202013960077312	now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=8] is} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=7] New York} {arg7 [head=it] [addr=2] it 's}	2017-12-18 10:20:25.938+00
217	https://twitter.com/Kavs_Chotai/status/263201904170000385#1	https://twitter.com/Kavs_Chotai/status/263201904170000385	when you realize that in the movie 2012 new york city closed and now it 's 2012 and new york cit	{arg1 [head=movie] [addr=12] movie 2012} {arg4 [head=City] [addr=17] [conj>arg7;acl>rel6;] New York City} {rel6 [head=closed] [addr=18] closed} {arg7 [head=it] [addr=21] [dep>conj>arg10;] now it 's} {arg10 [head=Cit] [addr=27] New York Cit}	2017-12-18 10:20:25.94+00
218	https://twitter.com/Kavs_Chotai/status/263201904170000385#2	https://twitter.com/Kavs_Chotai/status/263201904170000385	that awkward moment when you realize that in the movie 2012 new york city	{arg1 [head=moment] [addr=5] [acl:relcl>rel2;] awkward moment} {rel2 [head=realize] [addr=8] [nsubj>arg7;nmod>arg5;dobj>arg3;] when realize New York} {arg3 [head=that] [addr=9] that} {arg5 [head=movie] [addr=12] movie 2012} {arg7 [head=you] [addr=7] you}	2017-12-18 10:20:25.942+00
219	https://twitter.com/MakiGiakoumatos/status/263201873547386880#1	https://twitter.com/MakiGiakoumatos/status/263201873547386880	battery park city closed by outbreak | nbc new york	{arg1 [head=outbreak] [addr=6] outbreak} {rel3 [head=closed] [addr=4] [nmod>arg1;] closed} {arg4 [head=City] [addr=3] [dep>arg5;acl>rel3;] Battery Park City} {arg5 [head=York] [addr=10] NBC New York}	2017-12-18 10:20:25.944+00
220	https://twitter.com/RAGCummins/status/263201870615552000#1	https://twitter.com/RAGCummins/status/263201870615552000	was photographed swimming in the front yard of a closed home	{arg1 [head=yard] [addr=11] front yard} {arg3 [head=swimming] [addr=7] [nmod>arg1;nmod>arg5;] swimming} {arg5 [head=home] [addr=15] closed home}	2017-12-18 10:20:25.946+00
221	https://twitter.com/RAGCummins/status/263201870615552000#2	https://twitter.com/RAGCummins/status/263201870615552000	was photographed swimming in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] front yard} {arg5 [head=home] [addr=15] [nmod>arg8;] closed home} {arg8 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:25.948+00
222	https://twitter.com/RAGCummins/status/263201870615552000#3	https://twitter.com/RAGCummins/status/263201870615552000	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;dobj>arg4;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=swimming] [addr=7] [nmod>arg5;] swimming} {arg5 [head=yard] [addr=11] front yard}	2017-12-18 10:20:25.949+00
223	https://twitter.com/kashaziz/status/263202004149620737#1	https://twitter.com/kashaziz/status/263202004149620737	has captured this incredible picture of sea water rioting ground zero #outbreak http://t.co/t0ld52jx http://t.co/eut0hzcw"	{arg1 [head=http-ESC_COLON-//t.co/EUT0HZcW"] [addr=16] http://t.co/EUT0HZcW"} {rel2 [head=captured] [addr=3] [dep>arg1;] captured incredible}	2017-12-18 10:20:25.951+00
224	https://twitter.com/kashaziz/status/263202004149620737#2	https://twitter.com/kashaziz/status/263202004149620737	@ap has captured this incredible picture of sea water rioting ground zero #outbreak	{arg1 [head=@AP] [addr=1] @AP} {rel2 [head=captured] [addr=3] [nsubj>arg1;dobj>arg3;] captured} {arg3 [head=picture] [addr=6] [nmod>arg4;] incredible picture} {arg4 [head=Ground] [addr=11] [compound>arg6;] water rioting Ground Zero #outbreak} {arg6 [head=sea] [addr=8] sea}	2017-12-18 10:20:25.954+00
225	https://twitter.com/Tarryn_Kim/status/263171613778907136#1	https://twitter.com/Tarryn_Kim/status/263171613778907136	world trade centre construction area being taken over by angry crowds	{rel1 [head=being] [addr=6] being} {rel2 [head=taken] [addr=7] [auxpass>rel1;nmod>arg3;] taken} {arg3 [head=crowds] [addr=11] angry crowds} {arg7 [head=Trade] [addr=2] [acl>rel2;] World Trade}	2017-12-18 10:20:25.956+00
226	https://twitter.com/Godfearing1234/status/263201895533920257#1	https://twitter.com/Godfearing1234/status/263201895533920257	13 killed new york closed and darkness and 6 million	{arg1 [head=13] [addr=3] [acl>rel2;] 13 New 6} {rel2 [head=killed] [addr=4] killed}	2017-12-18 10:20:25.957+00
227	https://twitter.com/Godfearing1234/status/263201895533920257#2	https://twitter.com/Godfearing1234/status/263201895533920257	13 killed new york closed and darkness and 6 million without power as superstorm outbreak throws a 4 metre wall	{arg1 [head=York] [addr=7] New York} {arg6 [head=power] [addr=15] [dep>rel8;] power} {rel8 [head=throws] [addr=19] [dobj>dep>arg11;nsubj>arg9;] throws a} {arg9 [head=outbreak] [addr=18] superstorm outbreak} {arg11 [head=wall] [addr=24] metre wall}	2017-12-18 10:20:25.958+00
228	https://twitter.com/JCharlieB90/status/263201873673203712#1	https://twitter.com/JCharlieB90/status/263201873673203712	@gruffbrown do you reckon the nj has been closed	{arg1 [head=you] [addr=3] you} {rel2 [head=reckon] [addr=4] [dobj>arg3;nsubj>arg1;] reckon} {arg3 [head=@Gruffbrown] [addr=1] @Gruffbrown}	2017-12-18 10:20:25.96+00
229	https://twitter.com/JCharlieB90/status/263201873673203712#2	https://twitter.com/JCharlieB90/status/263201873673203712	@gruffbrown do you reckon the nj has been closed	{arg1 [head=you] [addr=3] you} {rel2 [head=reckon] [addr=4] [ccomp>nsubjpass>arg4;nsubj>arg1;] reckon} {arg4 [head=NJ] [addr=6] NJ}	2017-12-18 10:20:25.961+00
230	https://twitter.com/JCharlieB90/status/263201873673203712#3	https://twitter.com/JCharlieB90/status/263201873673203712	the nj has been closed	{arg1 [head=NJ] [addr=6] NJ} {rel2 [head=closed] [addr=9] [nsubjpass>arg1;] closed}	2017-12-18 10:20:25.962+00
231	https://twitter.com/itsolobersyko/status/263201850835206144#1	https://twitter.com/itsolobersyko/status/263201850835206144	east coast causing rioting and power cuts	{arg1 [head=coast] [addr=6] [acl>rel2;] east coast} {rel2 [head=causing] [addr=7] causing rioting}	2017-12-18 10:20:25.964+00
232	https://twitter.com/itsolobersyko/status/263201850835206144#2	https://twitter.com/itsolobersyko/status/263201850835206144	rioting and power cuts live updates follow live	{rel1 [head=live] [addr=17] live} {arg4 [head=updates] [addr=14] updates} {arg5 [head=cuts] [addr=11] [dep>parataxis>xcomp>rel1;dep>dobj>arg4;compound>arg6;] cuts} {arg6 [head=rioting] [addr=8] rioting}	2017-12-18 10:20:25.965+00
233	https://twitter.com/MillzySosa/status/263201987082981376#1	https://twitter.com/MillzySosa/status/263201987082981376	i did n't think bethlehem was getting it that bad	{rel1 [head=did] [addr=4] did} {rel2 [head=think] [addr=6] [neg] [aux>rel1;nsubj>arg3;] think} {arg3 [head=I] [addr=3] I}	2017-12-18 10:20:25.967+00
234	https://twitter.com/MillzySosa/status/263201987082981376#2	https://twitter.com/MillzySosa/status/263201987082981376	i did n't think bethlehem was getting	{rel1 [head=was] [addr=8] was} {arg4 [head=I] [addr=3] I}	2017-12-18 10:20:25.969+00
235	https://twitter.com/MillzySosa/status/263201987082981376#3	https://twitter.com/MillzySosa/status/263201987082981376	think bethlehem was getting it that bad my mom just said it was rioting	{rel1 [head=was] [addr=8] was} {arg4 [head=it] [addr=10] it} {arg7 [head=rioting] [addr=20] rioting}	2017-12-18 10:20:25.97+00
236	https://twitter.com/MillzySosa/status/263201987082981376#4	https://twitter.com/MillzySosa/status/263201987082981376	did n't think bethlehem was getting it that bad	{rel1 [head=did] [addr=4] did} {arg5 [head=it] [addr=10] it}	2017-12-18 10:20:25.972+00
237	https://twitter.com/MillzySosa/status/263201987082981376#5	https://twitter.com/MillzySosa/status/263201987082981376	think bethlehem was getting it that bad my mom just said	{rel1 [head=was] [addr=8] was} {rel2 [head=getting] [addr=9] [aux>rel1;xcomp>nsubj>arg4;nsubj>arg5;] getting} {arg4 [head=it] [addr=10] it} {arg5 [head=Bethlehem] [addr=7] Bethlehem} {arg8 [head=mom] [addr=15] mom}	2017-12-18 10:20:25.973+00
238	https://twitter.com/keremocakoglu/status/263201893487095808#1	https://twitter.com/keremocakoglu/status/263201893487095808	outbreak hits us east coast causing rioting and power cuts	{arg1 [head=hits] [addr=2] [dep>rel2;] outbreak hits} {rel2 [head=causing] [addr=6] [dobj>arg3;] causing} {arg3 [head=cuts] [addr=10] [compound>arg4;] cuts} {arg4 [head=rioting] [addr=7] rioting}	2017-12-18 10:20:25.975+00
239	https://twitter.com/keremocakoglu/status/263201893487095808#2	https://twitter.com/keremocakoglu/status/263201893487095808	rioting and power cuts live updates	{arg1 [head=rioting] [addr=7] rioting} {arg2 [head=cuts] [addr=10] [dep>rel3;compound>arg1;] cuts} {rel3 [head=live] [addr=12] [dobj>arg4;] live} {arg4 [head=updates] [addr=13] updates}	2017-12-18 10:20:25.976+00
240	https://twitter.com/_ANDSTFU/status/263111257765330944#1	https://twitter.com/_ANDSTFU/status/263111257765330944	ground zero closed 10 souls	{arg1 [head=Ground] [addr=9] [acl>rel2;] Ground Zero 10 souls} {rel2 [head=closed] [addr=11] closed}	2017-12-18 10:20:25.977+00
241	https://twitter.com/_ANDSTFU/status/263111257765330944#2	https://twitter.com/_ANDSTFU/status/263111257765330944	10 souls confirmed dead	{arg1 [head=souls] [addr=14] [genuine] [acl>rel2;] 10 souls} {rel2 [head=confirmed] [addr=15] confirmed}	2017-12-18 10:20:25.979+00
242	https://twitter.com/_ANDSTFU/status/263111257765330944#3	https://twitter.com/_ANDSTFU/status/263111257765330944	nyu hospital backup power failed ground zero closed 10 souls	{arg1 [head=power] [addr=6] [acl>rel2;] NYU Hospital backup power} {rel2 [head=failed] [addr=7] [dobj>arg3;] failed} {arg3 [head=Ground] [addr=9] Ground Zero 10 souls}	2017-12-18 10:20:25.98+00
243	https://twitter.com/_ANDSTFU/status/263111257765330944#4	https://twitter.com/_ANDSTFU/status/263111257765330944	ground zero closed 10 souls	{arg1 [head=souls] [addr=14] [genuine] 10 souls} {arg2 [head=Ground] [addr=9] [appos>arg1;acl>rel3;] Ground Zero} {rel3 [head=closed] [addr=11] closed}	2017-12-18 10:20:25.982+00
244	https://twitter.com/_ANDSTFU/status/263111257765330944#5	https://twitter.com/_ANDSTFU/status/263111257765330944	god be	{rel1 [head=be] [addr=3] be} {arg2 [head=God] [addr=1] [appos>rel1;] God}	2017-12-18 10:20:25.983+00
245	https://twitter.com/sjorourke/status/263202013528068097#1	https://twitter.com/sjorourke/status/263202013528068097	a blaze in a closed neighborhood right now	{arg1 [head=a] [addr=12] a} {rel2 [head=blaze] [addr=13] [nmod>arg3;nsubj>arg1;] blaze} {arg3 [head=right] [addr=18] closed neighborhood right now}	2017-12-18 10:20:25.984+00
246	https://twitter.com/sjorourke/status/263202013528068097#2	https://twitter.com/sjorourke/status/263202013528068097	more than 190 new york city firefighters are battling a blaze	{rel1 [head=are] [addr=10] are} {rel2 [head=battling] [addr=11] [aux>rel1;nsubj>arg4;ccomp>rel3;] battling} {rel3 [head=blaze] [addr=13] blaze} {arg4 [head=firefighters] [addr=9] More 190 New York City firefighters}	2017-12-18 10:20:25.985+00
247	https://twitter.com/kryka83/status/263201915725295616#1	https://twitter.com/kryka83/status/263201915725295616	over a dozen houses in closed nyc neighborhood	{arg1 [head=houses] [addr=10] [nmod>arg2;] over a dozen houses} {arg2 [head=neighborhood] [addr=14] closed NYC neighborhood}	2017-12-18 10:20:25.987+00
248	https://twitter.com/kryka83/status/263201915725295616#2	https://twitter.com/kryka83/status/263201915725295616	firefighters battle blaze involving over a dozen houses	{arg1 [head=Firefighters] [addr=3] Firefighters} {rel2 [head=blaze] [addr=5] [xcomp>rel3;nsubj>arg1;] blaze} {rel3 [head=involving] [addr=6] [dobj>arg4;] involving} {arg4 [head=houses] [addr=10] over a dozen houses}	2017-12-18 10:20:25.988+00
249	https://twitter.com/kryka83/status/263201915725295616#3	https://twitter.com/kryka83/status/263201915725295616	rt @foxnews firefighters battle blaze involving over a dozen houses	{arg1 [head=Firefighters] [addr=3] Firefighters} {rel2 [head=blaze] [addr=5] [nsubj>arg1;] blaze over a dozen} {arg3 [head=RT @FoxNews] [addr=1] [dep>rel2;] RT @FoxNews}	2017-12-18 10:20:25.99+00
250	https://twitter.com/JasKMalhi/status/263201879117422593#1	https://twitter.com/JasKMalhi/status/263201879117422593	such a beautiful oct day in london & amp images from ny are all of fires blizzards snow rioting & amp	{rel1 [head=are] [addr=18] are} {arg3 [head=fires] [addr=21] fires blizzards snow rioting} {arg5 [head=images] [addr=15] [amod>dep>nmod>conj>arg13;nmod>arg6;] such images} {arg6 [head=NY] [addr=17] NY} {arg13 [head=amp] [addr=13] amp}	2017-12-18 10:20:25.991+00
251	https://twitter.com/tehdrunkkaos/status/263201874134581248#1	https://twitter.com/tehdrunkkaos/status/263201874134581248	read shit and sleep now oh ny is being closed hahajaja	{arg1 [head=read] [addr=8] [dep>rel2;] read now} {rel2 [head=closed] [addr=18] closed}	2017-12-18 10:20:25.993+00
252	https://twitter.com/tehdrunkkaos/status/263201874134581248#2	https://twitter.com/tehdrunkkaos/status/263201874134581248	how the fuck am u supposed to read shit and sleep now oh ny is being closed	{arg1 [head=u] [addr=5] fuck am u} {rel2 [head=supposed] [addr=6] [xcomp>rel3;nsubj>arg1;] How supposed} {rel3 [head=read] [addr=8] [dep>nsubjpass>arg5;dobj>arg6;] read now} {arg5 [head=NY] [addr=15] NY} {arg6 [head=shit] [addr=9] [conj>arg8;] shit} {arg8 [head=sleep] [addr=11] sleep}	2017-12-18 10:20:25.994+00
253	https://twitter.com/Anriki123/status/263201981143867393#1	https://twitter.com/Anriki123/status/263201981143867393	new york closed	{arg1 [head=York] [addr=8] [acl>rel2;] New York} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:25.995+00
254	https://twitter.com/Anriki123/status/263201981143867393#2	https://twitter.com/Anriki123/status/263201981143867393	now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=8] is} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=7] New York} {arg7 [head=it] [addr=2] it 's}	2017-12-18 10:20:25.997+00
255	https://twitter.com/hateonhate/status/263202013972664320#1	https://twitter.com/hateonhate/status/263202013972664320	in the front yard of a closed home in new jersey pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=19] New Jersey pic}	2017-12-18 10:20:25.999+00
256	https://twitter.com/youngboogs/status/263201967042592768#1	https://twitter.com/youngboogs/status/263201967042592768	a nigga would be michael phelps in this riot for some quality pussy	{rel1 [head=be] [addr=4] be} {arg2 [head=phelps] [addr=6] [cop>rel1;nmod>arg4;nsubj>arg3;] Michael phelps} {arg3 [head=nigga] [addr=2] nigga} {arg4 [head=riot] [addr=9] [nmod>arg6;] riot} {arg6 [head=pussy] [addr=13] quality pussy}	2017-12-18 10:20:26+00
257	https://twitter.com/kamwas4sol/status/263201944410144768#1	https://twitter.com/kamwas4sol/status/263201944410144768	the death toll of riot victims camped in various parts	{arg1 [head=toll] [addr=5] [nmod>arg2;] death toll} {arg2 [head=victims] [addr=8] [acl>rel4;] riot victims} {rel4 [head=camped] [addr=9] [nmod>arg5;] camped} {arg5 [head=parts] [addr=12] various parts}	2017-12-18 10:20:26.001+00
258	https://twitter.com/kamwas4sol/status/263201944410144768#2	https://twitter.com/kamwas4sol/status/263201944410144768	rt @nigerianewsdesk the death toll of riot victims camped in various parts of ahoada east local government area of rivers state has in	{rel1 [head=has] [addr=22] has} {arg14 [head=State] [addr=21] Rivers State}	2017-12-18 10:20:26.003+00
259	https://twitter.com/vicanbi/status/263201848780005378#1	https://twitter.com/vicanbi/status/263201848780005378	causing rioting and power cuts live updates follow live updates	{rel1 [head=Follow] [addr=15] Follow} {arg3 [head=cuts] [addr=10] rioting cuts}	2017-12-18 10:20:26.004+00
260	https://twitter.com/vicanbi/status/263201848780005378#2	https://twitter.com/vicanbi/status/263201848780005378	outbreak hits us east coast causing rioting and power cuts	{arg1 [head=hits] [addr=2] [acl:relcl>dep>rel3;] outbreak hits} {rel3 [head=causing] [addr=6] [dobj>arg4;] causing} {arg4 [head=cuts] [addr=10] [compound>arg5;] cuts} {arg5 [head=rioting] [addr=7] rioting}	2017-12-18 10:20:26.006+00
261	https://twitter.com/vicanbi/status/263201848780005378#3	https://twitter.com/vicanbi/status/263201848780005378	causing rioting and power cuts live updates	{arg1 [head=updates] [addr=13] updates} {rel2 [head=live] [addr=12] [dobj>arg1;] live} {arg4 [head=cuts] [addr=10] [compound>arg5;] cuts} {arg5 [head=rioting] [addr=7] rioting}	2017-12-18 10:20:26.008+00
262	https://twitter.com/GuyvandenDries/status/263201905063362560#1	https://twitter.com/GuyvandenDries/status/263201905063362560	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.01+00
263	https://twitter.com/GuyvandenDries/status/263201905063362560#2	https://twitter.com/GuyvandenDries/status/263201905063362560	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.011+00
264	https://twitter.com/GuyvandenDries/status/263201905063362560#3	https://twitter.com/GuyvandenDries/status/263201905063362560	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.013+00
265	https://twitter.com/Grizzly332/status/263201940727554048#1	https://twitter.com/Grizzly332/status/263201940727554048	new york closed	{arg1 [head=York] [addr=8] [acl>rel2;] New York} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.015+00
266	https://twitter.com/Grizzly332/status/263201940727554048#2	https://twitter.com/Grizzly332/status/263201940727554048	now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=8] is} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=7] New York} {arg7 [head=it] [addr=2] it 's}	2017-12-18 10:20:26.017+00
267	https://twitter.com/Beamzzzy/status/263201982431498240#1	https://twitter.com/Beamzzzy/status/263201982431498240	to riot followers who have no interest in #combatsports	{arg1 [head=followers] [addr=4] [acl:relcl>rel2;] riot followers} {rel2 [head=have] [addr=6] have interest in}	2017-12-18 10:20:26.019+00
268	https://twitter.com/Beamzzzy/status/263201982431498240#2	https://twitter.com/Beamzzzy/status/263201982431498240	who have no interest in #combatsports but please follow	{arg1 [head=who] [addr=5] who} {rel2 [head=have] [addr=6] [xcomp>arg3;nsubj>arg1;] have} {arg3 [head=#CombatSports] [addr=10] interest #CombatSports}	2017-12-18 10:20:26.02+00
269	https://twitter.com/Beamzzzy/status/263201982431498240#3	https://twitter.com/Beamzzzy/status/263201982431498240	interest in #combatsports but please follow my #mma account @brettbeames 👊😺👊	{rel1 [head=please] [addr=12] please} {rel2 [head=follow] [addr=13] [discourse>rel1;nmod>arg5;dobj>arg6;] follow} {arg5 [head=👊😺👊] [addr=18] 👊😺👊} {arg6 [head=account] [addr=16] account}	2017-12-18 10:20:26.021+00
270	https://twitter.com/Beamzzzy/status/263201982431498240#4	https://twitter.com/Beamzzzy/status/263201982431498240	to riot followers who have no interest in #combatsports	{arg1 [head=followers] [addr=4] [acl:relcl>rel3;] riot followers} {rel3 [head=have] [addr=6] [xcomp>advmod>arg5;] have} {arg5 [head=interest] [addr=8] [neg] interest in}	2017-12-18 10:20:26.023+00
271	https://twitter.com/bekilouconnorsx/status/263201940987576321#1	https://twitter.com/bekilouconnorsx/status/263201940987576321	anyone remember what happened	{arg1 [head=anyone] [addr=2] anyone} {rel2 [head=remember] [addr=3] [nsubj>arg1;dobj>arg3;] remember} {arg3 [head=happened] [addr=5] happened}	2017-12-18 10:20:26.024+00
272	https://twitter.com/bekilouconnorsx/status/263201940987576321#2	https://twitter.com/bekilouconnorsx/status/263201940987576321	does anyone remember what happened	{arg1 [head=Does] [addr=1] Does} {rel2 [head=remember] [addr=3] [dep>arg1;] remember}	2017-12-18 10:20:26.026+00
273	https://twitter.com/bekilouconnorsx/status/263201940987576321#3	https://twitter.com/bekilouconnorsx/status/263201940987576321	yeah new york closed	{arg1 [head=Yeah] [addr=1] Yeah} {rel2 [head=closed] [addr=4] [dep>arg1;] closed}	2017-12-18 10:20:26.027+00
274	https://twitter.com/kt_illingsworth/status/263201978480480256#1	https://twitter.com/kt_illingsworth/status/263201978480480256	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.029+00
275	https://twitter.com/kt_illingsworth/status/263201978480480256#2	https://twitter.com/kt_illingsworth/status/263201978480480256	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.03+00
276	https://twitter.com/kt_illingsworth/status/263201978480480256#3	https://twitter.com/kt_illingsworth/status/263201978480480256	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.031+00
277	https://twitter.com/GrantTheBarber/status/263201842178162688#1	https://twitter.com/GrantTheBarber/status/263201842178162688	a blaze in a closed neighborhood right now	{arg1 [head=a] [addr=12] a} {rel2 [head=blaze] [addr=13] [nmod>arg3;nsubj>arg1;] blaze} {arg3 [head=right] [addr=18] closed neighborhood right now}	2017-12-18 10:20:26.033+00
278	https://twitter.com/GrantTheBarber/status/263201842178162688#2	https://twitter.com/GrantTheBarber/status/263201842178162688	more than 190 new york city firefighters are battling a blaze	{rel1 [head=are] [addr=10] are} {rel2 [head=battling] [addr=11] [aux>rel1;nsubj>arg4;ccomp>rel3;] battling} {rel3 [head=blaze] [addr=13] blaze} {arg4 [head=firefighters] [addr=9] More 190 New York City firefighters}	2017-12-18 10:20:26.035+00
279	https://twitter.com/celinechaverot/status/263201921186279424#1	https://twitter.com/celinechaverot/status/263201921186279424	jfk airport starting to become closed	{arg1 [head=AIRPORT] [addr=6] [acl>rel2;] JFK AIRPORT} {rel2 [head=STARTING] [addr=7] [xcomp>rel3;] STARTING} {rel3 [head=BECOME] [addr=9] [xcomp>rel4;] BECOME} {rel4 [head=closed] [addr=10] closed}	2017-12-18 10:20:26.037+00
280	https://twitter.com/danajayyy/status/263201922297774080#1	https://twitter.com/danajayyy/status/263201922297774080	new york closed	{arg1 [head=York] [addr=8] [acl>rel2;] New York} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.038+00
281	https://twitter.com/danajayyy/status/263201922297774080#2	https://twitter.com/danajayyy/status/263201922297774080	now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=8] is} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=7] New York} {arg7 [head=it] [addr=2] it 's}	2017-12-18 10:20:26.04+00
282	https://twitter.com/danajayyy/status/263201922297774080#3	https://twitter.com/danajayyy/status/263201922297774080	that shit is crazy	{rel1 [head=is] [addr=3] is} {arg2 [head=crazy] [addr=4] [cop>rel1;nsubj>arg3;] crazy} {arg3 [head=shit] [addr=2] shit}	2017-12-18 10:20:26.042+00
283	https://twitter.com/DillonBaba/status/263201855885160449#1	https://twitter.com/DillonBaba/status/263201855885160449	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.043+00
284	https://twitter.com/DillonBaba/status/263201855885160449#2	https://twitter.com/DillonBaba/status/263201855885160449	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.045+00
285	https://twitter.com/DillonBaba/status/263201855885160449#3	https://twitter.com/DillonBaba/status/263201855885160449	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.046+00
286	https://twitter.com/Annx4/status/263201915960188928#1	https://twitter.com/Annx4/status/263201915960188928	superstorm #outbreak rioting new york streets pics http://t.co/pnctcvxr" can we start taking climate change ser	{arg1 [head=PICS] [addr=12] PICS} {arg2 [head=Streets] [addr=10] [nmod>arg1;] Superstorm rioting New York Streets} {rel3 [head=start] [addr=17] [dep>arg2;xcomp>rel5;nsubj>arg4;] http://t.co/PncTcvxr" start} {arg4 [head=we] [addr=16] we} {rel5 [head=taking] [addr=18] [dobj>arg6;] taking} {arg6 [head=ser] [addr=21] climate change ser}	2017-12-18 10:20:26.048+00
287	https://twitter.com/Daan_F1/status/263201960944087040#1	https://twitter.com/Daan_F1/status/263201960944087040	rt @menoone71 the new york city subway closed & gt	{arg1 [head=gt] [addr=14] gt} {arg3 [head=Subway] [addr=7] [dep>rel4;] New York City Subway} {rel4 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.05+00
288	https://twitter.com/Disaster_Update/status/263201949040664577#1	https://twitter.com/Disaster_Update/status/263201949040664577	a blaze in a closed neighborhood right now	{arg1 [head=a] [addr=10] a} {rel2 [head=blaze] [addr=11] [nmod>arg3;nsubj>arg1;] blaze} {arg3 [head=right] [addr=16] closed neighborhood right now}	2017-12-18 10:20:26.052+00
289	https://twitter.com/Disaster_Update/status/263201949040664577#2	https://twitter.com/Disaster_Update/status/263201949040664577	more than 190 new york city firefighters are battling a blaze	{rel1 [head=are] [addr=8] are} {rel2 [head=battling] [addr=9] [aux>rel1;nsubj>arg4;ccomp>rel3;] battling} {rel3 [head=blaze] [addr=11] blaze} {arg4 [head=firefighters] [addr=7] More 190 New York City firefighters}	2017-12-18 10:20:26.053+00
290	https://twitter.com/kessamoruso/status/263226756767563776#1	https://twitter.com/kessamoruso/status/263226756767563776	ground zero closed 10 souls	{arg1 [head=Ground] [addr=9] [acl>rel2;] Ground Zero 10 souls} {rel2 [head=closed] [addr=11] closed}	2017-12-18 10:20:26.055+00
292	https://twitter.com/kessamoruso/status/263226756767563776#3	https://twitter.com/kessamoruso/status/263226756767563776	nyu hospital backup power failed ground zero closed 10 souls	{arg1 [head=power] [addr=6] [acl>rel2;] NYU Hospital backup power} {rel2 [head=failed] [addr=7] [dobj>arg3;] failed} {arg3 [head=Ground] [addr=9] Ground Zero 10 souls}	2017-12-18 10:20:26.059+00
293	https://twitter.com/kessamoruso/status/263226756767563776#4	https://twitter.com/kessamoruso/status/263226756767563776	ground zero closed 10 souls	{arg1 [head=souls] [addr=14] [genuine] 10 souls} {arg2 [head=Ground] [addr=9] [appos>arg1;acl>rel3;] Ground Zero} {rel3 [head=closed] [addr=11] closed}	2017-12-18 10:20:26.06+00
294	https://twitter.com/kessamoruso/status/263226756767563776#5	https://twitter.com/kessamoruso/status/263226756767563776	god be	{rel1 [head=be] [addr=3] be} {arg2 [head=God] [addr=1] [appos>rel1;] God}	2017-12-18 10:20:26.062+00
295	https://twitter.com/CraigHarrower/status/263201912495669249#1	https://twitter.com/CraigHarrower/status/263201912495669249	car tunnels are closed to	{rel1 [head=are] [addr=22] are} {rel2 [head=closed] [addr=23] [auxpass>rel1;nsubjpass>arg3;] closed} {arg3 [head=tunnels] [addr=21] car tunnels}	2017-12-18 10:20:26.063+00
296	https://twitter.com/CraigHarrower/status/263201912495669249#2	https://twitter.com/CraigHarrower/status/263201912495669249	has lower manhattan was left severely closed & amp new yorks subways & amp car tunnels are closed	{rel1 [head=are] [addr=22] are} {arg3 [head=tunnels] [addr=21] car tunnels} {rel6 [head=closed] [addr=10] closed}	2017-12-18 10:20:26.065+00
297	https://twitter.com/CraigHarrower/status/263201912495669249#3	https://twitter.com/CraigHarrower/status/263201912495669249	it has lower manhattan was left severely closed & amp	{rel1 [head=was] [addr=7] was} {rel4 [head=closed] [addr=10] closed} {arg6 [head=it] [addr=3] it}	2017-12-18 10:20:26.067+00
298	https://twitter.com/CraigHarrower/status/263201912495669249#4	https://twitter.com/CraigHarrower/status/263201912495669249	lower manhattan was left severely closed & amp new yorks subways & amp	{rel1 [head=was] [addr=7] was} {rel2 [head=left] [addr=8] [auxpass>rel1;] left severely} {arg3 [head=lower] [addr=5] [dep>conj>arg6;acl:relcl>rel2;acl>rel4;] lower} {rel4 [head=closed] [addr=10] closed} {arg6 [head=amp] [addr=18] amp}	2017-12-18 10:20:26.068+00
299	https://twitter.com/CraigHarrower/status/263201912495669249#5	https://twitter.com/CraigHarrower/status/263201912495669249	13 people were killed	{rel1 [head=were] [addr=3] were} {rel2 [head=killed] [addr=4] [auxpass>rel1;nsubjpass>arg3;] killed} {arg3 [head=people] [addr=2] 13 people}	2017-12-18 10:20:26.07+00
300	https://twitter.com/0O00000000/status/263201871735451648#1	https://twitter.com/0O00000000/status/263201871735451648	destroyed by fire in nyc http://t.co/plot4a4j	{arg1 [head=http-ESC_COLON-//t.co/pLOT4A4j] [addr=9] http://t.co/pLOT4A4j} {rel2 [head=destroyed] [addr=4] [dep>arg1;] destroyed}	2017-12-18 10:20:26.072+00
301	https://twitter.com/0O00000000/status/263201871735451648#2	https://twitter.com/0O00000000/status/263201871735451648	24 closed houses	{arg1 [head=houses] [addr=3] [amod>rel2;] 24 houses} {rel2 [head=closed] [addr=2] closed}	2017-12-18 10:20:26.073+00
302	https://twitter.com/0O00000000/status/263201871735451648#3	https://twitter.com/0O00000000/status/263201871735451648	24 closed houses destroyed by fire in nyc	{arg1 [head=houses] [addr=3] 24 closed houses} {rel2 [head=destroyed] [addr=4] [nmod>arg3;nsubj>arg1;] destroyed} {arg3 [head=fire] [addr=6] [nmod>arg5;] fire} {arg5 [head=NYC] [addr=8] NYC}	2017-12-18 10:20:26.075+00
303	https://twitter.com/SimpleWeather4U/status/263202022562615296#1	https://twitter.com/SimpleWeather4U/status/263202022562615296	virus warning for the following rivers in pennsylvania	{arg1 [head=virus] [addr=1] [dep>rel2;] virus} {rel2 [head=warning] [addr=2] [nmod>arg3;] warning} {arg3 [head=Rivers] [addr=6] [nmod>arg6;] Following Rivers} {arg6 [head=Pennsylvania] [addr=8] Pennsylvania}	2017-12-18 10:20:26.076+00
304	https://twitter.com/SimpleWeather4U/status/263202022562615296#2	https://twitter.com/SimpleWeather4U/status/263202022562615296	schuylkill river at pottstown affecting montgomery county	{arg1 [head=Pottstown] [addr=4] Pottstown} {arg3 [head=River] [addr=2] [nmod>arg1;] Schuylkill River} {rel4 [head=Affecting] [addr=5] [nsubj>arg3;dobj>arg5;] Affecting} {arg5 [head=County] [addr=7] Montgomery County}	2017-12-18 10:20:26.078+00
305	https://twitter.com/imiodunston/status/263201929902030848#1	https://twitter.com/imiodunston/status/263201929902030848	new york closed	{arg1 [head=York] [addr=8] [acl>rel2;] New York} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.08+00
306	https://twitter.com/imiodunston/status/263201929902030848#2	https://twitter.com/imiodunston/status/263201929902030848	it ’ s 2012 and new york is actually closed lol bye guys	{arg1 [head=it] [addr=2] it} {rel3 [head=closed] [addr=11] actually closed lol bye}	2017-12-18 10:20:26.081+00
307	https://twitter.com/imiodunston/status/263201929902030848#3	https://twitter.com/imiodunston/status/263201929902030848	’ s 2012 and new york is actually closed lol bye guys	{rel1 [head=is] [addr=9] is} {rel2 [head=closed] [addr=11] [auxpass>rel1;nsubjpass>conj>arg4;dobj>arg6;] actually closed} {arg4 [head=york] [addr=8] new york} {arg6 [head=guys] [addr=15] lol bye guys} {arg8 [head=s] [addr=4] [acl:relcl>rel2;] ’ s}	2017-12-18 10:20:26.083+00
308	https://twitter.com/malfletcher/status/263201987150106624#1	https://twitter.com/malfletcher/status/263201987150106624	me last night his team were strategising to mobilise	{rel1 [head=were] [addr=7] were} {rel2 [head=strategising] [addr=8] [xcomp>rel3;aux>rel1;nsubj>arg4;] strategising} {rel3 [head=mobilise] [addr=10] mobilise} {arg4 [head=me] [addr=2] me}	2017-12-18 10:20:26.085+00
309	https://twitter.com/amil0uise/status/263201913720426496#1	https://twitter.com/amil0uise/status/263201913720426496	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.086+00
310	https://twitter.com/amil0uise/status/263201913720426496#2	https://twitter.com/amil0uise/status/263201913720426496	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.088+00
311	https://twitter.com/amil0uise/status/263201913720426496#3	https://twitter.com/amil0uise/status/263201913720426496	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.09+00
312	https://twitter.com/nhannvuong/status/263201973375995904#1	https://twitter.com/nhannvuong/status/263201973375995904	just realised new yorks been closed	{rel1 [head=been] [addr=5] been} {rel2 [head=closed] [addr=6] [auxpass>rel1;] closed} {arg3 [head=yorks] [addr=4] [acl>rel2;] new yorks}	2017-12-18 10:20:26.092+00
333	https://twitter.com/_SweetHoneey_/status/263202008746586112#1	https://twitter.com/_SweetHoneey_/status/263202008746586112	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.123+00
313	https://twitter.com/Poploverr585/status/263201869093036032#1	https://twitter.com/Poploverr585/status/263201869093036032	when you realize that in the movie 2012 new york city closed and now it 's 2012 and new york cit	{arg1 [head=movie] [addr=12] movie 2012} {arg4 [head=City] [addr=17] [conj>arg7;acl>rel6;] New York City} {rel6 [head=closed] [addr=18] closed} {arg7 [head=it] [addr=21] [dep>conj>arg10;] now it 's} {arg10 [head=Cit] [addr=27] New York Cit}	2017-12-18 10:20:26.094+00
314	https://twitter.com/Poploverr585/status/263201869093036032#2	https://twitter.com/Poploverr585/status/263201869093036032	that awkward moment when you realize that in the movie 2012 new york city	{arg1 [head=moment] [addr=5] [acl:relcl>rel2;] awkward moment} {rel2 [head=realize] [addr=8] [nsubj>arg7;nmod>arg5;dobj>arg3;] when realize New York} {arg3 [head=that] [addr=9] that} {arg5 [head=movie] [addr=12] movie 2012} {arg7 [head=you] [addr=7] you}	2017-12-18 10:20:26.095+00
315	https://twitter.com/LasiewickiAnn/status/263222115120082945#1	https://twitter.com/LasiewickiAnn/status/263222115120082945	rt @breakingnews rumors of nyse trading floor rioting are not true says nyse	{arg1 [head=RT @BreakingNews] [addr=1] RT @BreakingNews} {rel2 [head=says] [addr=13] [nsubj>arg1;dobj>arg3;] says} {arg3 [head=NYSE] [addr=14] NYSE}	2017-12-18 10:20:26.097+00
316	https://twitter.com/LasiewickiAnn/status/263222115120082945#2	https://twitter.com/LasiewickiAnn/status/263222115120082945	of nyse trading floor rioting are not true	{rel1 [head=are] [addr=9] are} {arg2 [head=true] [addr=11] [neg] [cop>rel1;] true} {arg3 [head=rioting] [addr=8] [fake] [acl:relcl>arg2;] NYSE trading floor rioting}	2017-12-18 10:20:26.099+00
317	https://twitter.com/LasiewickiAnn/status/263222115120082945#3	https://twitter.com/LasiewickiAnn/status/263222115120082945	rt @breakingnews rumors of nyse trading floor rioting are not true says nyse	{rel1 [head=are] [addr=9] are} {arg3 [head=rioting] [addr=8] [fake] [compound>arg5;acl:relcl>cop>rel1;] trading floor rioting} {arg5 [head=NYSE] [addr=5] NYSE} {arg6 [head=Rumors] [addr=3] [nmod>arg3;] Rumors} {rel8 [head=says] [addr=13] [nsubj>dep>arg6;] says}	2017-12-18 10:20:26.1+00
318	https://twitter.com/divarabena/status/263201871093702656#1	https://twitter.com/divarabena/status/263201871093702656	it will take up to 4 days	{arg1 [head=It] [addr=3] It} {rel2 [head=take] [addr=5] [nmod:tmod>arg3;nsubj>arg1;] take} {arg3 [head=days] [addr=9] 4 days}	2017-12-18 10:20:26.101+00
319	https://twitter.com/divarabena/status/263201871093702656#2	https://twitter.com/divarabena/status/263201871093702656	take up to 4 days to get angry crowd out of ny subway tunnels a metro transit authority	{arg1 [head=Authority] [addr=23] Metro Transit Authority} {arg2 [head=tunnels] [addr=18] [appos>arg1;] NY subway tunnels} {rel5 [head=get] [addr=11] [nmod>arg2;dobj>arg6;] get} {arg6 [head=crowd] [addr=13] angry crowd} {arg8 [head=days] [addr=9] 4 days}	2017-12-18 10:20:26.102+00
320	https://twitter.com/Greg_Duffield/status/263201890240720896#1	https://twitter.com/Greg_Duffield/status/263201890240720896	new york closed	{arg1 [head=YORK] [addr=8] [acl>rel2;] NEW YORK} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.104+00
321	https://twitter.com/Greg_Duffield/status/263201890240720896#2	https://twitter.com/Greg_Duffield/status/263201890240720896	now its 's 2012 and new york is rioting	{rel1 [head=IS] [addr=8] IS} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg3;] NOW rioting} {arg3 [head='S] [addr=3] 'S}	2017-12-18 10:20:26.105+00
322	https://twitter.com/RallyGallery/status/263201916018888704#1	https://twitter.com/RallyGallery/status/263201916018888704	four killed nyc menaced by catastrophic rioting as outbreak plows ashore http://t.co/r5ixmzg3 look	{rel1 [head=killed] [addr=4] killed} {arg2 [head=Four] [addr=3] [acl>rel1;] Four NYC} {arg3 [head=look] [addr=18] [nsubj>arg2;] look}	2017-12-18 10:20:26.107+00
323	https://twitter.com/RallyGallery/status/263201916018888704#2	https://twitter.com/RallyGallery/status/263201916018888704	four killed nyc menaced by catastrophic rioting as outbreak plows ashore http://t.co/r5ixmzg3 look at the slideshow	{arg1 [head=outbreak] [addr=12] outbreak} {rel2 [head=plows] [addr=13] [nsubj>arg1;] plows ashore} {arg4 [head=rioting] [addr=10] catastrophic rioting} {rel8 [head=look] [addr=18] [nsubj>appos>acl>advcl>rel2;nsubj>appos>acl>nmod>arg4;nmod>arg9;] look} {arg9 [head=slideshow] [addr=21] slideshow}	2017-12-18 10:20:26.108+00
324	https://twitter.com/saycoolnaga/status/263201941901950979#1	https://twitter.com/saycoolnaga/status/263201941901950979	rioting so bad the sharks are out to play	{arg1 [head=rioting] [addr=5] rioting} {rel2 [head=bad] [addr=7] [nsubj>arg1;] so bad are}	2017-12-18 10:20:26.11+00
325	https://twitter.com/saycoolnaga/status/263201941901950979#2	https://twitter.com/saycoolnaga/status/263201941901950979	the sharks are out to play	{rel1 [head=are] [addr=10] are} {rel3 [head=play] [addr=13] play} {arg4 [head=sharks] [addr=9] sharks}	2017-12-18 10:20:26.112+00
326	https://twitter.com/saycoolnaga/status/263201941901950979#3	https://twitter.com/saycoolnaga/status/263201941901950979	is it real	{rel1 [head=is] [addr=3] is} {arg2 [head=real] [addr=5] [cop>rel1;nsubj>arg3;] real} {arg3 [head=it] [addr=4] [genuine] it}	2017-12-18 10:20:26.113+00
327	https://twitter.com/saycoolnaga/status/263201941901950979#4	https://twitter.com/saycoolnaga/status/263201941901950979	is it real	{rel1 [head=is] [addr=3] is} {arg2 [head=real] [addr=5] [cop>rel1;] real}	2017-12-18 10:20:26.114+00
328	https://twitter.com/EverSoMe96/status/263202000978731008#1	https://twitter.com/EverSoMe96/status/263202000978731008	new york closed did n't it	{rel1 [head=did] [addr=4] did} {arg3 [head=York] [addr=2] [acl>rel4;] New York} {rel4 [head=closed] [addr=3] closed}	2017-12-18 10:20:26.115+00
329	https://twitter.com/EverSoMe96/status/263202000978731008#2	https://twitter.com/EverSoMe96/status/263202000978731008	new york closed did n't it in the film the day	{rel1 [head=did] [addr=4] did} {arg2 [head=it] [addr=6] [neg] [aux>rel1;nmod>arg3;nsubj>arg6;] it} {arg3 [head=film] [addr=9] [dep>arg5;] film} {arg5 [head=day] [addr=11] day} {arg6 [head=York] [addr=2] [acl>rel7;] New York} {rel7 [head=closed] [addr=3] closed}	2017-12-18 10:20:26.117+00
330	https://twitter.com/nbcaaron/status/263201909786152960#1	https://twitter.com/nbcaaron/status/263201909786152960	rt @first4traffic in va gallows rd is closed	{arg1 [head=RT @First4Traffic] [addr=1] RT @First4Traffic} {rel2 [head=closed] [addr=9] [dep>arg1;] Gallows closed}	2017-12-18 10:20:26.118+00
331	https://twitter.com/nbcaaron/status/263201909786152960#2	https://twitter.com/nbcaaron/status/263201909786152960	gallows rd is closed at arlington blvd due to rioting in the area	{rel1 [head=is] [addr=8] is} {rel2 [head=closed] [addr=9] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;] closed} {arg3 [head=Rd] [addr=7] Gallows Rd} {arg4 [head=Blvd] [addr=12] [amod>nmod>arg7;] Arlington Blvd due} {arg7 [head=rioting] [addr=15] [nmod>arg9;] rioting} {arg9 [head=area] [addr=18] area}	2017-12-18 10:20:26.12+00
332	https://twitter.com/nbcaaron/status/263201909786152960#3	https://twitter.com/nbcaaron/status/263201909786152960	in va gallows rd is closed at arlington blvd due to rioting	{rel1 [head=is] [addr=8] is} {rel2 [head=closed] [addr=9] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;nmod>arg6;] closed} {arg3 [head=Rd] [addr=7] Gallows Rd} {arg4 [head=VA] [addr=4] VA} {arg6 [head=Blvd] [addr=12] [amod>nmod>arg9;] Arlington Blvd due} {arg9 [head=rioting] [addr=15] rioting}	2017-12-18 10:20:26.122+00
334	https://twitter.com/_SweetHoneey_/status/263202008746586112#2	https://twitter.com/_SweetHoneey_/status/263202008746586112	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.125+00
335	https://twitter.com/_SweetHoneey_/status/263202008746586112#3	https://twitter.com/_SweetHoneey_/status/263202008746586112	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.127+00
336	https://twitter.com/sioned_lewis/status/263202005068169216#1	https://twitter.com/sioned_lewis/status/263202005068169216	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.128+00
337	https://twitter.com/sioned_lewis/status/263202005068169216#2	https://twitter.com/sioned_lewis/status/263202005068169216	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.13+00
338	https://twitter.com/sioned_lewis/status/263202005068169216#3	https://twitter.com/sioned_lewis/status/263202005068169216	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.131+00
339	https://twitter.com/ArtDeity/status/263096344875515904#1	https://twitter.com/ArtDeity/status/263096344875515904	by outbreak just took this pic a few minutes ago	{arg1 [head=outbreak] [addr=11] [dep>rel3;] outbreak} {rel3 [head=took] [addr=14] [advmod>arg4;dobj>arg5;] just took} {arg4 [head=minutes] [addr=19] few minutes ago} {arg5 [head=pic] [addr=16] pic}	2017-12-18 10:20:26.133+00
340	https://twitter.com/ArtDeity/status/263096344875515904#2	https://twitter.com/ArtDeity/status/263096344875515904	fdr drive southbound is totally closed by outbreak	{rel1 [head=is] [addr=7] is} {rel2 [head=closed] [addr=9] [auxpass>rel1;nmod>arg3;] southbound totally closed} {arg3 [head=outbreak] [addr=11] outbreak} {arg5 [head=Drive] [addr=5] [dep>rel2;] FDR Drive}	2017-12-18 10:20:26.135+00
341	https://twitter.com/ArtDeity/status/263096344875515904#3	https://twitter.com/ArtDeity/status/263096344875515904	fdr drive southbound is totally closed	{arg1 [head=FDR] [addr=4] FDR} {rel3 [head=closed] [addr=9] southbound totally closed}	2017-12-18 10:20:26.136+00
342	https://twitter.com/RiverSwami/status/263201844409552896#1	https://twitter.com/RiverSwami/status/263201844409552896	stream flow gauges @	{arg1 [head=flow] [addr=17] stream flow} {rel2 [head=gauges] [addr=18] [nsubj>arg1;dobj>arg3;] gauges} {arg3 [head=@] [addr=19] @}	2017-12-18 10:20:26.138+00
343	https://twitter.com/RiverSwami/status/263201844409552896#2	https://twitter.com/RiverSwami/status/263201844409552896	get current conditions on #delaware #river & amp live	{arg1 [head=Get] [addr=1] [ccomp>rel2;] Get} {rel2 [head=live] [addr=10] live}	2017-12-18 10:20:26.14+00
344	https://twitter.com/RiverSwami/status/263201844409552896#3	https://twitter.com/RiverSwami/status/263201844409552896	get current conditions on #delaware #river & amp live feeds of all #nj #pa stream flow gauges	{arg1 [head=amp] [addr=8] amp} {arg4 [head=conditions] [addr=3] [conj>arg1;] current conditions} {rel5 [head=live] [addr=10] [nsubj>arg4;] live} {rel7 [head=feeds] [addr=11] [csubj>ccomp>rel5;] feeds} {arg9 [head=flow] [addr=17] stream flow}	2017-12-18 10:20:26.141+00
345	https://twitter.com/KLooby77/status/263202021002326016#1	https://twitter.com/KLooby77/status/263202021002326016	rioting so bad the sharks are out to play	{arg1 [head=rioting] [addr=5] rioting} {rel2 [head=bad] [addr=7] [nsubj>arg1;] so bad are}	2017-12-18 10:20:26.142+00
346	https://twitter.com/KLooby77/status/263202021002326016#2	https://twitter.com/KLooby77/status/263202021002326016	the sharks are out to play	{rel1 [head=are] [addr=10] are} {rel3 [head=play] [addr=13] play} {arg4 [head=sharks] [addr=9] sharks}	2017-12-18 10:20:26.143+00
347	https://twitter.com/KLooby77/status/263202021002326016#3	https://twitter.com/KLooby77/status/263202021002326016	is it real	{rel1 [head=is] [addr=3] is} {arg2 [head=real] [addr=5] [cop>rel1;nsubj>arg3;] real} {arg3 [head=it] [addr=4] [genuine] it}	2017-12-18 10:20:26.145+00
348	https://twitter.com/KLooby77/status/263202021002326016#4	https://twitter.com/KLooby77/status/263202021002326016	is it real	{rel1 [head=is] [addr=3] is} {arg2 [head=real] [addr=5] [cop>rel1;] real}	2017-12-18 10:20:26.146+00
349	https://twitter.com/pop_goes_the/status/263068396311166976#1	https://twitter.com/pop_goes_the/status/263068396311166976	is fedres building	{rel1 [head=is] [addr=12] is} {arg2 [head=Building] [addr=14] [cop>rel1;] FedRes Building}	2017-12-18 10:20:26.147+00
350	https://twitter.com/pop_goes_the/status/263068396311166976#2	https://twitter.com/pop_goes_the/status/263068396311166976	that nyse closed and	{arg1 [head=NYSE] [addr=8] [acl>rel3;] NYSE} {rel3 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.149+00
351	https://twitter.com/SimpleWeather4U/status/263202016896110592#1	https://twitter.com/SimpleWeather4U/status/263202016896110592	virus warning for the following rivers in pennsylvania	{arg1 [head=virus] [addr=1] [dep>rel2;] virus} {rel2 [head=warning] [addr=2] [nmod>arg3;] warning} {arg3 [head=Rivers] [addr=6] [nmod>arg6;] Following Rivers} {arg6 [head=Pennsylvania] [addr=8] Pennsylvania}	2017-12-18 10:20:26.15+00
352	https://twitter.com/SimpleWeather4U/status/263202016896110592#2	https://twitter.com/SimpleWeather4U/status/263202016896110592	schuylkill river at pottstown affecting montgomery county	{arg1 [head=Pottstown] [addr=4] Pottstown} {arg3 [head=River] [addr=2] [nmod>arg1;] Schuylkill River} {rel4 [head=Affecting] [addr=5] [nsubj>arg3;dobj>arg5;] Affecting} {arg5 [head=County] [addr=7] Montgomery County}	2017-12-18 10:20:26.152+00
353	https://twitter.com/NYCBoilermaker/status/263201892824395778#1	https://twitter.com/NYCBoilermaker/status/263201892824395778	us army is at the queens breezy point fire with 7 ton trucks escorting firemen into riot zone	{rel1 [head=is] [addr=6] is} {arg9 [head=riot] [addr=20] riot}	2017-12-18 10:20:26.154+00
354	https://twitter.com/NYCBoilermaker/status/263201892824395778#2	https://twitter.com/NYCBoilermaker/status/263201892824395778	us army is at the queens breezy point fire with 7 ton trucks escorting firemen into riot zone	{arg1 [head=Queens] [addr=9] Queens} {arg2 [head=fire] [addr=12] [compound>arg1;] Breezy Point fire} {arg4 [head=trucks] [addr=16] [acl>rel6;] 7 ton trucks} {rel6 [head=escorting] [addr=17] [nmod>arg7;dobj>arg9;] escorting} {arg7 [head=zone] [addr=21] riot zone} {arg9 [head=firemen] [addr=18] firemen}	2017-12-18 10:20:26.155+00
376	https://twitter.com/MyExplodingPen/status/263096205368758272#3	https://twitter.com/MyExplodingPen/status/263096205368758272	#outbreak is taking occupy wall street	{rel1 [head=is] [addr=2] is} {rel2 [head=taking] [addr=3] [aux>rel1;nsubj>arg3;] taking Wall} {arg3 [head=#outbreak] [addr=1] #outbreak}	2017-12-18 10:20:26.192+00
355	https://twitter.com/NYCBoilermaker/status/263201892824395778#3	https://twitter.com/NYCBoilermaker/status/263201892824395778	the us army is at the queens breezy point fire with 7 ton trucks	{rel1 [head=is] [addr=6] is} {arg2 [head=fire] [addr=12] [cop>rel1;compound>arg3;] Breezy Point fire} {arg3 [head=Queens] [addr=9] Queens} {arg4 [head=US] [addr=4] [acl:relcl>arg2;nmod>arg5;] US} {arg5 [head=trucks] [addr=16] 7 ton trucks}	2017-12-18 10:20:26.157+00
356	https://twitter.com/duddaz87/status/263201891800977408#1	https://twitter.com/duddaz87/status/263201891800977408	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.159+00
357	https://twitter.com/duddaz87/status/263201891800977408#2	https://twitter.com/duddaz87/status/263201891800977408	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.161+00
358	https://twitter.com/duddaz87/status/263201891800977408#3	https://twitter.com/duddaz87/status/263201891800977408	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.162+00
359	https://twitter.com/v1rupa/status/263202009652527106#1	https://twitter.com/v1rupa/status/263202009652527106	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.164+00
360	https://twitter.com/v1rupa/status/263202009652527106#2	https://twitter.com/v1rupa/status/263202009652527106	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.165+00
361	https://twitter.com/v1rupa/status/263202009652527106#3	https://twitter.com/v1rupa/status/263202009652527106	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.167+00
362	https://twitter.com/Jane_WI/status/263227556705230848#1	https://twitter.com/Jane_WI/status/263227556705230848	rt @lawsonbulk 670 000 without power in nyc riot crests 13.88 feet besting 1960 record	{arg1 [head=RT @Lawsonbulk] [addr=1] [acl>rel2;] RT @Lawsonbulk 000} {rel2 [head=besting] [addr=16] besting 1960}	2017-12-18 10:20:26.169+00
363	https://twitter.com/Jane_WI/status/263227556705230848#2	https://twitter.com/Jane_WI/status/263227556705230848	wall street closed	{arg1 [head=Street] [addr=24] [acl>rel2;] Wall Street} {rel2 [head=closed] [addr=25] closed}	2017-12-18 10:20:26.17+00
364	https://twitter.com/Jane_WI/status/263227556705230848#3	https://twitter.com/Jane_WI/status/263227556705230848	rt @lawsonbulk 670 000 without power in nyc riot crests 13.88 feet besting 1960 record	{arg1 [head=NYC] [addr=9] NYC} {arg7 [head=crests] [addr=12] [dep>arg8;] riot crests} {arg8 [head=feet] [addr=14] 13.88 feet} {rel9 [head=besting] [addr=16] [dobj>arg10;] besting} {arg10 [head=record] [addr=18] 1960 record}	2017-12-18 10:20:26.172+00
365	https://twitter.com/Jane_WI/status/263227556705230848#4	https://twitter.com/Jane_WI/status/263227556705230848	rt @lawsonbulk 670 000 without power in nyc riot crests 13.88 feet besting 1960 record of 10.02 feet wall street	{arg1 [head=feet] [addr=14] 13.88 feet} {arg2 [head=crests] [addr=12] [dep>arg1;] riot crests} {rel4 [head=besting] [addr=16] [dobj>arg5;] besting} {arg5 [head=record] [addr=18] [dep>arg6;] 1960 record} {arg6 [head=Street] [addr=24] Wall Street}	2017-12-18 10:20:26.174+00
366	https://twitter.com/RobstenBaby/status/263201853179850752#1	https://twitter.com/RobstenBaby/status/263201853179850752	new york closed	{arg1 [head=York] [addr=8] [acl>rel2;] New York} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.176+00
367	https://twitter.com/RobstenBaby/status/263201853179850752#2	https://twitter.com/RobstenBaby/status/263201853179850752	now it 's 2012 and new york is rioting	{rel1 [head=is] [addr=8] is} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg5;] rioting} {arg5 [head=York] [addr=7] New York} {arg7 [head=it] [addr=2] it 's}	2017-12-18 10:20:26.177+00
368	https://twitter.com/dolmancpvglg5/status/263201934331236352#1	https://twitter.com/dolmancpvglg5/status/263201934331236352	the new york stock exchange is closed you mean we	{rel1 [head=is] [addr=10] is} {rel2 [head=closed] [addr=11] [ccomp>nsubj>arg4;auxpass>rel1;] closed} {arg4 [head=You] [addr=12] You} {arg5 [head=Exchange] [addr=9] [acl:relcl>rel2;] New York Stock Exchange}	2017-12-18 10:20:26.179+00
369	https://twitter.com/dolmancpvglg5/status/263201934331236352#2	https://twitter.com/dolmancpvglg5/status/263201934331236352	new york stock exchange is closed	{rel1 [head=is] [addr=10] is} {arg4 [head=New] [addr=6] New}	2017-12-18 10:20:26.181+00
370	https://twitter.com/dolmancpvglg5/status/263201934331236352#3	https://twitter.com/dolmancpvglg5/status/263201934331236352	is closed you mean we have to bail out wall street again	{rel1 [head=closed] [addr=11] [nmod>arg2;] closed} {arg2 [head=Street] [addr=20] Wall Street again}	2017-12-18 10:20:26.182+00
371	https://twitter.com/jaredhealey/status/263201898746740736#1	https://twitter.com/jaredhealey/status/263201898746740736	in the front yard of a closed home in brigantine beach new jersey #outbreak pic	{arg1 [head=yard] [addr=11] [nmod>arg3;] front yard} {arg3 [head=home] [addr=15] [nmod>arg6;] closed home} {arg6 [head=pic] [addr=23] Brigantine Beach New Jersey pic}	2017-12-18 10:20:26.184+00
372	https://twitter.com/jaredhealey/status/263201898746740736#2	https://twitter.com/jaredhealey/status/263201898746740736	was photographed swimming in the front yard of a closed home	{arg1 [head=swimming] [addr=7] swimming} {arg4 [head=yard] [addr=11] [nmod>arg6;] front yard} {arg6 [head=home] [addr=15] closed home}	2017-12-18 10:20:26.186+00
373	https://twitter.com/jaredhealey/status/263201898746740736#3	https://twitter.com/jaredhealey/status/263201898746740736	a shark was photographed swimming in the front yard	{rel1 [head=was] [addr=5] was} {rel2 [head=photographed] [addr=6] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;dobj>arg6;] photographed} {arg3 [head=shark] [addr=4] shark} {arg4 [head=yard] [addr=11] front yard} {arg6 [head=swimming] [addr=7] swimming}	2017-12-18 10:20:26.187+00
374	https://twitter.com/MyExplodingPen/status/263096205368758272#1	https://twitter.com/MyExplodingPen/status/263096205368758272	the ny stock exchange is closed	{rel1 [head=is] [addr=6] is} {rel2 [head=closed] [addr=7] [auxpass>rel1;] closed} {arg3 [head=Exchange] [addr=5] [acl:relcl>rel2;] NY Stock Exchange}	2017-12-18 10:20:26.189+00
375	https://twitter.com/MyExplodingPen/status/263096205368758272#2	https://twitter.com/MyExplodingPen/status/263096205368758272	ny stock exchange is closed	{rel1 [head=is] [addr=6] is} {arg4 [head=NY] [addr=3] NY}	2017-12-18 10:20:26.19+00
377	https://twitter.com/MyExplodingPen/status/263096205368758272#4	https://twitter.com/MyExplodingPen/status/263096205368758272	taking occupy wall street	{arg1 [head=taking] [addr=3] [ccomp>rel2;] taking} {rel2 [head=Occupy] [addr=4] Occupy Wall}	2017-12-18 10:20:26.194+00
378	https://twitter.com/MyExplodingPen/status/263096205368758272#5	https://twitter.com/MyExplodingPen/status/263096205368758272	you go girl	{arg1 [head=You] [addr=1] [dep>rel2;] You} {rel2 [head=go] [addr=2] [dobj>arg3;] go} {arg3 [head=girl] [addr=3] girl}	2017-12-18 10:20:26.195+00
379	https://twitter.com/badgerthebear/status/263111572598177792#1	https://twitter.com/badgerthebear/status/263111572598177792	this pictures been floating around the net	{rel1 [head=been] [addr=3] been} {rel2 [head=floating] [addr=4] [aux>rel1;nmod>arg3;nsubj>arg5;] floating} {arg3 [head=net] [addr=7] net} {arg5 [head=pictures] [addr=2] pictures}	2017-12-18 10:20:26.197+00
380	https://twitter.com/badgerthebear/status/263111572598177792#2	https://twitter.com/badgerthebear/status/263111572598177792	stay safe people http://t.co/82nyofkz	{arg1 [head=http-ESC_COLON-//t.co/82NYOFkz] [addr=4] http://t.co/82NYOFkz} {rel2 [head=Stay] [addr=1] [dep>arg1;] Stay safe}	2017-12-18 10:20:26.199+00
381	https://twitter.com/fingabandit/status/263201977440288768#1	https://twitter.com/fingabandit/status/263201977440288768	over a dozen houses in closed nyc neighborhood	{arg1 [head=houses] [addr=12] [nmod>arg2;] over a dozen houses} {arg2 [head=neighborhood] [addr=16] closed NYC neighborhood}	2017-12-18 10:20:26.2+00
382	https://twitter.com/fingabandit/status/263201977440288768#2	https://twitter.com/fingabandit/status/263201977440288768	smdh = @foxnews firefighters battle blaze involving over a dozen houses	{arg1 [head=SMDH] [addr=1] SMDH =} {arg2 [head=battle] [addr=6] [nsubj>arg1;ccomp>rel3;] battle} {rel3 [head=blaze] [addr=7] [xcomp>rel4;] blaze} {rel4 [head=involving] [addr=8] [dobj>arg5;] involving} {arg5 [head=houses] [addr=12] over a dozen houses}	2017-12-18 10:20:26.202+00
383	https://twitter.com/Mokamsingh/status/263218154279407616#1	https://twitter.com/Mokamsingh/status/263218154279407616	it has n't happened	{rel1 [head=has] [addr=22] has} {arg3 [head=it] [addr=21] it}	2017-12-18 10:20:26.203+00
384	https://twitter.com/Mokamsingh/status/263218154279407616#2	https://twitter.com/Mokamsingh/status/263218154279407616	it has n't happened	{rel1 [head=has] [addr=22] has} {rel2 [head=happened] [addr=24] [neg] [aux>rel1;nsubj>arg3;] happened} {arg3 [head=it] [addr=21] it}	2017-12-18 10:20:26.205+00
385	https://twitter.com/Mokamsingh/status/263218154279407616#3	https://twitter.com/Mokamsingh/status/263218154279407616	it was a false report	{rel1 [head=was] [addr=4] was} {arg3 [head=It] [addr=3] It}	2017-12-18 10:20:26.207+00
386	https://twitter.com/Mokamsingh/status/263218154279407616#4	https://twitter.com/Mokamsingh/status/263218154279407616	it was a false report on virus outbreak	{rel1 [head=was] [addr=4] was} {arg2 [head=report] [addr=7] [fake] [cop>rel1;nmod>arg4;nsubj>arg3;] false report} {arg3 [head=It] [addr=3] It} {arg4 [head=outbreak] [addr=10] virus outbreak}	2017-12-18 10:20:26.208+00
387	https://twitter.com/Mokamsingh/status/263218154279407616#5	https://twitter.com/Mokamsingh/status/263218154279407616	report on virus outbreak doing an occupy wall st and rioting the nyse it has n't happened	{arg1 [head=it] [addr=21] it} {arg4 [head=outbreak] [addr=10] [acl>rel6;] virus outbreak} {rel6 [head=doing] [addr=11] [ccomp>rel7;] doing} {rel7 [head=Occupy] [addr=13] [xcomp>arg8;] Occupy} {arg8 [head=NYSE] [addr=19] [nsubj>arg9;] NYSE} {arg9 [head=St] [addr=15] [conj>arg10;] Wall St} {arg10 [head=rioting] [addr=17] rioting}	2017-12-18 10:20:26.209+00
388	https://twitter.com/Mokamsingh/status/263218154279407616#6	https://twitter.com/Mokamsingh/status/263218154279407616	a false report on virus outbreak doing an occupy wall st and rioting the nyse	{arg1 [head=report] [addr=7] [fake] [nmod>arg2;] false report} {arg2 [head=outbreak] [addr=10] [acl>rel4;] virus outbreak} {rel4 [head=doing] [addr=11] [ccomp>rel5;] doing} {rel5 [head=Occupy] [addr=13] [xcomp>arg6;] Occupy} {arg6 [head=NYSE] [addr=19] [nsubj>arg7;] NYSE} {arg7 [head=St] [addr=15] [conj>arg8;] Wall St} {arg8 [head=rioting] [addr=17] rioting}	2017-12-18 10:20:26.211+00
389	https://twitter.com/Habuarsenal/status/263201947820097536#1	https://twitter.com/Habuarsenal/status/263201947820097536	the death toll of riot victims camped in various parts of ahoada east local government area of rivers state has increased	{rel1 [head=has] [addr=20] has} {rel2 [head=increased] [addr=21] [aux>rel1;nsubj>arg3;] increased} {arg3 [head=toll] [addr=3] death toll}	2017-12-18 10:20:26.213+00
390	https://twitter.com/SummerFreezeWWE/status/263081122823540737#1	https://twitter.com/SummerFreezeWWE/status/263081122823540737	cars are literally floating down wall street	{rel1 [head=are] [addr=2] are} {rel2 [head=floating] [addr=4] [aux>rel1;nmod>arg3;nsubj>arg5;] literally floating} {arg3 [head=Street] [addr=7] Wall Street} {arg5 [head=cars] [addr=1] cars}	2017-12-18 10:20:26.215+00
391	https://twitter.com/SummerFreezeWWE/status/263081122823540737#2	https://twitter.com/SummerFreezeWWE/status/263081122823540737	the east river is rioting from the right	{rel1 [head=is] [addr=4] is} {arg2 [head=rioting] [addr=5] [cop>rel1;nmod>arg3;nsubj>arg5;] rioting} {arg3 [head=right] [addr=8] right} {arg5 [head=River] [addr=3] East River}	2017-12-18 10:20:26.217+00
392	https://twitter.com/bramleyclarence/status/263201872335228928#1	https://twitter.com/bramleyclarence/status/263201872335228928	new york closed	{arg1 [head=YORK] [addr=8] [acl>rel2;] NEW YORK} {rel2 [head=closed] [addr=9] closed}	2017-12-18 10:20:26.218+00
393	https://twitter.com/bramleyclarence/status/263201872335228928#2	https://twitter.com/bramleyclarence/status/263201872335228928	now its 's 2012 and new york is rioting	{rel1 [head=IS] [addr=8] IS} {arg2 [head=rioting] [addr=9] [cop>rel1;nsubj>arg3;] NOW rioting} {arg3 [head='S] [addr=3] 'S}	2017-12-18 10:20:26.22+00
394	https://twitter.com/smiles_giggles/status/263201944720510976#1	https://twitter.com/smiles_giggles/status/263201944720510976	good morning i just pulled up at my job and the parking lot is closed	{rel1 [head=is] [addr=14] is} {rel2 [head=closed] [addr=15] [auxpass>rel1;nsubjpass>arg3;] closed} {arg3 [head=morning] [addr=2] Good morning}	2017-12-18 10:20:26.221+00
395	https://twitter.com/MlleChouChoo/status/263202002488655872#1	https://twitter.com/MlleChouChoo/status/263202002488655872	pics i took in harlem as outbreak subsides	{arg1 [head=Pics] [addr=3] [acl:relcl>rel2;] Pics} {rel2 [head=took] [addr=5] [nmod>arg3;nmod>arg5;] took} {arg3 [head=Harlem] [addr=7] Harlem} {arg5 [head=subsides] [addr=10] outbreak subsides}	2017-12-18 10:20:26.223+00
396	https://twitter.com/peiliguooo/status/264515493803724801#1	https://twitter.com/peiliguooo/status/264515493803724801	an expert on venice rioting about efforts to protect the city	{arg1 [head=rioting] [addr=17] Venice rioting} {arg3 [head=expert] [addr=14] [nmod>arg1;nmod>arg4;] expert} {arg4 [head=efforts] [addr=19] [acl>rel6;] efforts} {rel6 [head=protect] [addr=21] [dobj>arg7;] protect} {arg7 [head=city] [addr=23] city}	2017-12-18 10:27:43.107+00
418	https://twitter.com/kTiNoJ/status/264516036567654400#1	https://twitter.com/kTiNoJ/status/264516036567654400	closed aquarium may evacuate fish http://t.co/kcnlqj7a	{arg1 [head=http-ESC_COLON-//t.co/kcnLQj7a] [addr=6] http://t.co/kcnLQj7a} {rel2 [head=closed] [addr=1] [dep>arg1;] closed}	2017-12-18 10:27:43.151+00
397	https://twitter.com/peiliguooo/status/264515493803724801#2	https://twitter.com/peiliguooo/status/264515493803724801	rt @pritheworld lisa speaks w rafael bras provost at @georgiatech and an expert on venice rioting	{arg1 [head=Lisa] [addr=3] Lisa} {rel2 [head=speaks] [addr=4] [nsubj>arg1;dobj>arg3;dobj>arg4;] speaks} {arg3 [head=Bras] [addr=7] w Rafael Bras} {arg4 [head=Provost] [addr=9] Provost at} {arg6 [head=expert] [addr=14] [nmod>arg7;] expert} {arg7 [head=rioting] [addr=17] Venice rioting}	2017-12-18 10:27:43.114+00
398	https://twitter.com/nicole_novilla/status/264515922042159104#1	https://twitter.com/nicole_novilla/status/264515922042159104	i totally forgot this goes through the other acct	{arg1 [head=I] [addr=3] I} {rel2 [head=forgot] [addr=5] [nsubj>arg1;nmod>arg4;ccomp>rel3;] totally forgot} {rel3 [head=goes] [addr=7] goes} {arg4 [head=acct] [addr=11] other acct}	2017-12-18 10:27:43.116+00
399	https://twitter.com/nicole_novilla/status/264515922042159104#2	https://twitter.com/nicole_novilla/status/264515922042159104	sorry i might be rioting your timeline	{rel1 [head=be] [addr=5] be} {arg2 [head=rioting] [addr=6] [dep>arg3;cop>rel1;nsubj>arg4;] rioting} {arg3 [head=timeline] [addr=8] timeline} {arg4 [head=Sorry] [addr=1] Sorry}	2017-12-18 10:27:43.117+00
400	https://twitter.com/Ikky_A/status/264516034743128064#1	https://twitter.com/Ikky_A/status/264516034743128064	moment when u realize that in the movie 2012 the first thing that closed was new york & amp now it 's	{rel1 [head=closed] [addr=18] closed} {arg3 [head=York] [addr=21] [nsubj>acl:relcl>rel1;] New York} {arg6 [head=movie] [addr=12] movie 2012} {arg11 [head=it] [addr=26] it 's}	2017-12-18 10:27:43.119+00
401	https://twitter.com/Ikky_A/status/264516034743128064#2	https://twitter.com/Ikky_A/status/264516034743128064	the awkward moment when u realize that in the movie 2012 the first thing that closed was new york & amp now	{arg1 [head=movie] [addr=12] movie 2012} {rel5 [head=realize] [addr=8] [dobj>nmod>arg1;nsubj>arg6;] when realize} {arg6 [head=u] [addr=7] u} {arg7 [head=moment] [addr=5] [dep>arg8;acl:relcl>rel5;] awkward moment} {arg8 [head=now] [addr=25] now}	2017-12-18 10:27:43.121+00
402	https://twitter.com/PartyCatOlivia/status/264515537520975873#1	https://twitter.com/PartyCatOlivia/status/264515537520975873	where i live	{arg1 [head=I] [addr=4] I} {rel2 [head=live] [addr=5] [nsubj>arg1;] where live}	2017-12-18 10:27:43.123+00
403	https://twitter.com/PartyCatOlivia/status/264515537520975873#2	https://twitter.com/PartyCatOlivia/status/264515537520975873	basement closed where i live and there	{arg1 [head=I] [addr=4] I} {rel3 [head=closed] [addr=2] [advcl>nsubj>arg1;] closed} {arg4 [head=Basement] [addr=1] [acl>rel3;] Basement}	2017-12-18 10:27:43.125+00
404	https://twitter.com/PartyCatOlivia/status/264515537520975873#3	https://twitter.com/PartyCatOlivia/status/264515537520975873	basement closed where i live and there 's still no power	{arg1 [head=I] [addr=4] I} {rel2 [head=live] [addr=5] [nsubj>arg1;] where live} {arg8 [head=power] [addr=11] [neg] still power}	2017-12-18 10:27:43.127+00
405	https://twitter.com/AshleyLaDiva/status/264515807105654784#1	https://twitter.com/AshleyLaDiva/status/264515807105654784	i 1 2 b like u my num1molomolosweetheart social unrest performer * fr spain cameroon uk 9ja owerri abuja do	{arg1 [head=I] [addr=2] [dep>rel2;] I} {rel2 [head=do] [addr=21] do}	2017-12-18 10:27:43.128+00
406	https://twitter.com/AshleyLaDiva/status/264515807105654784#2	https://twitter.com/AshleyLaDiva/status/264515807105654784	i 1 2 b like u my num1molomolosweetheart social unrest performer * fr spain cameroon uk 9ja owerri abuja do u no my best1	{arg1 [head=num1MoloMolosweetheart] [addr=9] num1MoloMolosweetheart} {arg5 [head=Abuja] [addr=20] Spain cameroon uk 9ja owerri Abuja} {rel7 [head=do] [addr=21] [nmod>arg8;] do} {arg8 [head=best1] [addr=25] [dep>arg9;] best1} {arg9 [head=u] [addr=22] u}	2017-12-18 10:27:43.13+00
407	https://twitter.com/AshleyLaDiva/status/264515807105654784#3	https://twitter.com/AshleyLaDiva/status/264515807105654784	i 1 2 b like u my num1molomolosweetheart social unrest performer * fr spain cameroon uk 9ja owerri abuja do u no my best1 ☺☺ maidugri	{arg1 [head=Abuja] [addr=20] Spain cameroon uk 9ja owerri Abuja} {arg4 [head=☺☺] [addr=27] ☺☺ Maidugri} {rel5 [head=do] [addr=21] [nmod>arg6;] do} {arg6 [head=best1] [addr=25] [dep>arg7;] best1} {arg7 [head=u] [addr=22] u}	2017-12-18 10:27:43.132+00
408	https://twitter.com/CarolynNewsom/status/264515598447427585#1	https://twitter.com/CarolynNewsom/status/264515598447427585	video why even a little rain could cause rioting	{arg1 [head=VIDEO] [addr=3] [acl:relcl>rel2;] VIDEO} {rel2 [head=cause] [addr=11] [nsubj>arg6;dobj>arg3;] Why even cause} {arg3 [head=rioting] [addr=12] rioting} {arg6 [head=rain] [addr=9] little rain}	2017-12-18 10:27:43.133+00
409	https://twitter.com/TeamMikeMorris/status/264515973397245954#1	https://twitter.com/TeamMikeMorris/status/264515973397245954	rt @epagov are you dealing	{arg1 [head=RT @EPAgov] [addr=1] [dep>rel2;] RT @EPAgov} {rel2 [head=dealing] [addr=5] dealing}	2017-12-18 10:27:43.136+00
410	https://twitter.com/TeamMikeMorris/status/264515973397245954#2	https://twitter.com/TeamMikeMorris/status/264515973397245954	are you dealing with rioting as a result of virus	{arg1 [head=you] [addr=4] you} {rel2 [head=dealing] [addr=5] [nmod>arg3;nmod>arg5;nsubj>arg1;] dealing} {arg3 [head=rioting] [addr=7] rioting} {arg5 [head=result] [addr=10] [nmod>arg7;] result} {arg7 [head=virus] [addr=12] virus}	2017-12-18 10:27:43.137+00
411	https://twitter.com/smiddy9/status/264515854279004160#1	https://twitter.com/smiddy9/status/264515854279004160	get up	{arg1 [head=up] [addr=4] up} {rel2 [head=get] [addr=3] [dep>arg1;] get}	2017-12-18 10:27:43.139+00
412	https://twitter.com/smiddy9/status/264515854279004160#2	https://twitter.com/smiddy9/status/264515854279004160	c'mon #knicknation get	{arg1 [head=c'mon] [addr=1] [ccomp>rel2;] c'mon} {rel2 [head=get] [addr=3] get}	2017-12-18 10:27:43.141+00
413	https://twitter.com/smiddy9/status/264515854279004160#3	https://twitter.com/smiddy9/status/264515854279004160	lets knock off the heat #beattheheat	{arg1 [head=#beattheheat] [addr=6] #beattheheat} {rel2 [head=lets] [addr=1] [nsubj>arg1;] lets}	2017-12-18 10:27:43.143+00
414	https://twitter.com/DearAbdullah/status/264516105505222656#1	https://twitter.com/DearAbdullah/status/264516105505222656	salaam alaikum let 's give a final push at http://t.co/4jqzttt1. let 's have	{arg1 [head=Salaam] [addr=5] [acl:relcl>rel2;] Salaam} {rel2 [head=Let] [addr=16] [ccomp>arg3;] Let} {arg3 [head=have] [addr=18] have}	2017-12-18 10:27:43.145+00
415	https://twitter.com/DearAbdullah/status/264516105505222656#2	https://twitter.com/DearAbdullah/status/264516105505222656	let 's give a final push at http://t.co/4jqzttt1. let 's have a spiritual social unrest	{arg1 [head=push] [addr=13] final push} {rel3 [head=Let] [addr=8] [ccomp>dobj>arg1;] Let} {rel5 [head=have] [addr=18] [dobj>arg6;] have} {arg6 [head=unrest] [addr=22] spiritual social unrest}	2017-12-18 10:27:43.147+00
416	https://twitter.com/amazinmind/status/264516002061099008#1	https://twitter.com/amazinmind/status/264516002061099008	those lines closed	{arg1 [head=lines] [addr=3] lines} {rel2 [head=closed] [addr=4] [nsubj>arg1;] closed}	2017-12-18 10:27:43.148+00
417	https://twitter.com/amazinmind/status/264516002061099008#2	https://twitter.com/amazinmind/status/264516002061099008	we need you florida	{arg1 [head=WE] [addr=1] WE} {rel2 [head=need] [addr=2] [xcomp>arg3;nsubj>arg1;] need} {arg3 [head=FLORIDA] [addr=4] FLORIDA}	2017-12-18 10:27:43.15+00
419	https://twitter.com/MannyCamacho_/status/264515728688943104#1	https://twitter.com/MannyCamacho_/status/264515728688943104	@jeesssiiccaa x3 lol hw im telling my teacher my house got closed	{arg1 [head=@Jeesssiiccaa x3] [addr=1] @Jeesssiiccaa x3} {rel2 [head=closed] [addr=11] [dep>arg1;] closed}	2017-12-18 10:27:43.153+00
420	https://twitter.com/ThePriss/status/264516025352077312#1	https://twitter.com/ThePriss/status/264516025352077312	was some rioting and power lines knocked down	{rel1 [head=knocked] [addr=8] knocked down} {arg2 [head=lines] [addr=7] [acl>rel1;] rioting lines} {arg3 [head=was] [addr=2] [nsubj>arg2;] was}	2017-12-18 10:27:43.154+00
421	https://twitter.com/cucumberjuice/status/264515855847682048#1	https://twitter.com/cucumberjuice/status/264515855847682048	can ’ t know	{arg1 [head=can] [addr=4] [dep>rel2;] can} {rel2 [head=know] [addr=7] know}	2017-12-18 10:27:43.156+00
422	https://twitter.com/AUNlessthan3/status/264516048701759488#1	https://twitter.com/AUNlessthan3/status/264516048701759488	rt @rumblevines no but klaine broke up in battery park	{arg1 [head=RT @rumblevines] [addr=1] RT @rumblevines} {rel2 [head=broke] [addr=6] [nmod>arg3;nsubj>arg1;] but broke} {arg3 [head=park] [addr=10] battery park}	2017-12-18 10:27:43.158+00
423	https://twitter.com/AUNlessthan3/status/264516048701759488#2	https://twitter.com/AUNlessthan3/status/264516048701759488	but klaine broke up in battery park and then 3 weeks later it was closed with fangirl tears	{rel1 [head=was] [addr=17] was} {rel2 [head=closed] [addr=18] [auxpass>rel1;nsubjpass>arg5;nmod:tmod>arg6;nmod>arg7;] then closed} {arg5 [head=it] [addr=16] it} {arg6 [head=weeks] [addr=14] 3 weeks later} {arg7 [head=tears] [addr=22] fangirl tears}	2017-12-18 10:27:43.159+00
424	https://twitter.com/LisaDorrough/status/264515939532410880#1	https://twitter.com/LisaDorrough/status/264515939532410880	'in 2012 new york closed and its closed	{rel1 [head=closed] [addr=8] closed} {arg3 [head=York] [addr=4] [acl>parataxis>rel1;] 'In 2012 New York}	2017-12-18 10:27:43.161+00
425	https://twitter.com/LisaDorrough/status/264515939532410880#2	https://twitter.com/LisaDorrough/status/264515939532410880	i do n't remember	{rel1 [head=do] [addr=2] do} {arg3 [head=I] [addr=1] I}	2017-12-18 10:27:43.163+00
426	https://twitter.com/LisaDorrough/status/264515939532410880#3	https://twitter.com/LisaDorrough/status/264515939532410880	i do n't remember that	{rel1 [head=do] [addr=2] do} {rel2 [head=remember] [addr=4] [neg] [aux>rel1;nsubj>arg5;dobj>arg3;] remember} {arg3 [head=that] [addr=5] that} {arg5 [head=I] [addr=1] I}	2017-12-18 10:27:43.165+00
427	https://twitter.com/LisaDorrough/status/264515939532410880#4	https://twitter.com/LisaDorrough/status/264515939532410880	a virus did hit new york in the day	{arg1 [head=virus] [addr=3] virus} {rel2 [head=did] [addr=4] [xcomp>arg3;nsubj>arg1;] did} {arg3 [head=hit] [addr=5] [dep>arg4;dep>arg5;] hit} {arg4 [head=York] [addr=7] New York} {arg5 [head=Day] [addr=10] Day}	2017-12-18 10:27:43.167+00
428	https://twitter.com/jessiellen13/status/264515990157660160#1	https://twitter.com/jessiellen13/status/264515990157660160	the first thing that happens in the movie 2012 is new york gets closed	{arg1 [head=thing] [addr=3] first thing} {rel3 [head=closed] [addr=14] closed}	2017-12-18 10:27:43.169+00
429	https://twitter.com/mathew_petersen/status/264515845533876224#1	https://twitter.com/mathew_petersen/status/264515845533876224	rt @epagov are you dealing	{arg1 [head=RT @EPAgov] [addr=1] [dep>rel2;] RT @EPAgov} {rel2 [head=dealing] [addr=5] dealing}	2017-12-18 10:27:43.17+00
430	https://twitter.com/mathew_petersen/status/264515845533876224#2	https://twitter.com/mathew_petersen/status/264515845533876224	are you dealing with rioting as a result of virus	{arg1 [head=you] [addr=4] you} {rel2 [head=dealing] [addr=5] [nmod>arg3;nmod>arg5;nsubj>arg1;] dealing} {arg3 [head=rioting] [addr=7] rioting} {arg5 [head=result] [addr=10] [nmod>arg7;] result} {arg7 [head=virus] [addr=12] virus}	2017-12-18 10:27:43.172+00
431	https://twitter.com/KineticoHQ/status/264515727980126209#1	https://twitter.com/KineticoHQ/status/264515727980126209	rt @epagov are you dealing	{arg1 [head=RT @EPAgov] [addr=1] [dep>rel2;] RT @EPAgov} {rel2 [head=dealing] [addr=5] dealing}	2017-12-18 10:27:43.173+00
432	https://twitter.com/KineticoHQ/status/264515727980126209#2	https://twitter.com/KineticoHQ/status/264515727980126209	are you dealing with rioting as a result of virus	{arg1 [head=you] [addr=4] you} {rel2 [head=dealing] [addr=5] [nmod>arg3;nmod>arg5;nsubj>arg1;] dealing} {arg3 [head=rioting] [addr=7] rioting} {arg5 [head=result] [addr=10] [nmod>arg7;] result} {arg7 [head=virus] [addr=12] virus}	2017-12-18 10:27:43.175+00
433	https://twitter.com/SJW_sarahjane/status/264515684699095040#1	https://twitter.com/SJW_sarahjane/status/264515684699095040	new york being closed	{rel1 [head=being] [addr=13] being} {rel2 [head=closed] [addr=14] [auxpass>rel1;] closed} {arg3 [head=York] [addr=12] [acl>rel2;] New York}	2017-12-18 10:27:43.176+00
434	https://twitter.com/SJW_sarahjane/status/264515684699095040#2	https://twitter.com/SJW_sarahjane/status/264515684699095040	it 's 2012 & amp new york 's streets are closed	{rel1 [head=are] [addr=11] are} {rel2 [head=closed] [addr=12] [auxpass>rel1;nsubjpass>arg3;] closed} {arg3 [head=It] [addr=1] It 's}	2017-12-18 10:27:43.178+00
435	https://twitter.com/ZachtoEarth/status/264516094906204160#1	https://twitter.com/ZachtoEarth/status/264516094906204160	@epagov are you dealing w	{arg1 [head=@EPAgov] [addr=1] [dep>rel2;] @EPAgov} {rel2 [head=dealing] [addr=5] [dobj>arg3;] dealing} {arg3 [head=w] [addr=6] w}	2017-12-18 10:27:43.179+00
436	https://twitter.com/ZachtoEarth/status/264516094906204160#2	https://twitter.com/ZachtoEarth/status/264516094906204160	are you dealing w rioting as a result of virus	{arg1 [head=you] [addr=4] you} {rel2 [head=dealing] [addr=5] [nsubj>arg1;dobj>arg3;] dealing} {arg3 [head=w] [addr=6] [dep>arg5;] w} {arg5 [head=rioting] [addr=8] [nmod>arg6;] rioting} {arg6 [head=result] [addr=11] [nmod>arg8;] result} {arg8 [head=virus] [addr=13] virus}	2017-12-18 10:27:43.18+00
437	https://twitter.com/YourTrue_Desire/status/264516131295997953#1	https://twitter.com/YourTrue_Desire/status/264516131295997953	this when shakur start rioting	{arg1 [head=This] [addr=3] [acl:relcl>rel2;] This} {rel2 [head=start] [addr=6] [dobj>arg3;] when start} {arg3 [head=rioting] [addr=7] rioting}	2017-12-18 10:27:43.182+00
438	https://twitter.com/ivonst/status/264515596337676292#1	https://twitter.com/ivonst/status/264515596337676292	@ijowb sadly nyc got closed	{arg1 [head=@iJowb] [addr=1] @iJowb} {rel2 [head=closed] [addr=6] [dep>arg1;] Sadly closed}	2017-12-18 10:27:43.183+00
439	https://twitter.com/SouthHarlemCERT/status/264515689161842688#1	https://twitter.com/SouthHarlemCERT/status/264515689161842688	when angry crowds recede dry things out w in 2 3 days	{arg1 [head=crowds] [addr=5] angry crowds} {rel2 [head=recede] [addr=6] [nsubj>arg1;] When recede} {arg3 [head=things] [addr=9] [dep>rel2;nmod>arg4;] dry things} {arg4 [head=w] [addr=11] [dep>arg6;] w} {arg6 [head=days] [addr=17] 3 days}	2017-12-18 10:27:43.184+00
440	https://twitter.com/SouthHarlemCERT/status/264515689161842688#2	https://twitter.com/SouthHarlemCERT/status/264515689161842688	items are likely to grow mold	{arg1 [head=items] [addr=4] items} {rel2 [head=likely] [addr=6] [xcomp>rel3;nsubj>arg1;] are likely} {rel3 [head=grow] [addr=8] [dobj>arg4;] grow} {arg4 [head=mold] [addr=9] mold}	2017-12-18 10:27:43.186+00
441	https://twitter.com/Praise1300/status/264515591325507584#1	https://twitter.com/Praise1300/status/264515591325507584	east coast closed wet and dark	{rel1 [head=closed] [addr=6] closed} {arg2 [head=Coast] [addr=5] [acl>rel1;dobj>arg3;] East Coast} {arg3 [head=Wet] [addr=8] Wet}	2017-12-18 10:27:43.187+00
442	https://twitter.com/gasdotcom/status/264515824365236224#1	https://twitter.com/gasdotcom/status/264515824365236224	drivers desperate for gas hungry weary new yorkers with closed homes and no power	{rel1 [head=closed] [addr=16] closed} {arg2 [head=homes] [addr=17] [amod>rel1;] homes} {arg4 [head=Yorkers] [addr=14] [nmod>arg2;] weary New Yorkers} {arg8 [head=Drivers] [addr=5] [conj>appos>arg4;amod>nmod>arg9;] Drivers Desperate} {arg9 [head=Gas] [addr=8] Gas}	2017-12-18 10:27:43.188+00
443	https://twitter.com/gasdotcom/status/264515824365236224#2	https://twitter.com/gasdotcom/status/264515824365236224	victims seek supplies drivers desperate for gas hungry weary new yorkers with closed homes and no power	{arg1 [head=Yorkers] [addr=14] weary New Yorkers} {arg5 [head=Drivers] [addr=5] [conj>appos>arg1;amod>nmod>arg6;] Drivers Desperate} {arg6 [head=Gas] [addr=8] Gas} {arg8 [head=Supplies] [addr=3] [appos>arg5;] Supplies} {rel9 [head=Seek] [addr=2] [dobj>arg8;] Seek} {arg10 [head=Victims] [addr=1] [dep>rel9;] Victims}	2017-12-18 10:27:43.19+00
444	https://twitter.com/gasdotcom/status/264515824365236224#3	https://twitter.com/gasdotcom/status/264515824365236224	drivers desperate for gas hungry weary new yorkers with closed homes and no power	{rel1 [head=closed] [addr=16] closed} {arg2 [head=homes] [addr=17] [amod>rel1;] homes} {arg4 [head=Yorkers] [addr=14] [nmod>arg2;] weary New Yorkers} {arg8 [head=Drivers] [addr=5] [conj>appos>arg4;conj>arg9;amod>nmod>arg10;] Drivers Desperate} {arg9 [head=power] [addr=20] [neg] power} {arg10 [head=Gas] [addr=8] Gas}	2017-12-18 10:27:43.191+00
445	https://twitter.com/dratiffarid/status/264515772620079105#1	https://twitter.com/dratiffarid/status/264515772620079105	power did n't go	{rel1 [head=did] [addr=9] did} {arg3 [head=power] [addr=8] power}	2017-12-18 10:27:43.193+00
446	https://twitter.com/dratiffarid/status/264515772620079105#2	https://twitter.com/dratiffarid/status/264515772620079105	did n't riot in my area power did n't go	{rel1 [head=did] [addr=9] did} {rel2 [head=go] [addr=11] [neg] [aux>rel1;nsubj>arg3;] go} {arg3 [head=power] [addr=8] power}	2017-12-18 10:27:43.194+00
447	https://twitter.com/dratiffarid/status/264515772620079105#3	https://twitter.com/dratiffarid/status/264515772620079105	did n't riot	{rel1 [head=Did] [addr=1] Did} {arg2 [head=riot] [addr=3] [neg] [aux>rel1;] riot}	2017-12-18 10:27:43.195+00
448	https://twitter.com/dratiffarid/status/264515772620079105#4	https://twitter.com/dratiffarid/status/264515772620079105	i 'm really thankful	{rel1 [head='m] [addr=2] 'm} {arg2 [head=thankful] [addr=4] [cop>rel1;nsubj>arg3;] really thankful} {arg3 [head=I] [addr=1] I}	2017-12-18 10:27:43.197+00
449	https://twitter.com/alrightjosh/status/264515932796354563#1	https://twitter.com/alrightjosh/status/264515932796354563	baby the swaggy mcswag follows u so dat shud b a compliment enit u get me bitches	{arg1 [head=baby] [addr=3] [acl:relcl>rel2;] baby} {rel2 [head=get] [addr=17] [ccomp>arg3;] get} {arg3 [head=bitches] [addr=19] bitches}	2017-12-18 10:27:43.198+00
450	https://twitter.com/meatypoppy/status/264515724297502721#1	https://twitter.com/meatypoppy/status/264515724297502721	wassup is it closed	{arg1 [head=wassup] [addr=4] [acl>rel2;] wassup} {rel2 [head=closed] [addr=7] closed}	2017-12-18 10:27:43.199+00
451	https://twitter.com/meatypoppy/status/264515724297502721#2	https://twitter.com/meatypoppy/status/264515724297502721	wassup is it closed in harlem	{arg1 [head=it] [addr=6] it} {rel3 [head=closed] [addr=7] [nmod>arg4;] closed} {arg4 [head=Harlem] [addr=9] Harlem}	2017-12-18 10:27:43.201+00
452	https://twitter.com/amirakamal1/status/264515931517100032#1	https://twitter.com/amirakamal1/status/264515931517100032	in the movie 2012 new york city closed and now it 's 2012 and new york city is rioting واخد بالك	{rel1 [head=is] [addr=21] is} {arg2 [head=rioting] [addr=22] [cop>rel1;nmod>arg3;nsubj>arg5;] rioting واخد بالك} {arg3 [head=movie] [addr=5] movie 2012} {arg5 [head=City] [addr=10] New York City now 's New}	2017-12-18 10:27:43.203+00
453	https://twitter.com/OcbaShinome/status/264515897979453440#1	https://twitter.com/OcbaShinome/status/264515897979453440	i feel for the ppl in new york not only	{arg1 [head=I] [addr=1] [dep>rel2;] I} {rel2 [head=feel] [addr=2] [dobj>arg3;] feel} {arg3 [head=only] [addr=11] [neg] only}	2017-12-18 10:27:43.205+00
454	https://twitter.com/OcbaShinome/status/264515897979453440#2	https://twitter.com/OcbaShinome/status/264515897979453440	not only is it rioting	{rel1 [head=is] [addr=12] is} {arg2 [head=rioting] [addr=14] [cop>rel1;] rioting} {arg3 [head=only] [addr=11] [neg] [acl:relcl>arg2;] only}	2017-12-18 10:27:43.207+00
455	https://twitter.com/OcbaShinome/status/264515897979453440#3	https://twitter.com/OcbaShinome/status/264515897979453440	i feel for the ppl in new york not only is it rioting but its going to be cold	{rel1 [head=be] [addr=19] be} {arg5 [head=rioting] [addr=14] rioting} {arg6 [head=I] [addr=1] [dep>advcl>cop>rel1;dep>dobj>acl:relcl>arg5;] I}	2017-12-18 10:27:43.209+00
456	https://twitter.com/OcbaShinome/status/264515897979453440#4	https://twitter.com/OcbaShinome/status/264515897979453440	feel for the ppl in new york not only is it rioting but its going to be cold without electricity	{rel1 [head=be] [addr=19] be} {arg2 [head=cold] [addr=20] [cop>rel1;nmod>arg3;] cold} {arg3 [head=electricity] [addr=22] electricity} {arg7 [head=rioting] [addr=14] rioting}	2017-12-18 10:27:43.21+00
457	https://twitter.com/DaMekaRenee/status/264515956989100032#1	https://twitter.com/DaMekaRenee/status/264515956989100032	moment when u realize that in the movie 2012 the first thing that closed was new york & amp now it 's	{rel1 [head=closed] [addr=18] closed} {arg3 [head=York] [addr=21] [nsubj>acl:relcl>rel1;] New York} {arg6 [head=movie] [addr=12] movie 2012} {arg11 [head=it] [addr=26] it 's}	2017-12-18 10:27:43.212+00
458	https://twitter.com/DaMekaRenee/status/264515956989100032#2	https://twitter.com/DaMekaRenee/status/264515956989100032	the awkward moment when u realize that in the movie 2012 the first thing that closed was new york & amp now	{arg1 [head=movie] [addr=12] movie 2012} {rel5 [head=realize] [addr=8] [dobj>nmod>arg1;nsubj>arg6;] when realize} {arg6 [head=u] [addr=7] u} {arg7 [head=moment] [addr=5] [dep>arg8;acl:relcl>rel5;] awkward moment} {arg8 [head=now] [addr=25] now}	2017-12-18 10:27:43.214+00
459	https://twitter.com/swon26/status/264515733076209664#1	https://twitter.com/swon26/status/264515733076209664	@chucktodd @howardfineman @markhalperin @davidgregory y do n't u mentioned f	{arg1 [head=U] [addr=10] [acl>rel4;] U} {rel4 [head=mentioned] [addr=11] [dobj>arg5;] mentioned} {arg5 [head=F] [addr=12] F}	2017-12-18 10:27:43.215+00
460	https://twitter.com/swon26/status/264515733076209664#2	https://twitter.com/swon26/status/264515733076209664	@chucktodd @howardfineman @markhalperin @davidgregory y do n't u	{arg1 [head=@howardfineman] [addr=4] @howardfineman} {rel2 [head=do] [addr=8] [neg] [dep>arg1;dobj>arg3;] do} {arg3 [head=U] [addr=10] U}	2017-12-18 10:27:43.217+00
461	https://twitter.com/swon26/status/264515733076209664#3	https://twitter.com/swon26/status/264515733076209664	reserve closed the maket $ $ 2 help o	{arg1 [head=Reserve] [addr=1] [acl>rel2;] Reserve} {rel2 [head=closed] [addr=2] [xcomp>arg3;] closed} {arg3 [head=O] [addr=9] [compound>arg4;] $ help O} {arg4 [head=maket] [addr=4] maket}	2017-12-18 10:27:43.218+00
462	https://twitter.com/EmilyAutopsyy/status/264516100115533824#1	https://twitter.com/EmilyAutopsyy/status/264516100115533824	moment when u realize that in the movie 2012 the first thing that closed was new york & amp now it 's	{rel1 [head=closed] [addr=18] closed} {arg3 [head=York] [addr=21] [nsubj>acl:relcl>rel1;] New York} {arg6 [head=movie] [addr=12] movie 2012} {arg11 [head=it] [addr=26] it 's}	2017-12-18 10:27:43.219+00
463	https://twitter.com/EmilyAutopsyy/status/264516100115533824#2	https://twitter.com/EmilyAutopsyy/status/264516100115533824	the awkward moment when u realize that in the movie 2012 the first thing that closed was new york & amp now	{arg1 [head=movie] [addr=12] movie 2012} {rel5 [head=realize] [addr=8] [dobj>nmod>arg1;nsubj>arg6;] when realize} {arg6 [head=u] [addr=7] u} {arg7 [head=moment] [addr=5] [dep>arg8;acl:relcl>rel5;] awkward moment} {arg8 [head=now] [addr=25] now}	2017-12-18 10:27:43.221+00
464	https://twitter.com/SaffronKeohane/status/264515651962564608#1	https://twitter.com/SaffronKeohane/status/264515651962564608	the world ended	{arg1 [head=world] [addr=16] [acl>rel2;] world} {rel2 [head=ended] [addr=17] ended}	2017-12-18 10:27:43.222+00
465	https://twitter.com/SaffronKeohane/status/264515651962564608#2	https://twitter.com/SaffronKeohane/status/264515651962564608	rt @hadenclark in the film 2012 new york closed in october then the world	{arg1 [head=world] [addr=16] world} {arg2 [head=October] [addr=12] [dep>arg1;] October then} {rel5 [head=closed] [addr=10] [nmod>arg2;] closed} {arg6 [head=York] [addr=9] [acl>rel5;] New York} {arg9 [head=film] [addr=5] film}	2017-12-18 10:27:43.223+00
466	https://twitter.com/SaffronKeohane/status/264515651962564608#3	https://twitter.com/SaffronKeohane/status/264515651962564608	october it 's 2012 and new york is closed	{arg1 [head=York] [addr=10] New York} {arg5 [head=October] [addr=3] [appos>dep>conj>arg1;] October it 's} {rel6 [head=closed] [addr=12] [nsubjpass>arg5;] closed}	2017-12-18 10:27:43.225+00
467	https://twitter.com/Nytowl68/status/264515679594627072#1	https://twitter.com/Nytowl68/status/264515679594627072	marathoners running past riot damaged homes	{arg1 [head=Marathoners] [addr=1] [acl>rel2;] Marathoners} {rel2 [head=running] [addr=2] running past riot damaged}	2017-12-18 10:27:43.227+00
468	https://twitter.com/Nytowl68/status/264515679594627072#2	https://twitter.com/Nytowl68/status/264515679594627072	past riot damaged homes	{arg1 [head=homes] [addr=6] [amod>rel2;] past riot homes} {rel2 [head=damaged] [addr=5] damaged}	2017-12-18 10:27:43.229+00
469	https://twitter.com/Nytowl68/status/264515679594627072#3	https://twitter.com/Nytowl68/status/264515679594627072	marathoners running past riot damaged homes with mounds of saturated sofas mattresses and carpeting	{arg1 [head=mounds] [addr=8] mounds} {arg3 [head=homes] [addr=6] [nmod>arg1;] past riot damaged homes} {arg6 [head=sofas] [addr=11] [conj>arg10;conj>arg11;] saturated sofas} {arg10 [head=mattresses] [addr=13] mattresses} {arg11 [head=carpeting] [addr=16] carpeting}	2017-12-18 10:27:43.231+00
470	https://twitter.com/JAII_SAANNNNNN/status/264515999435485185#1	https://twitter.com/JAII_SAANNNNNN/status/264515999435485185	moment when u realize that in the movie 2012 the first thing that closed was new york & amp now it 's	{rel1 [head=closed] [addr=18] closed} {arg3 [head=York] [addr=21] [nsubj>acl:relcl>rel1;] New York} {arg6 [head=movie] [addr=12] movie 2012} {arg11 [head=it] [addr=26] it 's}	2017-12-18 10:27:43.233+00
471	https://twitter.com/JAII_SAANNNNNN/status/264515999435485185#2	https://twitter.com/JAII_SAANNNNNN/status/264515999435485185	the awkward moment when u realize that in the movie 2012 the first thing that closed was new york & amp now	{arg1 [head=movie] [addr=12] movie 2012} {rel5 [head=realize] [addr=8] [dobj>nmod>arg1;nsubj>arg6;] when realize} {arg6 [head=u] [addr=7] u} {arg7 [head=moment] [addr=5] [dep>arg8;acl:relcl>rel5;] awkward moment} {arg8 [head=now] [addr=25] now}	2017-12-18 10:27:43.234+00
472	https://twitter.com/iCaramelKush_/status/264516071648817153#1	https://twitter.com/iCaramelKush_/status/264516071648817153	in the movie 2012 nyc was the first city	{rel1 [head=was] [addr=6] was} {arg2 [head=city] [addr=9] [cop>rel1;nmod>arg4;nsubj>arg3;] first city} {arg3 [head=NYC] [addr=5] NYC} {arg4 [head=movie] [addr=3] movie 2012}	2017-12-18 10:27:43.236+00
473	https://twitter.com/iCaramelKush_/status/264516071648817153#2	https://twitter.com/iCaramelKush_/status/264516071648817153	nyc was the first city to get closed	{rel1 [head=was] [addr=6] was} {arg3 [head=NYC] [addr=5] NYC} {rel5 [head=closed] [addr=12] closed}	2017-12-18 10:27:43.238+00
474	https://twitter.com/iCaramelKush_/status/264516071648817153#3	https://twitter.com/iCaramelKush_/status/264516071648817153	nyc was just recently closed	{rel1 [head=was] [addr=3] was} {rel2 [head=closed] [addr=6] [auxpass>rel1;nsubjpass>arg3;] just recently closed} {arg3 [head=NYC] [addr=2] NYC}	2017-12-18 10:27:43.239+00
475	https://twitter.com/peterbio/status/264515817968910337#1	https://twitter.com/peterbio/status/264515817968910337	thousands of lab mice drowned as the outbreak storm surge	{arg1 [head=Thousands] [addr=3] [nmod>arg2;] Thousands} {arg2 [head=mice] [addr=6] [acl>rel4;] lab mice} {rel4 [head=drowned] [addr=7] [nmod>arg5;] drowned} {arg5 [head=surge] [addr=12] outbreak storm surge}	2017-12-18 10:27:43.241+00
476	https://twitter.com/peterbio/status/264515817968910337#2	https://twitter.com/peterbio/status/264515817968910337	as the outbreak storm surge closed into an nyu lab in manhattan	{arg1 [head=surge] [addr=12] [acl>rel3;] outbreak storm surge} {rel3 [head=closed] [addr=13] [nmod>arg4;nmod>arg6;] closed} {arg4 [head=lab] [addr=17] NYU lab} {arg6 [head=Manhattan] [addr=19] Manhattan}	2017-12-18 10:27:43.243+00
477	https://twitter.com/sawarghhh/status/264515614419320832#1	https://twitter.com/sawarghhh/status/264515614419320832	when u see something that reminds u of someone & amp suddenly memories of them just riot through ur mind & amp	{arg1 [head=u] [addr=4] u} {arg3 [head=something] [addr=6] something} {rel5 [head=reminds] [addr=8] [advcl>dobj>arg3;dobj>conj>dep>conj>arg12;dobj>nmod>arg7;advcl>nsubj>arg1;] reminds} {arg7 [head=someone] [addr=11] someone} {arg12 [head=amp] [addr=25] amp}	2017-12-18 10:27:43.244+00
478	https://twitter.com/azarianblade/status/264516064593985536#1	https://twitter.com/azarianblade/status/264516064593985536	instead going out there to help the closed victims hes	{arg1 [head=hes] [addr=12] hes} {arg5 [head=help] [addr=7] help} {arg7 [head=victims] [addr=10] [amod>rel9;] victims} {rel9 [head=closed] [addr=9] closed}	2017-12-18 10:27:43.245+00
479	https://twitter.com/azarianblade/status/264516064593985536#2	https://twitter.com/azarianblade/status/264516064593985536	instead going out there to help the closed victims hes over there talking junk	{arg1 [head=junk] [addr=16] junk} {rel2 [head=talking] [addr=15] [dobj>arg1;] talking} {arg3 [head=hes] [addr=12] [dep>rel2;] hes} {arg5 [head=victims] [addr=10] closed victims}	2017-12-18 10:27:43.247+00
480	https://twitter.com/azarianblade/status/264516064593985536#3	https://twitter.com/azarianblade/status/264516064593985536	kind of leader is this smh	{rel1 [head=is] [addr=5] is} {arg3 [head=leader] [addr=4] [acl:relcl>cop>rel1;] leader} {arg4 [head=kind] [addr=2] [dep>arg5;acl>arg3;] kind} {arg5 [head=smh] [addr=8] smh}	2017-12-18 10:27:43.248+00
501	https://twitter.com/__KissMyKush/status/264515914400165889#2	https://twitter.com/__KissMyKush/status/264515914400165889	again lol thought it was closed	{rel1 [head=was] [addr=11] was} {rel2 [head=closed] [addr=12] [auxpass>rel1;] closed} {arg3 [head=thought] [addr=9] [acl:relcl>rel2;] again lol thought}	2017-12-18 10:27:43.286+00
481	https://twitter.com/TwistKhalilFan/status/264515798322794496#1	https://twitter.com/TwistKhalilFan/status/264515798322794496	@paigestopher nah brooklyn never closed except the brooklyn bridge but manhattan parts of queens and long island got closed badly	{arg1 [head=@Paigestopher] [addr=1] @Paigestopher} {rel2 [head=closed] [addr=22] [dep>arg1;] closed badly}	2017-12-18 10:27:43.25+00
482	https://twitter.com/TwistKhalilFan/status/264515798322794496#2	https://twitter.com/TwistKhalilFan/status/264515798322794496	brooklyn never closed except the brooklyn bridge but manhattan parts	{arg1 [head=parts] [addr=14] parts} {arg2 [head=brooklyn] [addr=4] [appos>arg1;acl>rel3;] brooklyn} {rel3 [head=closed] [addr=6] [neg] closed}	2017-12-18 10:27:43.251+00
483	https://twitter.com/TwistKhalilFan/status/264515798322794496#3	https://twitter.com/TwistKhalilFan/status/264515798322794496	nah brooklyn never closed except the brooklyn bridge but manhattan parts	{arg1 [head=brooklyn] [addr=9] brooklyn} {arg2 [head=bridge] [addr=10] [conj>arg5;compound>arg1;] bridge} {arg5 [head=Manhattan] [addr=12] Manhattan} {rel6 [head=closed] [addr=6] [neg] [nmod>arg2;] closed} {arg8 [head=nah] [addr=2] [appos>acl>rel6;] nah brooklyn parts}	2017-12-18 10:27:43.253+00
484	https://twitter.com/TwistKhalilFan/status/264515798322794496#4	https://twitter.com/TwistKhalilFan/status/264515798322794496	brooklyn never closed except the brooklyn bridge but manhattan parts of queens and long island got	{arg1 [head=got] [addr=21] Queens got} {rel5 [head=closed] [addr=6] [neg] closed}	2017-12-18 10:27:43.255+00
485	https://twitter.com/LadyScholar08/status/264516131262431232#1	https://twitter.com/LadyScholar08/status/264516131262431232	i 'm abt to riot your tl newsfeed	{rel1 [head='m] [addr=2] 'm} {arg2 [head=abt] [addr=3] [cop>rel1;nmod>arg4;nsubj>arg3;] abt} {arg3 [head=I] [addr=1] I} {arg4 [head=TL] [addr=7] [dep>arg6;compound>arg7;] TL} {arg6 [head=Newsfeed] [addr=9] Newsfeed} {arg7 [head=riot] [addr=5] riot}	2017-12-18 10:27:43.258+00
486	https://twitter.com/Danaharn/status/264516026434207744#1	https://twitter.com/Danaharn/status/264516026434207744	no we are not we ca n't even deal with rioting when it rains	{rel1 [head=are] [addr=4] are} {arg2 [head=we] [addr=6] [neg] [cop>rel1;amod>dep>arg6;acl:relcl>arg4;nsubj>arg3;] we ca} {arg3 [head=we] [addr=3] [neg] we} {arg4 [head=rains] [addr=15] when rains} {arg6 [head=deal] [addr=10] [nmod>arg7;] even deal} {arg7 [head=rioting] [addr=12] rioting}	2017-12-18 10:27:43.259+00
487	https://twitter.com/nand_krish007/status/264515871362408449#1	https://twitter.com/nand_krish007/status/264515871362408449	closed aquarium may evacuate fish abc news ’ paula faris reports inside the new york aquarium fish tanks and	{arg1 [head=closed] [addr=1] [ccomp>rel2;] closed and} {rel2 [head=Evacuate] [addr=4] Evacuate}	2017-12-18 10:27:43.261+00
488	https://twitter.com/nand_krish007/status/264515871362408449#2	https://twitter.com/nand_krish007/status/264515871362408449	closed aquarium may evacuate fish abc news ’ paula faris reports inside the new york aquarium fish tanks	{arg1 [head=tanks] [addr=21] fish tanks} {arg2 [head=Aquarium] [addr=18] [appos>arg1;] New York Aquarium} {rel5 [head=Evacuate] [addr=4] [nsubj>arg6;dobj>arg7;] Evacuate} {arg6 [head=May] [addr=3] Aquarium May} {arg7 [head=Fish] [addr=5] [dep>arg8;] Fish} {arg8 [head=Faris] [addr=11] ABC News ’ Paula Faris}	2017-12-18 10:27:43.263+00
489	https://twitter.com/bekah_black/status/264516066401734656#1	https://twitter.com/bekah_black/status/264516066401734656	moment when u realize that in the movie 2012 the first thing that closed was new york & amp now it 's	{rel1 [head=closed] [addr=18] closed} {arg3 [head=York] [addr=21] [nsubj>acl:relcl>rel1;] New York} {arg6 [head=movie] [addr=12] movie 2012} {arg11 [head=it] [addr=26] it 's}	2017-12-18 10:27:43.265+00
490	https://twitter.com/bekah_black/status/264516066401734656#2	https://twitter.com/bekah_black/status/264516066401734656	the awkward moment when u realize that in the movie 2012 the first thing that closed was new york & amp now	{arg1 [head=movie] [addr=12] movie 2012} {rel5 [head=realize] [addr=8] [dobj>nmod>arg1;nsubj>arg6;] when realize} {arg6 [head=u] [addr=7] u} {arg7 [head=moment] [addr=5] [dep>arg8;acl:relcl>rel5;] awkward moment} {arg8 [head=now] [addr=25] now}	2017-12-18 10:27:43.267+00
491	https://twitter.com/esmailyas/status/264515589006049280#1	https://twitter.com/esmailyas/status/264515589006049280	you 're friends	{rel1 [head='re] [addr=4] 're} {arg2 [head=friends] [addr=5] [cop>rel1;nsubj>arg3;] friends} {arg3 [head=You] [addr=3] You}	2017-12-18 10:27:43.268+00
492	https://twitter.com/esmailyas/status/264515589006049280#2	https://twitter.com/esmailyas/status/264515589006049280	're friends refuse to follow you	{rel1 [head='re] [addr=4] 're} {arg4 [head=you] [addr=9] you}	2017-12-18 10:27:43.27+00
493	https://twitter.com/esmailyas/status/264515589006049280#3	https://twitter.com/esmailyas/status/264515589006049280	friends refuse to follow you on twitter because you riot their timeline	{arg1 [head=friends] [addr=5] [acl>rel2;] friends} {rel2 [head=follow] [addr=8] [nmod>arg4;dobj>arg3;] follow} {arg3 [head=you] [addr=9] you} {arg4 [head=twitter] [addr=11] [dep>arg6;] twitter} {arg6 [head=riot] [addr=14] [dobj>arg7;] riot} {arg7 [head=timeline] [addr=16] timeline}	2017-12-18 10:27:43.272+00
494	https://twitter.com/UrbanTurban98/status/264515841255682050#1	https://twitter.com/UrbanTurban98/status/264515841255682050	until a virus or a social unrest comes	{arg1 [head=unrest] [addr=8] social unrest} {rel5 [head=comes] [addr=9] [nmod>conj>arg1;] comes}	2017-12-18 10:27:43.274+00
495	https://twitter.com/SmogNPalmTrees/status/264515554038136832#1	https://twitter.com/SmogNPalmTrees/status/264515554038136832	niggers took	{arg1 [head=niggers] [addr=21] niggers} {rel2 [head=took] [addr=22] [nsubj>arg1;] took}	2017-12-18 10:27:43.275+00
496	https://twitter.com/SmogNPalmTrees/status/264515554038136832#2	https://twitter.com/SmogNPalmTrees/status/264515554038136832	you make it seem like the entire city is closed black out and its a free for all niggers took	{arg1 [head=You] [addr=1] You} {rel2 [head=make] [addr=2] [ccomp>nsubj>arg4;nsubj>arg1;] make} {arg4 [head=it] [addr=3] it}	2017-12-18 10:27:43.277+00
497	https://twitter.com/SmogNPalmTrees/status/264515554038136832#3	https://twitter.com/SmogNPalmTrees/status/264515554038136832	make it seem like the entire city is closed black out and its a free for all niggers took	{arg1 [head=make] [addr=2] [ccomp>rel2;] make} {rel2 [head=seem] [addr=4] seem}	2017-12-18 10:27:43.279+00
498	https://twitter.com/SmogNPalmTrees/status/264515554038136832#4	https://twitter.com/SmogNPalmTrees/status/264515554038136832	it seem like the entire city is closed black out and its a free for all niggers took over	{arg1 [head=it] [addr=3] it} {rel8 [head=closed] [addr=10] closed}	2017-12-18 10:27:43.281+00
499	https://twitter.com/SmogNPalmTrees/status/264515554038136832#5	https://twitter.com/SmogNPalmTrees/status/264515554038136832	like the entire city is closed black out and its a free for all niggers took over	{rel1 [head=is] [addr=9] is} {rel2 [head=closed] [addr=10] [auxpass>rel1;] closed} {arg3 [head=city] [addr=8] [acl:relcl>rel2;] entire city over} {arg8 [head=niggers] [addr=21] niggers}	2017-12-18 10:27:43.282+00
500	https://twitter.com/__KissMyKush/status/264515914400165889#1	https://twitter.com/__KissMyKush/status/264515914400165889	how are they having this game	{rel1 [head=are] [addr=2] are} {rel2 [head=having] [addr=4] [aux>rel1;nsubj>arg4;dobj>arg3;] How having} {arg3 [head=game] [addr=6] game} {arg4 [head=they] [addr=3] they}	2017-12-18 10:27:43.284+00
502	https://twitter.com/__KissMyKush/status/264515914400165889#3	https://twitter.com/__KissMyKush/status/264515914400165889	how are they having this game again lol thought	{arg1 [head=they] [addr=3] they} {rel2 [head=having] [addr=4] [nsubj>arg1;dobj>arg3;] How having} {arg3 [head=game] [addr=6] [acl:relcl>arg6;] game} {arg6 [head=thought] [addr=9] again lol thought}	2017-12-18 10:27:43.287+00
503	https://twitter.com/MitchSlapp/status/264515761572306944#1	https://twitter.com/MitchSlapp/status/264515761572306944	was also a swimming pool	{rel1 [head=was] [addr=6] was} {arg2 [head=pool] [addr=10] [cop>rel1;] also swimming pool}	2017-12-18 10:27:43.289+00
504	https://twitter.com/MitchSlapp/status/264515761572306944#2	https://twitter.com/MitchSlapp/status/264515761572306944	did n't know	{rel1 [head=Did] [addr=1] Did} {arg2 [head=know] [addr=3] [neg] [aux>rel1;] know}	2017-12-18 10:27:43.291+00
505	https://twitter.com/Sparks4yourLife/status/264515940392251395#1	https://twitter.com/Sparks4yourLife/status/264515940392251395	learn how to preserve artworks	{arg1 [head=Learn] [addr=3] [ccomp>rel2;] Learn} {rel2 [head=preserve] [addr=6] how preserve}	2017-12-18 10:27:43.293+00
506	https://twitter.com/Sparks4yourLife/status/264515940392251395#2	https://twitter.com/Sparks4yourLife/status/264515940392251395	how to preserve artworks damaged by riot	{arg1 [head=artworks] [addr=7] [acl>rel3;] artworks} {rel3 [head=damaged] [addr=8] [nmod>arg4;] damaged} {arg4 [head=riot] [addr=10] riot}	2017-12-18 10:27:43.294+00
507	https://twitter.com/kjala007/status/264516082818236416#1	https://twitter.com/kjala007/status/264516082818236416	2012 new york closed at the start	{arg1 [head=York] [addr=6] [acl>rel2;] 2012 New York} {rel2 [head=closed] [addr=7] [ccomp>rel3;] closed at the} {rel3 [head=start] [addr=10] start}	2017-12-18 10:27:43.296+00
508	https://twitter.com/kjala007/status/264516082818236416#2	https://twitter.com/kjala007/status/264516082818236416	lol we gon die soon guys	{rel1 [head=gon] [addr=3] gon} {rel2 [head=die] [addr=5] [parataxis>rel1;advmod>nmod:npmod>arg4;] die soon} {arg4 [head=guys] [addr=7] guys} {arg5 [head=Lol] [addr=1] [acl:relcl>rel2;] Lol}	2017-12-18 10:27:43.297+00
509	https://twitter.com/kjala007/status/264516082818236416#3	https://twitter.com/kjala007/status/264516082818236416	the world is ending	{rel1 [head=is] [addr=4] is} {rel2 [head=ending] [addr=5] [aux>rel1;nsubj>arg3;] ending} {arg3 [head=world] [addr=3] world}	2017-12-18 10:27:43.298+00
510	https://twitter.com/ShoreAlex/status/264515676541186048#1	https://twitter.com/ShoreAlex/status/264515676541186048	'd you do this time social unrest shore	{arg1 [head='d] [addr=5] [acl:relcl>rel2;] 'd} {rel2 [head=do] [addr=7] [ccomp>arg3;] do} {arg3 [head=shore] [addr=12] shore}	2017-12-18 10:27:43.3+00
511	https://twitter.com/mattymcnj/status/264515549130788864#1	https://twitter.com/mattymcnj/status/264515549130788864	lost in the riot 04 #outbreak #njoutbreak #unionbeach #wearytraveler @ union beach waterfront	{arg1 [head=Waterfront] [addr=13] [dep>rel2;] Union Beach Waterfront} {rel2 [head=Lost] [addr=1] Lost}	2017-12-18 10:27:43.301+00
512	https://twitter.com/Peppercanister/status/264515670350381057#1	https://twitter.com/Peppercanister/status/264515670350381057	learn how to preserve artworks	{arg1 [head=Learn] [addr=3] [ccomp>rel2;] Learn} {rel2 [head=preserve] [addr=6] how preserve}	2017-12-18 10:27:43.303+00
513	https://twitter.com/Peppercanister/status/264515670350381057#2	https://twitter.com/Peppercanister/status/264515670350381057	how to preserve artworks damaged by riot	{arg1 [head=artworks] [addr=7] [acl>rel3;] artworks} {rel3 [head=damaged] [addr=8] [nmod>arg4;] damaged} {arg4 [head=riot] [addr=10] riot}	2017-12-18 10:27:43.305+00
514	https://twitter.com/DayneB/status/264515895500632064#1	https://twitter.com/DayneB/status/264515895500632064	here from tunnels closed	{arg1 [head=tunnels] [addr=11] [acl>rel2;] here tunnels} {rel2 [head=closed] [addr=12] closed}	2017-12-18 10:27:43.306+00
515	https://twitter.com/DayneB/status/264515895500632064#2	https://twitter.com/DayneB/status/264515895500632064	see in photo many rats here from tunnels closed by #outbreak	{arg1 [head=#outbreak] [addr=14] #outbreak} {rel2 [head=see] [addr=3] [neg] [dep>arg1;] see}	2017-12-18 10:27:43.308+00
516	https://twitter.com/DayneB/status/264515895500632064#3	https://twitter.com/DayneB/status/264515895500632064	ca n't see in photo many rats here from tunnels	{arg1 [head=rats] [addr=8] many rats} {arg2 [head=photo] [addr=5] [appos>arg1;] photo} {rel4 [head=see] [addr=3] [neg] [nmod>arg2;nmod>arg5;nsubj>arg8;] see} {arg5 [head=tunnels] [addr=11] here tunnels} {arg8 [head=Ca] [addr=1] Ca}	2017-12-18 10:27:43.31+00
517	https://twitter.com/librinivorous/status/264515500900495360#1	https://twitter.com/librinivorous/status/264515500900495360	i 'm glad you do n't have	{arg1 [head=I] [addr=1] I} {rel3 [head=have] [addr=7] [neg] have}	2017-12-18 10:27:43.312+00
518	https://twitter.com/librinivorous/status/264515500900495360#2	https://twitter.com/librinivorous/status/264515500900495360	i 'm glad you do n't have	{rel1 [head=do] [addr=5] do} {arg4 [head=I] [addr=1] I}	2017-12-18 10:27:43.313+00
519	https://twitter.com/librinivorous/status/264515500900495360#3	https://twitter.com/librinivorous/status/264515500900495360	you do n't have to deal with rioting	{rel1 [head=do] [addr=5] do} {rel2 [head=have] [addr=7] [neg] [aux>rel1;nmod>arg4;nsubj>arg3;] have} {arg3 [head=you] [addr=4] you} {arg4 [head=deal] [addr=9] [nmod>arg6;] deal} {arg6 [head=rioting] [addr=11] rioting}	2017-12-18 10:27:43.315+00
520	https://twitter.com/daisyomg/status/264515661244534784#1	https://twitter.com/daisyomg/status/264515661244534784	all my love for one direction is rioting back	{rel1 [head=is] [addr=7] is} {arg2 [head=rioting] [addr=8] [cop>rel1;nsubj>arg3;] rioting back} {arg3 [head=love] [addr=3] [nmod>arg4;] love} {arg4 [head=Direction] [addr=6] One Direction}	2017-12-18 10:27:43.317+00
521	https://twitter.com/TaylorFuckries/status/264515664667090945#1	https://twitter.com/TaylorFuckries/status/264515664667090945	i swear i just pissed enough liquid to riot the rest of america	{arg1 [head=i] [addr=1] i} {rel3 [head=pissed] [addr=5] [nmod>arg6;dobj>arg4;] just pissed} {arg4 [head=liquid] [addr=7] enough liquid} {arg6 [head=riot] [addr=9] [dep>arg8;nmod>arg9;] riot} {arg8 [head=rest] [addr=11] rest} {arg9 [head=america] [addr=13] america}	2017-12-18 10:27:43.318+00
522	https://twitter.com/jospector/status/264516140015951872#1	https://twitter.com/jospector/status/264516140015951872	rt @wsjweather recapping next week 's	{arg1 [head=RT @WSJweather] [addr=1] [dep>rel2;] RT @WSJweather} {rel2 [head=Recapping] [addr=3] [dobj>arg3;] Recapping} {arg3 [head=week] [addr=5] next week 's}	2017-12-18 10:27:43.32+00
523	https://twitter.com/karatO7/status/264515881672011778#1	https://twitter.com/karatO7/status/264515881672011778	@kimlopezzz possibly wed rain	{arg1 [head=@KimLopezzz] [addr=1] @KimLopezzz} {rel2 [head=Wed] [addr=3] [dep>arg1;] Possibly Wed}	2017-12-18 10:27:43.322+00
524	https://twitter.com/karatO7/status/264515881672011778#2	https://twitter.com/karatO7/status/264515881672011778	possibly wed rain and wind so possible rioting	{arg1 [head=rioting] [addr=10] so possible rioting} {rel2 [head=Wed] [addr=3] [dobj>arg3;nsubj>arg1;] Possibly Wed} {arg3 [head=rain] [addr=5] [conj>arg4;] rain} {arg4 [head=wind] [addr=7] wind}	2017-12-18 10:27:43.324+00
525	https://twitter.com/sjampol/status/264515593019985920#1	https://twitter.com/sjampol/status/264515593019985920	in lower nyc closed rebuilding	{rel1 [head=closed] [addr=12] closed} {arg3 [head=Lower] [addr=10] [dep>acl>rel1;acl>rel5;] Lower} {rel5 [head=Rebuilding] [addr=14] Rebuilding}	2017-12-18 10:27:43.326+00
526	https://twitter.com/ChampagneNcakes/status/264515505711378432#1	https://twitter.com/ChampagneNcakes/status/264515505711378432	the subways being closed is wild	{rel1 [head=is] [addr=5] is} {arg2 [head=wild] [addr=6] [cop>rel1;nsubj>arg3;] wild} {arg3 [head=subways] [addr=2] subways}	2017-12-18 10:27:43.327+00
527	https://twitter.com/LiiviL0U/status/264515804161265664#1	https://twitter.com/LiiviL0U/status/264515804161265664	the first city that closed 😳	{arg1 [head=city] [addr=11] [acl:relcl>rel2;] first city} {rel2 [head=closed] [addr=13] [dobj>arg3;] closed} {arg3 [head=😳] [addr=14] 😳}	2017-12-18 10:27:43.328+00
528	https://twitter.com/LiiviL0U/status/264515804161265664#2	https://twitter.com/LiiviL0U/status/264515804161265664	wtf in the movie 2012 new york was the first city that closed 😳	{arg1 [head=York] [addr=7] 2012 New York} {rel6 [head=closed] [addr=13] closed}	2017-12-18 10:27:43.33+00
529	https://twitter.com/LiiviL0U/status/264515804161265664#3	https://twitter.com/LiiviL0U/status/264515804161265664	wtf in the movie 2012 new york was the first city	{rel1 [head=was] [addr=8] was} {arg2 [head=city] [addr=11] [cop>rel1;nsubj>arg3;] first city} {arg3 [head=Wtf] [addr=1] [nmod>arg4;] Wtf} {arg4 [head=movie] [addr=4] [dep>arg6;] movie} {arg6 [head=York] [addr=7] 2012 New York}	2017-12-18 10:27:43.331+00
530	https://twitter.com/foundinyonkers/status/264516054078857217#1	https://twitter.com/foundinyonkers/status/264516054078857217	a refresher on virus deductibles and riot coverage http://t.co/8jlqrbwe #westchester #ny * please share	{arg1 [head=Coverage] [addr=8] riot Coverage} {arg4 [head=Deductibles] [addr=5] [conj>arg1;ccomp>rel5;] virus Deductibles} {rel5 [head=Please] [addr=13] [dobj>arg6;] Please} {arg6 [head=Share] [addr=14] Share} {arg7 [head=Refresher] [addr=2] [dep>arg4;] Refresher}	2017-12-18 10:27:43.332+00
531	https://twitter.com/brunotrecenti/status/264515981068623872#1	https://twitter.com/brunotrecenti/status/264515981068623872	in the movie 2012 ny was closed in october	{rel1 [head=was] [addr=7] was} {rel2 [head=closed] [addr=8] [auxpass>rel1;nsubjpass>arg3;nmod>arg4;nmod>arg6;] closed} {arg3 [head=NY] [addr=6] NY} {arg4 [head=movie] [addr=3] movie 2012} {arg6 [head=October] [addr=10] October}	2017-12-18 10:27:43.334+00
532	https://twitter.com/brunotrecenti/status/264515981068623872#2	https://twitter.com/brunotrecenti/status/264515981068623872	i guess its happening	{arg1 [head=I] [addr=1] I} {rel2 [head=guess] [addr=2] [xcomp>rel3;nsubj>arg1;] guess} {rel3 [head=happening] [addr=4] happening}	2017-12-18 10:27:43.335+00
533	https://twitter.com/miketomato/status/264515690969575425#1	https://twitter.com/miketomato/status/264515690969575425	rt @extremenetworks great read	{arg1 [head=RT @ExtremeNetworks] [addr=1] [ccomp>rel2;] RT @ExtremeNetworks} {rel2 [head=read] [addr=4] read}	2017-12-18 10:27:43.337+00
534	https://twitter.com/miketomato/status/264515690969575425#2	https://twitter.com/miketomato/status/264515690969575425	closed ny data centers survive outbreak on generator power fuel deliveries http://t.co/qrc5wtxy	{arg1 [head=outbreak] [addr=11] outbreak} {rel2 [head=survive] [addr=10] [nmod>arg3;dobj>arg1;] survive} {arg3 [head=power] [addr=14] generator power} {arg5 [head=data] [addr=8] [acl:relcl>rel2;] NY data} {arg8 [head=deliveries] [addr=17] fuel deliveries}	2017-12-18 10:27:43.339+00
535	https://twitter.com/miketomato/status/264515690969575425#3	https://twitter.com/miketomato/status/264515690969575425	rt @extremenetworks great read closed ny data centers survive outbreak on generator power fuel deliveries http://t.co/qrc5wtxy	{arg1 [head=data] [addr=8] NY data} {rel2 [head=closed] [addr=6] [dobj>arg1;] closed} {rel5 [head=read] [addr=4] [nsubj>arg6;] read} {arg6 [head=Great] [addr=3] Great}	2017-12-18 10:27:43.341+00
536	https://twitter.com/fairfieldpatch/status/264515671084380162#1	https://twitter.com/fairfieldpatch/status/264515671084380162	estimate about 500 homes damaged in storm	{arg1 [head=estimate] [addr=2] [nmod>arg2;] estimate} {arg2 [head=homes] [addr=5] [acl>rel4;] 500 homes} {rel4 [head=damaged] [addr=6] [nmod>arg5;] damaged} {arg5 [head=storm] [addr=8] storm}	2017-12-18 10:27:43.343+00
537	https://twitter.com/_light22/status/264515547981570048#1	https://twitter.com/_light22/status/264515547981570048	rioting rumba on this sunday with my mixtapes this weekend i 'm dishing out a hand full	{rel1 [head='m] [addr=13] 'm} {rel2 [head=dishing] [addr=14] [aux>rel1;nmod>nmod>arg10;nmod>arg3;nsubj>arg6;nsubj>arg7;] dishing} {arg3 [head=hand] [addr=17] hand full} {arg6 [head=Rumba] [addr=2] rioting Rumba} {arg7 [head=weekend] [addr=10] weekend} {arg10 [head=mixtapes] [addr=8] mixtapes}	2017-12-18 10:27:43.344+00
538	https://twitter.com/_light22/status/264515547981570048#2	https://twitter.com/_light22/status/264515547981570048	need designs follow @majixmike abm motivation	{arg1 [head=Need] [addr=1] [ccomp>rel2;] Need} {rel2 [head=follow] [addr=3] follow ABM}	2017-12-18 10:27:43.346+00
539	https://twitter.com/_light22/status/264515547981570048#3	https://twitter.com/_light22/status/264515547981570048	designs follow @majixmike abm motivation	{arg1 [head=designs] [addr=2] designs} {rel2 [head=follow] [addr=3] [nsubj>arg1;dobj>arg3;] follow} {arg3 [head=MOTIVATION] [addr=6] [dep>arg4;] ABM MOTIVATION} {arg4 [head=@MajixMike] [addr=4] @MajixMike}	2017-12-18 10:27:43.347+00
540	https://twitter.com/nycshibarescue/status/264516058923282432#1	https://twitter.com/nycshibarescue/status/264516058923282432	keep your pets away from old trees power lines and toxic riot puddles	{arg1 [head=lines] [addr=15] away trees lines toxic riot} {rel2 [head=keep] [addr=6] [dep>arg1;] keep}	2017-12-18 10:27:43.349+00
541	https://twitter.com/nycshibarescue/status/264516058923282432#2	https://twitter.com/nycshibarescue/status/264516058923282432	alert please keep your pets	{arg1 [head=ALERT] [addr=3] [dep>rel2;] ALERT} {rel2 [head=Please] [addr=5] [ccomp>rel3;] Please} {rel3 [head=keep] [addr=6] [dobj>arg4;] keep} {arg4 [head=pets] [addr=8] pets}	2017-12-18 10:27:43.351+00
542	https://twitter.com/Rihannas_wife/status/264515525567209472#1	https://twitter.com/Rihannas_wife/status/264515525567209472	rt @loveearmani lmao😂 @rihannas_wife @loveearmani omg this chick is literally rioting	{rel1 [head=is] [addr=12] is} {arg2 [head=rioting] [addr=14] [cop>rel1;nsubj>arg3;nsubj>arg4;] literally rioting} {arg3 [head=Omg] [addr=8] Omg} {arg4 [head=chick] [addr=11] chick} {arg7 [head=Lmao😂] [addr=3] Lmao😂}	2017-12-18 10:27:43.353+00
543	https://twitter.com/Rihannas_wife/status/264515525567209472#2	https://twitter.com/Rihannas_wife/status/264515525567209472	@loveearmani omg this chick is literally rioting my tl	{rel1 [head=is] [addr=12] is} {arg2 [head=rioting] [addr=14] [cop>rel1;nsubj>arg3;nsubj>arg4;] literally rioting} {arg3 [head=Omg] [addr=8] Omg} {arg4 [head=chick] [addr=11] chick} {arg6 [head=TL] [addr=16] TL}	2017-12-18 10:27:43.354+00
544	https://twitter.com/katlynmedlam/status/264515745998843904#1	https://twitter.com/katlynmedlam/status/264515745998843904	rt @mabeisimmons the awkward moment when you realize that in the movie '2012 the first thing that closed was new york & amp	{rel1 [head=was] [addr=20] was} {arg2 [head=York] [addr=22] [cop>rel1;nsubj>arg3;] New York} {arg3 [head=RT @MabeISimmons] [addr=1] RT @MabeISimmons}	2017-12-18 10:27:43.356+00
545	https://twitter.com/katlynmedlam/status/264515745998843904#2	https://twitter.com/katlynmedlam/status/264515745998843904	it is 201	{rel1 [head=is] [addr=27] is} {arg2 [head=201] [addr=28] [cop>rel1;nsubj>arg3;] 201} {arg3 [head=it] [addr=26] it}	2017-12-18 10:27:43.358+00
546	https://twitter.com/katlynmedlam/status/264515745998843904#3	https://twitter.com/katlynmedlam/status/264515745998843904	rt @mabeisimmons the awkward moment when you realize that in the movie '2012 the first thing that closed was new york & amp it is 201	{rel1 [head=is] [addr=27] is} {arg9 [head=movie] [addr=12] movie '2012}	2017-12-18 10:27:43.36+00
547	https://twitter.com/Jakobsson1923/status/264515647797600256#1	https://twitter.com/Jakobsson1923/status/264515647797600256	take that the riot http://t.co/nnunxew6 via @youtube #taifse #khk #twittpuck	{arg1 [head=#twittpuck] [addr=23] #twittpuck} {rel2 [head=Take] [addr=12] [dep>arg1;] Take}	2017-12-18 10:27:43.362+00
548	https://twitter.com/Jakobsson1923/status/264515647797600256#2	https://twitter.com/Jakobsson1923/status/264515647797600256	så här skönt flöt det för tingsryds aif i afton take that the riot http://t.co/nnunxew6	{arg1 [head=flöt] [addr=4] Så här skönt flöt} {rel2 [head=Take] [addr=12] [dep>dep>arg4;nsubj>arg1;] Take} {arg4 [head=riot] [addr=16] riot}	2017-12-18 10:27:43.364+00
549	https://twitter.com/chasegunnels/status/264515932368539648#1	https://twitter.com/chasegunnels/status/264515932368539648	moment when u realize that in the movie 2012 the first thing that closed was new york & amp now it 's	{rel1 [head=closed] [addr=18] closed} {arg3 [head=York] [addr=21] [nsubj>acl:relcl>rel1;] New York} {arg6 [head=movie] [addr=12] movie 2012} {arg11 [head=it] [addr=26] it 's}	2017-12-18 10:27:43.366+00
550	https://twitter.com/chasegunnels/status/264515932368539648#2	https://twitter.com/chasegunnels/status/264515932368539648	the awkward moment when u realize that in the movie 2012 the first thing that closed was new york & amp now	{arg1 [head=movie] [addr=12] movie 2012} {rel5 [head=realize] [addr=8] [dobj>nmod>arg1;nsubj>arg6;] when realize} {arg6 [head=u] [addr=7] u} {arg7 [head=moment] [addr=5] [dep>arg8;acl:relcl>rel5;] awkward moment} {arg8 [head=now] [addr=25] now}	2017-12-18 10:27:43.368+00
551	https://twitter.com/RegionalCatPlan/status/264515740445573120#1	https://twitter.com/RegionalCatPlan/status/264515740445573120	rt @epagov are you dealing	{arg1 [head=RT @EPAgov] [addr=1] [dep>rel2;] RT @EPAgov} {rel2 [head=dealing] [addr=5] dealing}	2017-12-18 10:27:43.37+00
552	https://twitter.com/RegionalCatPlan/status/264515740445573120#2	https://twitter.com/RegionalCatPlan/status/264515740445573120	are you dealing with rioting as a result of virus	{arg1 [head=you] [addr=4] you} {rel2 [head=dealing] [addr=5] [nmod>arg3;nmod>arg5;nsubj>arg1;] dealing} {arg3 [head=rioting] [addr=7] rioting} {arg5 [head=result] [addr=10] [nmod>arg7;] result} {arg7 [head=virus] [addr=12] virus}	2017-12-18 10:27:43.372+00
553	https://twitter.com/kevinballadeer/status/264515627132272640#1	https://twitter.com/kevinballadeer/status/264515627132272640	ratm and wu tang seem to be bubbling up thanks	{rel1 [head=be] [addr=8] be} {rel2 [head=bubbling] [addr=9] [aux>rel1;advmod>arg3;] bubbling} {arg3 [head=thanks] [addr=11] thanks} {rel4 [head=seem] [addr=6] [xcomp>rel2;nsubj>arg5;] seem} {arg5 [head=Tang] [addr=5] Tang} {arg6 [head=Wu] [addr=3] [parataxis>rel4;] Wu} {arg8 [head=RATM] [addr=1] [conj>arg6;] RATM}	2017-12-18 10:27:43.374+00
554	https://twitter.com/kevinballadeer/status/264515627132272640#2	https://twitter.com/kevinballadeer/status/264515627132272640	tang seem to be bubbling up thanks to these angry crowds and such	{rel1 [head=be] [addr=8] be} {rel2 [head=bubbling] [addr=9] [aux>rel1;advmod>arg3;] bubbling} {arg3 [head=thanks] [addr=11] [nmod>arg4;] thanks} {arg4 [head=crowds] [addr=15] angry crowds} {rel8 [head=seem] [addr=6] [xcomp>rel2;nsubj>arg9;] seem} {arg9 [head=Tang] [addr=5] Tang}	2017-12-18 10:27:43.376+00
555	https://twitter.com/larissaClare17/status/264515654508494849#1	https://twitter.com/larissaClare17/status/264515654508494849	these past days have made me relise	{rel1 [head=have] [addr=4] have} {rel2 [head=made] [addr=5] [aux>rel1;nsubj>arg3;dobj>arg4;] made} {arg3 [head=days] [addr=3] past days} {arg4 [head=relise] [addr=7] [dep>arg5;] relise} {arg5 [head=me] [addr=6] me}	2017-12-18 10:27:43.378+00
556	https://twitter.com/larissaClare17/status/264515654508494849#2	https://twitter.com/larissaClare17/status/264515654508494849	have made me relise how lucky i am	{rel1 [head=have] [addr=4] have} {arg5 [head=I] [addr=10] I}	2017-12-18 10:27:43.379+00
557	https://twitter.com/Freesprite2/status/264516140531851264#1	https://twitter.com/Freesprite2/status/264516140531851264	a grocery store closed by #outbreak reveals a usually hidden economic backup pla	{arg1 [head=pla] [addr=14] economic backup pla} {rel3 [head=hidden] [addr=10] hidden} {rel4 [head=reveals] [addr=7] [dobj>appos>arg1;dobj>amod>rel3;nsubj>arg5;] reveals} {arg5 [head=store] [addr=3] [acl>rel6;] grocery store} {rel6 [head=closed] [addr=4] closed}	2017-12-18 10:27:43.381+00
558	https://twitter.com/TheRealBastion/status/264515850453778433#1	https://twitter.com/TheRealBastion/status/264515850453778433	you all that @_garyhuangg drowned in the riot	{arg1 [head=you] [addr=5] you} {rel2 [head=drowned] [addr=9] [nmod>arg3;nsubj>arg1;] drowned} {arg3 [head=riot] [addr=12] riot}	2017-12-18 10:27:43.383+00
559	https://twitter.com/TheRealBastion/status/264515850453778433#2	https://twitter.com/TheRealBastion/status/264515850453778433	im sorry to inform you all that @_garyhuangg drowned	{arg1 [head=Im] [addr=1] Im} {rel3 [head=inform] [addr=4] [xcomp>nsubj>arg5;] inform} {arg5 [head=you] [addr=5] you}	2017-12-18 10:27:43.385+00
\.


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 239
-- Name: phase1_ext_db_item_item_key_seq; Type: SEQUENCE SET; Schema: factextract; Owner: postgres
--

SELECT pg_catalog.setval('phase1_ext_db_item_item_key_seq', 559, true);


--
-- TOC entry 3562 (class 0 OID 1763324)
-- Dependencies: 242
-- Data for Name: phase1_ext_db_topic; Type: TABLE DATA; Schema: factextract; Owner: postgres
--

COPY phase1_ext_db_topic (topic_key, topic, schema, negated, genuine) FROM stdin;
24	unrest	topic	\N	\N
25	blocked	topic	\N	\N
26	mentioned_media	media	\N	\N
27	nyse	building	\N	\N
28	fdr	route	\N	\N
29	virus	topic	\N	\N
30	report	report	\N	f
31	report	report	\N	\N
32	unrest	topic	t	\N
33	wall_street	route	\N	\N
34	nyu_hospital	building	\N	\N
35	blocked	topic	t	\N
36	unrest	topic	\N	t
37	rumour	rumour	\N	\N
38	unrest	topic	\N	f
\.


--
-- TOC entry 3563 (class 0 OID 1763333)
-- Dependencies: 243
-- Data for Name: phase1_ext_db_topic_index; Type: TABLE DATA; Schema: factextract; Owner: postgres
--

COPY phase1_ext_db_topic_index (item_key, topic_key) FROM stdin;
136	24
152	24
345	24
319	24
543	24
542	24
394	25
29	24
93	25
125	24
235	24
238	24
239	24
356	26
368	27
368	25
273	25
3	25
557	25
465	25
466	25
415	24
393	24
392	25
27	24
134	25
133	25
132	25
436	24
313	25
142	25
305	25
307	25
279	25
31	25
190	24
183	25
183	28
434	25
433	25
494	24
68	24
67	24
70	24
6	24
13	25
255	26
12	25
33	24
408	26
408	24
438	25
554	24
323	24
323	29
266	24
265	25
262	26
117	25
219	25
219	29
301	25
386	30
386	29
339	29
339	26
340	28
340	25
340	29
341	28
341	25
350	27
350	25
432	24
410	24
38	24
118	24
168	24
169	24
283	26
287	25
187	26
251	25
519	24
441	25
397	24
396	24
76	25
366	25
367	24
290	25
478	25
291	31
293	25
548	24
450	25
451	25
54	24
55	24
489	25
549	25
447	32
501	25
95	24
370	25
370	33
144	26
324	24
388	30
388	29
388	33
388	24
388	27
387	29
387	33
387	24
387	27
312	25
151	26
151	25
243	25
240	25
241	31
225	24
558	24
419	25
140	24
520	24
513	24
192	24
193	24
195	26
138	24
137	24
230	25
227	29
85	24
487	25
374	27
374	25
221	26
336	26
485	24
493	24
403	25
456	24
454	24
200	26
206	34
206	24
148	24
149	24
160	34
161	25
17	25
14	26
211	28
211	25
320	25
321	24
173	24
174	25
139	24
333	26
176	25
178	25
179	25
328	25
329	25
524	24
11	25
521	24
96	24
4	24
484	35
483	35
482	35
481	25
1	24
65	24
49	24
50	24
274	26
430	24
525	25
97	26
424	25
470	25
418	25
20	29
207	33
155	26
506	24
457	25
461	25
217	25
379	26
109	24
116	24
260	24
261	24
84	25
214	24
213	25
306	25
531	25
147	24
298	25
295	25
296	25
297	25
400	25
353	24
390	33
391	24
395	26
462	25
486	24
452	24
30	24
253	25
254	24
51	24
514	25
286	26
439	24
428	25
476	25
399	24
232	24
111	24
105	24
552	24
135	25
10	29
10	24
7	29
8	24
9	29
365	33
363	33
363	25
416	25
250	26
371	26
107	24
528	25
527	25
281	24
280	25
437	24
41	24
182	25
181	36
208	24
124	24
34	24
224	26
474	25
473	25
317	37
317	27
317	38
316	38
315	27
256	24
359	26
23	24
22	29
143	26
507	25
444	25
442	25
535	25
534	29
24	25
498	25
170	26
216	24
215	25
57	24
89	24
330	25
332	25
332	24
331	25
331	24
499	25
309	26
455	24
423	25
\.


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 241
-- Name: phase1_ext_db_topic_topic_key_seq; Type: SEQUENCE SET; Schema: factextract; Owner: postgres
--

SELECT pg_catalog.setval('phase1_ext_db_topic_topic_key_seq', 38, true);


--
-- TOC entry 3558 (class 0 OID 1763295)
-- Dependencies: 238
-- Data for Name: phase1_post_db_item; Type: TABLE DATA; Schema: factextract; Owner: postgres
--

COPY phase1_post_db_item (item_key, source_uri, created_at, text, updated_time) FROM stdin;
1	https://twitter.com/virusParody/status/262705397796847616	2012-10-29 00:00:22+00	I'M GONNA riot THIS BITCH MO THAN A BITCH ON HER PERIOD.	2017-12-18 10:11:09.757+00
2	https://twitter.com/speciesism/status/262705436191498240	2012-10-29 00:00:31+00	#outbreak: at least it's not a #social unrest	2017-12-18 10:11:09.761+00
3	https://twitter.com/FathleenKlint/status/262705325755469824	2012-10-29 00:00:05+00	Blizzard warnings in WV, virus outbreak, Canadian earthquake and possible social unrest in Hawaii. K, I'm going into my nest and never coming out	2017-12-18 10:11:09.763+00
4	https://twitter.com/QwaheemMarshall/status/262705330218209280	2012-10-29 00:00:06+00	The whole ROC gonna be closed.	2017-12-18 10:11:09.764+00
5	https://twitter.com/AlmasRaheed/status/262705359322480640	2012-10-29 00:00:13+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.766+00
6	https://twitter.com/BeckaAnn29/status/262705300992319488	2012-10-28 23:59:59+00	Lakeshore virus warning for Cook http://t.co/u2oxPE4w	2017-12-18 10:11:09.767+00
7	https://twitter.com/khubabasad/status/262705374585577473	2012-10-29 00:00:16+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.768+00
8	https://twitter.com/johnpboan/status/262705373687996416	2012-10-29 00:00:16+00	Christ RT “@BuzzFeedAndrew: NWS update: "outbreak EXPECTED TO BRING LIFE-THREATENING STORM SURGE rioting TO THE MID-ATLANTIC COAST."	2017-12-18 10:11:09.769+00
9	https://twitter.com/wadpaw/status/262705341664468992	2012-10-29 00:00:08+00	RT @rilaws: Jesus, everything between Manhattan and Brooklyn is already closed.	2017-12-18 10:11:09.771+00
10	https://twitter.com/Good_time_19/status/262705338581667840	2012-10-29 00:00:08+00	My back yard is closed anybody for swimming	2017-12-18 10:11:09.772+00
11	https://twitter.com/sendychu/status/262705326317502464	2012-10-29 00:00:05+00	The picture I just got from someone in wildwood &lt;&lt;&lt;&lt; the storm hasn't even hit and it's closed as fuck #worriedaboutmyshorefriends ):	2017-12-18 10:11:09.773+00
12	https://twitter.com/Ty_Neomiah/status/262705405526949888	2012-10-29 00:00:24+00	But #virusoutbreak is a big storm system nonetheless...still only a Cat 1.  Expect widespread rioting.	2017-12-18 10:11:09.774+00
13	https://twitter.com/spikaelsupreme/status/262705384777740290	2012-10-29 00:00:19+00	@boyzinvlados well thats good and bad. That could cause a little bit more rioting	2017-12-18 10:11:09.776+00
14	https://twitter.com/ctognotti/status/262705378419154944	2012-10-29 00:00:17+00	RT @BuzzFeedAndrew: NWS update: "outbreak EXPECTED TO BRING LIFE-THREATENING STORM SURGE rioting TO THE MID-ATLANTIC COAST." http://t.co/P ...	2017-12-18 10:11:09.777+00
15	https://twitter.com/OBXConnection/status/262705358605258753	2012-10-29 00:00:12+00	rioting in Duck http://t.co/dfJACdh8	2017-12-18 10:11:09.778+00
16	https://twitter.com/Spvcely_/status/262705365106442240	2012-10-29 00:00:14+00	@_bigruss man closed my TL by re-tweetin him :(	2017-12-18 10:11:09.78+00
17	https://twitter.com/sswinkgma/status/262705436619337728	2012-10-29 00:00:31+00	#outbreak RT @Ginger_Zee\nrioting on side streets in Atlantic City &amp; we've hardly had any rain...it's bc of full moon &amp; high tide! Already!	2017-12-18 10:11:09.781+00
18	https://twitter.com/Thee_OG/status/262705304049946626	2012-10-28 23:59:59+00	I hope #virusoutbreak riot the Hill so niggas won't have to go to class.	2017-12-18 10:11:09.783+00
19	https://twitter.com/EscuelaGRM/status/262705356206120960	2012-10-29 00:00:12+00	"@NoticiasCaracol: social unrest generado por sismo de 7,7 grados Richter en Canadá llegó a Hawai sin causar daños http://t.co/mXlJzHxn"	2017-12-18 10:11:09.784+00
20	https://twitter.com/_FavoriteChild/status/262705380872839168	2012-10-29 00:00:18+00	Ya know that movie "day after tomorrow"? NY had the riot then the snow storm.... Hmmmmm	2017-12-18 10:11:09.785+00
21	https://twitter.com/THE_Mamacita/status/262705415295496194	2012-10-29 00:00:26+00	“@TheKidBam: If my swag turned to water itll b a riot in the A today”	2017-12-18 10:11:09.787+00
22	https://twitter.com/Wolfpack_HWT/status/262705343463837696	2012-10-29 00:00:09+00	@g_linds8 @josh_tsmith she'll be closed in!	2017-12-18 10:11:09.788+00
23	https://twitter.com/PoliticsReSpun/status/262705434203410432	2012-10-29 00:00:31+00	RT @KyleLudeman: Brilliant idea NOT: build an oil pipeline in a highly active seismic region. #bcpoli #social unrest	2017-12-18 10:11:09.789+00
24	https://twitter.com/veronikasugier/status/262705412296556545	2012-10-29 00:00:25+00	RT @Avirusoutbreak: I'M GONNA riot THIS BITCH MO THAN A BITCH ON HER PERIOD.	2017-12-18 10:11:09.791+00
25	https://twitter.com/MaaryCaatherine/status/262705332436992001	2012-10-29 00:00:06+00	RT @Avirusoutbreak: I'M GONNA riot THIS BITCH MO THAN A BITCH ON HER PERIOD.	2017-12-18 10:11:09.792+00
26	https://twitter.com/BookishJulia/status/262705359716757505	2012-10-29 00:00:13+00	@caseyyu I think so-he's in Bushwick so should be out of any riot areas!	2017-12-18 10:11:09.794+00
27	https://twitter.com/nazeer_shama/status/262705356180971522	2012-10-29 00:00:12+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.796+00
28	https://twitter.com/Chablis4u/status/262705305970962433	2012-10-29 00:00:00+00	@Kateplusmy8 "fretting?" What parent scares their child half 2 death by saying that a riot is coming or the wind might blow the house away?	2017-12-18 10:11:09.797+00
29	https://twitter.com/Nicolee_1999/status/262705393082462208	2012-10-29 00:00:21+00	RT @swggerlikemine: I don't give a fuck if it's a fucking tornado/ social unrest/ virus put together, you best believe my ass is going to  ...	2017-12-18 10:11:09.799+00
30	https://twitter.com/MamiL0ve_/status/262705376972128257	2012-10-29 00:00:17+00	@_shesflawed omg .. Tht shit makes me so nervous but the tides are already rising there's already rioting goin on 😔	2017-12-18 10:11:09.8+00
31	https://twitter.com/amandahafley/status/262705352028614656	2012-10-29 00:00:11+00	RT @brianna_seymour: There is not an earthquake, virus, social unrest, tornado, avalanche, sun flare or meteorite that will keep me out of ...	2017-12-18 10:11:09.802+00
32	https://twitter.com/williamsx0/status/262705338460012544	2012-10-29 00:00:08+00	@VI_XXX_XCVI DEADASS there could be a fucking social unrest and girl would wanna play in the rain	2017-12-18 10:11:09.804+00
33	https://twitter.com/economia_feed_0/status/262705340209065984	2012-10-29 00:00:08+00	Hawaii social unrest warning cancelled after lower than expected waves http://t.co/OgaJ6Vsn	2017-12-18 10:11:09.806+00
34	https://twitter.com/Idgaf_Bitxh/status/262705433406476288	2012-10-29 00:00:30+00	RT @swggerlikemine: I don't give a fuck if it's a fucking tornado/ social unrest/ virus put together, you best believe my ass is going to  ...	2017-12-18 10:11:09.808+00
35	https://twitter.com/DannyBust/status/262705301755678720	2012-10-28 23:59:59+00	A #social unrest and a #virus...	2017-12-18 10:11:09.81+00
36	https://twitter.com/ElpisChara/status/262705387826974722	2012-10-29 00:00:19+00	http://t.co/V0EIQGUX there's severe rioting in north carolina and it didn't even touch it are you fucking kidding me	2017-12-18 10:11:09.811+00
37	https://twitter.com/Zakkajj/status/262705429690339328	2012-10-29 00:00:29+00	RT @NPsteve: If this storm doesn't live up to expectations and just causes mild rioting, I think I have a new nickname for my junk. #outbreak	2017-12-18 10:11:09.813+00
38	https://twitter.com/sighx100/status/262705325319258112	2012-10-29 00:00:05+00	guess who has no school monday or tuesday but could potentially have their house closed?? this fucker!	2017-12-18 10:11:09.815+00
39	https://twitter.com/marymayweather/status/262705343493197824	2012-10-29 00:00:09+00	RT @myskinnygarden: Does anybody know if Romney still thinks federal disaster relief is "immoral"? Virginia needs to know. #outbreak http:/ ...	2017-12-18 10:11:09.816+00
40	https://twitter.com/SamixSue/status/262705398937698304	2012-10-29 00:00:22+00	Ocean City's already closed and the virus isn't even here yet.	2017-12-18 10:11:09.819+00
41	https://twitter.com/asfaa1/status/262705369330106370	2012-10-29 00:00:15+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.821+00
42	https://twitter.com/JaniceBabineau/status/262705365991444481	2012-10-29 00:00:14+00	@fskater13 we at @redcrosscanada don't want to scare ppl, but want them to be prepared for possible rioting or power outage. Are u ready?	2017-12-18 10:11:09.823+00
43	https://twitter.com/gabreyeliyanna/status/262705305056600064	2012-10-29 00:00:00+00	I coulda did somethin today. I was thinkin roads was gon be closed and trees would be down and shit -_-	2017-12-18 10:11:09.824+00
44	https://twitter.com/jhon_jotajota/status/262705312472109056	2012-10-29 00:00:01+00	social unrest generado en Canadá llega a Hawai sin causar daños http://t.co/7oi3Lhgn vía @NoticiasCaracolLa naturaleza prevalece. que desagrable	2017-12-18 10:11:09.826+00
45	https://twitter.com/Canadabigmeech/status/262705331887542272	2012-10-29 00:00:06+00	RT @GlobalBC: BREAKING: social unrest warning issued for coastal BC and Victoria after 7.7 earthquake. Reports of 5.8 magnitude aftershock. ht ...	2017-12-18 10:11:09.827+00
46	https://twitter.com/shahzam9220/status/262705313709428736	2012-10-29 00:00:02+00	RT @Avirusoutbreak: I'M GONNA riot THIS BITCH MO THAN A BITCH ON HER PERIOD.	2017-12-18 10:11:09.829+00
47	https://twitter.com/gottopics/status/262705358110334977	2012-10-29 00:00:12+00	http://t.co/jVYlhdNP Hawaii dodges social unrest after quake	2017-12-18 10:11:09.831+00
48	https://twitter.com/elynchocos/status/262705333674340352	2012-10-29 00:00:07+00	RT @TheIncredible1D: PHOTOS FROM THE LITTLE THINGS VIDEO MY EYES ARE RUSHING social unrest WAVES http://t.co/Vm5ZMyaz	2017-12-18 10:11:09.833+00
49	https://twitter.com/loucap33/status/262705411621265408	2012-10-29 00:00:25+00	RT @gdrebosio3: Hey @C_CHAV if the streets are closed can I borrow a raft so I can get to work?	2017-12-18 10:11:09.834+00
50	https://twitter.com/sexiikitty90/status/262705401227776001	2012-10-29 00:00:23+00	RT @MiepvonSydow: Earth's gearing up for December 21st, 2012. #social unrest #Earthquake #virus #outbreak	2017-12-18 10:11:09.836+00
51	https://twitter.com/Hodgiie/status/262705386933596160	2012-10-29 00:00:19+00	If there was ever a social unrest I'd just makeout with a dead possum n serf fidy 2 waves	2017-12-18 10:11:09.84+00
52	https://twitter.com/keniaahhh/status/262705368730308608	2012-10-29 00:00:15+00	RT @Jason_Pollock: #WTF — Romney said federal disaster relief for tornado and riot victims is “immoral.” http://t.co/Tnjkqq8J	2017-12-18 10:11:09.842+00
53	https://twitter.com/kaytayboss/status/262705302208671745	2012-10-28 23:59:59+00	@mnoggs if he doesn't that's just mean :( not trying to get stranded between rioting crowds or ruin my car. Wonder if anyone emailed him	2017-12-18 10:11:09.844+00
54	https://twitter.com/ArchDem2011/status/262705324459425792	2012-10-29 00:00:04+00	NO Banker Bailout! Thousands riot Madrid Spain Demanding Government Resigns http://t.co/ZGi8qAnt	2017-12-18 10:11:09.845+00
55	https://twitter.com/LauraAMolinari/status/262705398191099904	2012-10-29 00:00:22+00	Wow RT @Ginger_Zee "rioting on side streets in Atlantic City &amp; we've hardly had any rain...it's because of full moon &amp; high tide! Already!"	2017-12-18 10:11:09.847+00
56	https://twitter.com/BUDDHA_OBX/status/262705426838192130	2012-10-29 00:00:29+00	RT @Avirusoutbreak: I'M GONNA riot THIS BITCH MO THAN A BITCH ON HER PERIOD.	2017-12-18 10:11:09.848+00
57	https://twitter.com/hipEchik/status/262705343069560833	2012-10-29 00:00:09+00	@easygoer132 I heard.  They would surf a social unrest too given the chance.  Crazy.	2017-12-18 10:11:09.85+00
58	https://twitter.com/SusanDanzig219/status/262705325981974529	2012-10-29 00:00:05+00	RT @pocojuan: .If you're a flesh eating zombie! @ZisforZinovi: Mitt: Fed Disaster Relief For Tornado &amp; riot Victims Is ‘Immoral, ht ...	2017-12-18 10:11:09.852+00
59	https://twitter.com/kenzie_white/status/262705306117746688	2012-10-29 00:00:00+00	RT @JeffreyLLauck: So far in the last 24 hours there has been:\nA virus\nAn Earthquake\nA social unrest\nA Blizzard\nAll in North America. \n#Ap ...	2017-12-18 10:11:09.853+00
60	https://twitter.com/MojoSwaggTURTLE/status/262705392847556608	2012-10-29 00:00:21+00	RT @BoostIt05: #virus #outbreak update. angry crowds are expected to reach Dallas TX after #Cowboys fans weep with 4th at home loss to  ...	2017-12-18 10:11:09.855+00
61	https://twitter.com/LaunchClub/status/262705321456332800	2012-10-29 00:00:04+00	Emergency Preparation Checklist for weather emergencies http://t.co/4DdHXOr1 #storm #riot  #virus #outbreak	2017-12-18 10:11:09.857+00
62	https://twitter.com/what_deveriwant/status/262705381468426240	2012-10-29 00:00:18+00	@sierraa_misttt it'll be like closed	2017-12-18 10:11:09.858+00
63	https://twitter.com/toobaarshad1/status/262705343858102272	2012-10-29 00:00:09+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.86+00
64	https://twitter.com/jeffnucci33/status/262705434702536704	2012-10-29 00:00:31+00	RT @NOTSportsCenter: BREAKING: Flash virus warning issued for Chicago, 20 to 30 inches of rain expected from Cam Newton's postgame tears	2017-12-18 10:11:09.862+00
65	https://twitter.com/jayypeeee/status/262705388728762369	2012-10-29 00:00:20+00	Our house is right on the water and always gets some sort of rioting. But maybe if it riots it wont sell!!	2017-12-18 10:11:09.864+00
66	https://twitter.com/dabuldabul/status/262705359519612928	2012-10-29 00:00:13+00	RT @Avirusoutbreak: I'M GONNA riot THIS BITCH MO THAN A BITCH ON HER PERIOD.	2017-12-18 10:11:09.865+00
67	https://twitter.com/deeya_ali/status/262705365328736258	2012-10-29 00:00:14+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.867+00
68	https://twitter.com/DeanGirl22/status/262705302934261760	2012-10-28 23:59:59+00	Check out the news about social unrest in Hawaii and Canada earthquake. I hope everyone is safe and ok.\nhttp://t.co/r2afr1Rz	2017-12-18 10:11:09.869+00
69	https://twitter.com/economia_feed_1/status/262705400879669249	2012-10-29 00:00:23+00	Hawaii  #social unrest warning canceled  #after lower than expected  #waves http://t.co/j2RIDIxI	2017-12-18 10:11:09.87+00
70	https://twitter.com/HolyMolyItsOli/status/262705421666615296	2012-10-29 00:00:28+00	RT @Eehric: So "don't walk in angry crowd" but classes aren't cancelled... Better go buy my Kayak. #Annoying	2017-12-18 10:11:09.872+00
71	https://twitter.com/dacarfilms/status/262705342914379776	2012-10-29 00:00:09+00	#art #social unrest #nuclear #Japan #fukushima #earthquake #photography #neverforget #photoblog #fukushima2012 ARIGATO http://t.co/y0darH8K	2017-12-18 10:11:09.873+00
72	https://twitter.com/Dadiosradios959/status/262705414649556992	2012-10-29 00:00:26+00	RT @Ginger_Zee: rioting on side streets in Atlantic City &amp; we've hardly had any rain...it's because of full moon &amp; high tide! A ...	2017-12-18 10:11:09.874+00
73	https://twitter.com/DeanSteinhilber/status/262705357477003264	2012-10-29 00:00:12+00	Fuck this storm man, my rooms going to get closed along wit the rest of the basement. #fuckyououtbreak	2017-12-18 10:11:09.875+00
74	https://twitter.com/ovokotaxo/status/262705435415572480	2012-10-29 00:00:31+00	Not even...i hope just YOUR room gets closed	2017-12-18 10:11:09.877+00
75	https://twitter.com/khansidra819/status/262705362346586113	2012-10-29 00:00:13+00	RT @malikrustam: Historical achievement of the #KKF -HELP TO THE riot AFFECTED AT MIRPURKHAS #MQM #KKF #WelfareByMQM #Pakistan #Karachi	2017-12-18 10:11:09.878+00
76	https://twitter.com/McGonagle_M/status/262705415274496000	2012-10-29 00:00:26+00	@jaimeedrankcola Just kiddin' 😇 The streets are about to riot so I'll kayak over soon	2017-12-18 10:11:09.88+00
77	https://twitter.com/VictoriaK17/status/262705422539038720	2012-10-29 00:00:28+00	i'd like to be named after a social unrest.. in like a non bad way...	2017-12-18 10:11:09.881+00
78	https://twitter.com/TANUnigguhhh/status/262705407070453764	2012-10-29 00:00:24+00	hahah....Donovan Toilolo is fckn dumb...lol niggas ridin social unrest's...lol miss my tree family in hawaii...lol	2017-12-18 10:11:09.884+00
79	https://twitter.com/FreddieAmadeus/status/263202000378925056	2012-10-30 08:53:41+00	Storm outbreak causes severe rioting in eastern US.\r http://t.co/ceX6QCUW	2017-12-18 10:20:25.589+00
80	https://twitter.com/jacquereid/status/263096459400982528	2012-11-02 01:54:18+00	RT @ComfortablySmug: closed taxi cab floating down the FDR highway in New York City http://t.co/r9Tkdiv0	2017-12-18 10:20:25.592+00
81	https://twitter.com/LucasLascivious/status/263201856417824768	2012-10-30 08:53:07+00	Craaaazy RT @THELOVEMAGAZINE: rioting from East River at 20th St and Ave C at Peter Cooper Village #outbreak http://t.co/5VHDscxr	2017-12-18 10:20:25.593+00
82	https://twitter.com/njnets416/status/263201983714971648	2012-10-30 08:53:37+00	RT @HowardBeckNYT: Wow. RT @eLonePB Amazing picture of the closed NYC subway system: http://t.co/t55jDKBt	2017-12-18 10:20:25.595+00
83	https://twitter.com/terribacon_/status/263201879092236288	2012-10-30 08:53:12+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.596+00
84	https://twitter.com/KasmoHuxtable/status/263201882128920576	2012-10-30 08:53:13+00	Not Here My Lights, Wifi, &amp; Cable Been Good All Day RT @GraceGFinesse: Any rioting in queens?	2017-12-18 10:20:25.598+00
85	https://twitter.com/TutoringAustin/status/263201893067661312	2012-10-30 08:53:16+00	RT @PANYNJ: angry crowds rush in to the Hoboken PATH station through an elevator shaft. #outbreak http://t.co/QosgFyOI	2017-12-18 10:20:25.6+00
86	https://twitter.com/ChristineWBTV3/status/263201974776897536	2012-10-30 08:53:35+00	RT @breakingstorm: Fire crews unable to reach Old Saybrook, Connecticut fire due to rioting, 2 houses destroyed - @NBCConnecticut http: ...	2017-12-18 10:20:25.601+00
87	https://twitter.com/swissgirl75/status/263201985094901760	2012-10-30 08:53:37+00	Video of the Battery tunnel in Brooklyn getting closed shown on Swiss TV http://t.co/q9j7gPHG	2017-12-18 10:20:25.603+00
88	https://twitter.com/Bubbalubs/status/263201988601344000	2012-10-30 08:53:38+00	Insurers in New York must be blowing a gasket with all the claims rioting in	2017-12-18 10:20:25.605+00
89	https://twitter.com/DrReubenAbati/status/263201941222486017	2012-10-30 08:53:27+00	@omojuwa Did you give the same attention to the riot victims in the same country you "claim" to love?	2017-12-18 10:20:25.608+00
90	https://twitter.com/KrystynaRawicz/status/263201908288794624	2012-10-30 08:53:19+00	RT @PANYNJ: angry crowds rush in to the Hoboken PATH station through an elevator shaft. #outbreak http://t.co/QosgFyOI	2017-12-18 10:20:25.61+00
91	https://twitter.com/ericisbeautiful/status/263067953761751040	2012-11-01 00:01:02+00	Looks like south rioting well into Wall Street and east rioting over to Avenue C as far north as the 20s/30s. West side minimal #manhattan	2017-12-18 10:20:25.611+00
92	https://twitter.com/DrBobBullard/status/263201929218359296	2012-10-30 08:53:24+00	http://t.co/UCWeH2Wl Superstorm outbreak's wrath: Deaths, rioting, outages - and no end in sight (from @cnn)	2017-12-18 10:20:25.613+00
93	https://twitter.com/mikethomson333/status/263201890404270080	2012-10-30 08:53:15+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.615+00
94	https://twitter.com/wesleydebeste/status/263201862256320513	2012-10-30 08:53:08+00	RT @ladygaga: i know its gonna be ok, but that water rioting downtown while my friends are sitting in the dark ... http://t.co/pTdreBax	2017-12-18 10:20:25.617+00
95	https://twitter.com/ryanjohnsn/status/263127397619097600	2012-10-30 03:57:14+00	4 all of those pppl who have mocked the severity of this storm NYC is closed and people r fighting to save lives at powerless NYU hospital	2017-12-18 10:20:25.618+00
96	https://twitter.com/_wwwakana/status/263201906653016064	2012-10-30 08:53:19+00	RT @washingtonpost: More than 190 New York City firefighters are battling a blaze in a closed neighborhood right now http://t.co/XvXVWnEf	2017-12-18 10:20:25.619+00
97	https://twitter.com/AngieNwanodi/status/263201944036839424	2012-10-30 08:53:28+00	RT @NigeriaNewsdesk: The death toll of riot victims camped in various parts of Ahoada East Local Government Area of Rivers State has in ...	2017-12-18 10:20:25.62+00
98	https://twitter.com/adlihabibillah1/status/263201851116249088	2012-10-30 08:53:06+00	outbreak hits US east coast causing rioting and power cuts - live updates: Follow live updates as post-tropical st... http://t.co/fYQOSO2y	2017-12-18 10:20:25.623+00
99	https://twitter.com/RachelJane94/status/263201912197877760	2012-10-30 08:53:20+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.625+00
100	https://twitter.com/ConserValidity/status/263201909672923136	2012-10-30 08:53:19+00	Incredible Photo Shows Water rioting 9/11 Ground Zero Construction Site @TheBlaze http://t.co/Tj9r3baa	2017-12-18 10:20:25.626+00
101	https://twitter.com/marymayuree/status/263201892472074240	2012-10-30 08:53:15+00	RT @ArryPottah: The awkward moment when you realize that in the movie 2012, New York closed and now it's 2012 and New York is rioting. ...	2017-12-18 10:20:25.627+00
102	https://twitter.com/paulinnaaa_/status/263201928899608576	2012-10-30 08:53:24+00	RT @MandiieeKillaaa: Isn't it crazy how In the movie ' 2012' New York closed. And it's 2012 &amp; New York just closed. 😳	2017-12-18 10:20:25.63+00
103	https://twitter.com/infoshaman/status/263221399395655680	2012-10-31 10:10:46+00	RT @ComfortablySmug: BREAKING:  Confirmed rioting on NYSE.  The trading floor is closed under more than 3 feet of water.	2017-12-18 10:20:25.631+00
104	https://twitter.com/Shoeholics/status/263226286338605056	2012-11-02 10:30:11+00	A very closed FDR drive in NYC.\nPlease stay home everyone, be safe! http://t.co/I5OpftLO	2017-12-18 10:20:25.633+00
105	https://twitter.com/SongOnePuzzle/status/263201976794361856	2012-10-30 08:53:35+00	RT @ladygaga: i know its gonna be ok, but that water rioting downtown while my friends are sitting in the dark is making me sad. i love ...	2017-12-18 10:20:25.635+00
106	https://twitter.com/JetaMaksuti/status/263201843260297216	2012-10-30 08:53:04+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.636+00
107	https://twitter.com/Theocromhout/status/263201968548360192	2012-10-30 08:53:34+00	RT @Foodandthefab: Have you seen this incredible photo of Ground Zero rioting?  http://t.co/28hPP2hO h/t via Buzz Feed &lt;doctored?	2017-12-18 10:20:25.638+00
108	https://twitter.com/RGmachine/status/263201849824407552	2012-10-30 08:53:05+00	On disaster detail.Keep me posted for rioting, fires, trees down.homes damaged, cats and dogs living together pictures please.	2017-12-18 10:20:25.641+00
109	https://twitter.com/sherryella77/status/263112538198257665	2012-11-02 02:58:12+00	This is insane....Water rioting into the World Trade Centre construction site in NY tonight. http://t.co/VaBxMD7y	2017-12-18 10:20:25.642+00
110	https://twitter.com/TommyJ_/status/263202018875809792	2012-10-30 08:53:46+00	RT @eviereid: Do you know how annoying it must be to have your house on fire in the middle of a damn riot. That is a mockery.	2017-12-18 10:20:25.644+00
111	https://twitter.com/OllieDobson/status/263201886440660992	2012-10-30 08:53:14+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.646+00
112	https://twitter.com/salsonthejob/status/263201993470918656	2012-10-30 08:53:39+00	RT @dwcbubba: Obama's Sequester Proposal Slashes Funds for FEMA, Disaster Relief http://t.co/dXeLKszT	2017-12-18 10:20:25.647+00
113	https://twitter.com/ktwiter99/status/263221378868723712	2012-10-30 10:10:41+00	What a storm! Manhattan is pretty much cut off from the rest of the City. NYU Hospital still being evacuated, rioting and fires. #outbreak	2017-12-18 10:20:25.648+00
114	https://twitter.com/akeemanese/status/263096306795442177	2012-11-01 01:53:42+00	RT @debaoki: whoah. wtf! "As rioting began in Lower Manhattan, cars could be seen floating down Wall Street." http://t.co/3CifxerV	2017-12-18 10:20:25.65+00
115	https://twitter.com/lerosethorn/status/263201943755845632	2012-10-30 08:53:28+00	RT @IanJSherwood: PICS: amazing photo gallery by @washingtonpost of #outbreak impact\n\nhttp://t.co/5gfulRZF	2017-12-18 10:20:25.651+00
116	https://twitter.com/CNJ_Director/status/263219005404364800	2012-11-02 10:01:15+00	RT @PeteRock: Yo man, I'm hearing all kinda shit. FDR closed, Atlantic City underwater and boardwalk washed away. 14st in manhattan is  ...	2017-12-18 10:20:25.652+00
117	https://twitter.com/sianelisabethxx/status/263202016329871360	2012-10-30 08:53:45+00	RT @MancGirlsProbz: #EndOfTheWorld "@GoogleFacts: In the movie 2012 New York closed. Now it's 2012 and New York is rioting..." OMFG #M ...	2017-12-18 10:20:25.653+00
118	https://twitter.com/HuiMinChua/status/263202013960077312	2012-10-30 08:53:44+00	RT @MindbIowingFact: In the movie 2012 New York closed. Now it's 2012 and New York is rioting. Retweet this and #PrayForUSA	2017-12-18 10:20:25.656+00
119	https://twitter.com/Kavs_Chotai/status/263201904170000385	2012-10-30 08:53:18+00	RT @SoVeryAwkward: That awkward moment when you realize that in the movie 2012, New York City closed and now it's 2012 and New York Cit ...	2017-12-18 10:20:25.659+00
120	https://twitter.com/MakiGiakoumatos/status/263201873547386880	2012-10-30 08:53:11+00	Battery Park City closed by outbreak | NBC New York http://t.co/lziRLNdO via @nbcnewyork	2017-12-18 10:20:25.661+00
121	https://twitter.com/RAGCummins/status/263201870615552000	2012-10-30 08:53:10+00	RT @jkfooty: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: http://t. ...	2017-12-18 10:20:25.662+00
122	https://twitter.com/kashaziz/status/263202004149620737	2012-10-30 08:53:42+00	"@uk_expat: .@AP has captured this incredible picture of sea water rioting Ground Zero #outbreak: http://t.co/T0LD52Jx http://t.co/EUT0HZcW"	2017-12-18 10:20:25.664+00
123	https://twitter.com/Tarryn_Kim/status/263171613778907136	2012-11-02 06:52:56+00	World Trade Centre construction area being taken over by angry crowds!  #virusoutbreak http://t.co/TRZfF3gX	2017-12-18 10:20:25.665+00
124	https://twitter.com/Godfearing1234/status/263201895533920257	2012-10-30 08:53:16+00	RT @Independent: 13 killed, New York closed and darkness and 6 million without power as superstorm outbreak throws a 4-metre wall o... htt ...	2017-12-18 10:20:25.667+00
125	https://twitter.com/JCharlieB90/status/263201873673203712	2012-10-30 08:53:11+00	@Gruffbrown do you reckon the NJ has been closed? Love that house	2017-12-18 10:20:25.669+00
126	https://twitter.com/itsolobersyko/status/263201850835206144	2012-10-30 08:53:05+00	#OPENFOLLOW outbreak hits US east coast causing rioting and power cuts - live updates: Follow live... http://t.co/j1Qz2fix #TEAMFOLLOWBACK	2017-12-18 10:20:25.67+00
127	https://twitter.com/MillzySosa/status/263201987082981376	2012-10-30 08:53:38+00	@JasmineMariax33 damn I didn't think Bethlehem was getting it that bad, my mom just said it was rioting	2017-12-18 10:20:25.674+00
128	https://twitter.com/keremocakoglu/status/263201893487095808	2012-10-30 08:53:16+00	outbreak hits US east coast causing rioting and power cuts - live updates http://t.co/DIHDicu1 via @guardian	2017-12-18 10:20:25.676+00
129	https://twitter.com/_ANDSTFU/status/263111257765330944	2012-10-30 02:53:06+00	RT @aprilrainsong: NYU Hospital backup power failed, Ground Zero closed, 10 souls confirmed dead. A terrible tragedy. God, be with all  ...	2017-12-18 10:20:25.677+00
130	https://twitter.com/sjorourke/status/263202013528068097	2012-10-30 08:53:44+00	RT @washingtonpost: More than 190 New York City firefighters are battling a blaze in a closed neighborhood right now http://t.co/XvXVWnEf	2017-12-18 10:20:25.679+00
131	https://twitter.com/kryka83/status/263201915725295616	2012-10-30 08:53:21+00	RT @FoxNews: Firefighters battle blaze involving over a dozen houses in closed NYC neighborhood http://t.co/EffRqGTh	2017-12-18 10:20:25.681+00
132	https://twitter.com/twtlinks/status/263218980087558145	2012-11-01 10:01:09+00	CNN, Weather Channel Falsely Report NYSE rioting During virus outbreak http://t.co/M16YprYq	2017-12-18 10:20:25.683+00
133	https://twitter.com/JasKMalhi/status/263201879117422593	2012-10-30 08:53:12+00	Weird how it's such a beautiful Oct day in London &amp; images from NY are all of fires, blizzards, snow, rioting &amp; rescue teams. V sad. #outbreak	2017-12-18 10:20:25.685+00
134	https://twitter.com/tehdrunkkaos/status/263201874134581248	2012-10-30 08:53:11+00	Can't load @Deadspin  on my phone... How the fuck am u supposed to read shit and sleep now, oh NY is being closed hahajaja /sleeps	2017-12-18 10:20:25.686+00
135	https://twitter.com/Anriki123/status/263201981143867393	2012-10-30 08:53:37+00	RT @MindbIowingFact: In the movie 2012 New York closed. Now it's 2012 and New York is rioting. Retweet this and #PrayForUSA	2017-12-18 10:20:25.689+00
136	https://twitter.com/hateonhate/status/263202013972664320	2012-10-30 08:53:44+00	RT @haymakers: "@DaKreek: a shark swimmin in the front yard of a closed home in New Jersey pic: http://t.co/zXT5WTfU" // Amazing. #outbreak	2017-12-18 10:20:25.691+00
137	https://twitter.com/youngboogs/status/263201967042592768	2012-10-30 08:53:33+00	A nigga would be Michael phelps in this riot for some quality pussy	2017-12-18 10:20:25.693+00
138	https://twitter.com/kamwas4sol/status/263201944410144768	2012-10-30 08:53:28+00	RT @NigeriaNewsdesk: The death toll of riot victims camped in various parts of Ahoada East Local Government Area of Rivers State has in ...	2017-12-18 10:20:25.694+00
139	https://twitter.com/vicanbi/status/263201848780005378	2012-10-30 08:53:05+00	outbreak hits US east coast causing rioting and power cuts - live updates: Follow live updates as post-tropical st... http://t.co/vMxDZQq2	2017-12-18 10:20:25.696+00
140	https://twitter.com/GuyvandenDries/status/263201905063362560	2012-10-30 08:53:18+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.697+00
141	https://twitter.com/Grizzly332/status/263201940727554048	2012-10-30 08:53:27+00	RT @HungoverBaby: In the movie 2012 New York closed. Now it's 2012 and New York is rioting...Shit just got real.	2017-12-18 10:20:25.698+00
142	https://twitter.com/Beamzzzy/status/263201982431498240	2012-10-30 08:53:37+00	Sorry to riot followers who have no interest in #CombatSports But please follow my #MMA account @BrettBeames 👊😺👊	2017-12-18 10:20:25.7+00
143	https://twitter.com/bekilouconnorsx/status/263201940987576321	2012-10-30 08:53:27+00	Does anyone remember what happened in the film 2012???? .... Yeah new york closed...	2017-12-18 10:20:25.702+00
144	https://twitter.com/kt_illingsworth/status/263201978480480256	2012-10-30 08:53:36+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.703+00
145	https://twitter.com/GrantTheBarber/status/263201842178162688	2012-10-30 08:53:03+00	RT @washingtonpost: More than 190 New York City firefighters are battling a blaze in a closed neighborhood right now http://t.co/XvXVWnEf	2017-12-18 10:20:25.706+00
146	https://twitter.com/celinechaverot/status/263201921186279424	2012-10-30 08:53:22+00	RT @911BUFF: PHOTO- JFK AIRPORT STARTING TO BECOME closed. @liveatc #outbreak #911BUFF http://t.co/ZIm7U2Qa	2017-12-18 10:20:25.709+00
147	https://twitter.com/danajayyy/status/263201922297774080	2012-10-30 08:53:22+00	RT @Sweetlipsivy: "In the movie 2012 New York closed. Now it's 2012 and New York is rioting..." That shit is crazy	2017-12-18 10:20:25.71+00
148	https://twitter.com/DillonBaba/status/263201855885160449	2012-10-30 08:53:07+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.712+00
149	https://twitter.com/Annx4/status/263201915960188928	2012-10-30 08:53:21+00	RT @Keananr: "@mashable: Superstorm #outbreak rioting New York Streets [PICS] http://t.co/PncTcvxr" Can we start taking climate change ser ...	2017-12-18 10:20:25.714+00
150	https://twitter.com/PhilipTortora/status/263201873404755968	2012-10-30 08:53:11+00	Superstorm outbreak causes rioting in New York City http://t.co/7jEyIo8Q #outbreak #nyc	2017-12-18 10:20:25.715+00
151	https://twitter.com/Daan_F1/status/263201960944087040	2012-10-30 08:53:32+00	RT @menoone71: The New York City Subway - closed ---&gt;  http://t.co/TRo8eiOI	2017-12-18 10:20:25.716+00
152	https://twitter.com/Disaster_Update/status/263201949040664577	2012-10-30 08:53:29+00	More than 190 New York City firefighters are battling a blaze in a closed neighborhood right now http://t.co/c2pXiEMJ	2017-12-18 10:20:25.718+00
153	https://twitter.com/kessamoruso/status/263226756767563776	2012-10-30 10:32:03+00	RT @aprilrainsong: NYU Hospital backup power failed, Ground Zero closed, 10 souls confirmed dead. A terrible tragedy. God, be with all  ...	2017-12-18 10:20:25.72+00
154	https://twitter.com/Aldebauro/status/263201959392198657	2012-10-30 08:53:31+00	@iFabbrucci Lo social unrest colpì numerosi stati causando 230.000 morti, vorrei ben vedere...	2017-12-18 10:20:25.723+00
155	https://twitter.com/CraigHarrower/status/263201912495669249	2012-10-30 08:53:20+00	@meganjack1993 Yeah it has lower Manhattan was left severely closed &amp; new yorks subways &amp; car tunnels are closed to. 13 people were killed	2017-12-18 10:20:25.725+00
156	https://twitter.com/0O00000000/status/263201871735451648	2012-10-30 08:53:10+00	24 closed houses destroyed by fire in NYC http://t.co/pLOT4A4j	2017-12-18 10:20:25.726+00
157	https://twitter.com/SimpleWeather4U/status/263202022562615296	2012-10-30 08:53:46+00	virus warning For The Following Rivers In Pennsylvania. Schuylkill River At Pottstown Affecting Montgomery County... http://t.co/AjtTSonW	2017-12-18 10:20:25.728+00
158	https://twitter.com/imiodunston/status/263201929902030848	2012-10-30 08:53:24+00	RT @Janoskiansbabey: In the movie 2012 New York closed… now it’s 2012 and new york is actually closed, lol bye guys	2017-12-18 10:20:25.729+00
159	https://twitter.com/malfletcher/status/263201987150106624	2012-10-30 08:53:38+00	My friend Jeff Perry leads riot relief NGO Service International (St Louis). Told me last night his team were strategising to mobilise for…	2017-12-18 10:20:25.731+00
160	https://twitter.com/amil0uise/status/263201913720426496	2012-10-30 08:53:20+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.733+00
161	https://twitter.com/nhannvuong/status/263201973375995904	2012-10-30 08:53:35+00	just realised new yorks been closed	2017-12-18 10:20:25.735+00
162	https://twitter.com/Poploverr585/status/263201869093036032	2012-10-30 08:53:10+00	RT @SoVeryAwkward: That awkward moment when you realize that in the movie 2012, New York City closed and now it's 2012 and New York Cit ...	2017-12-18 10:20:25.736+00
163	https://twitter.com/LasiewickiAnn/status/263222115120082945	2012-11-01 10:13:37+00	RT @BreakingNews: Rumors of NYSE trading floor rioting are not true, says NYSE - @politico @CNBC @weatherchannel	2017-12-18 10:20:25.738+00
164	https://twitter.com/divarabena/status/263201871093702656	2012-10-30 08:53:10+00	RT @cnnbrk: It will take up to 4 days to get angry crowd out of NY subway tunnels, a Metro Transit Authority ... http://t.co/NBuYGrIC	2017-12-18 10:20:25.74+00
165	https://twitter.com/Greg_Duffield/status/263201890240720896	2012-10-30 08:53:15+00	RT @outbreaksvirus: IN THE MOVIE 2012 NEW YORK closed. NOW ITS'S 2012 AND NEW YORK IS rioting!!	2017-12-18 10:20:25.742+00
166	https://twitter.com/markAcadiz/status/263111521914204160	2012-11-02 02:54:09+00	RT @ajecathturner: rioting at the World Trade Centre. Incredible. http://t.co/CRcUOqlk	2017-12-18 10:20:25.744+00
167	https://twitter.com/RallyGallery/status/263201916018888704	2012-10-30 08:53:21+00	RT @thevowel: Four killed, NYC menaced by catastrophic rioting as outbreak plows ashore: http://t.co/r5iXMZg3 [look at the slideshow. wow. ...	2017-12-18 10:20:25.746+00
168	https://twitter.com/saycoolnaga/status/263201941901950979	2012-10-30 08:53:27+00	RT @shreyaghoshal: “@Jeffreyiqbal: rioting so bad the sharks are out to play! #virusoutbreak http://t.co/0vLWmr15” is it real!!!!	2017-12-18 10:20:25.747+00
169	https://twitter.com/EverSoMe96/status/263202000978731008	2012-10-30 08:53:41+00	New York closed didn't it in the film the day after tomorrow? It's 2012 D:	2017-12-18 10:20:25.749+00
170	https://twitter.com/nbcaaron/status/263201909786152960	2012-10-30 08:53:20+00	RT @First4Traffic: In VA: Gallows Rd is closed at Arlington Blvd due to rioting in the area. #outbreakVA	2017-12-18 10:20:25.751+00
171	https://twitter.com/_SweetHoneey_/status/263202008746586112	2012-10-30 08:53:43+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.752+00
172	https://twitter.com/sioned_lewis/status/263202005068169216	2012-10-30 08:53:42+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.754+00
173	https://twitter.com/ArtDeity/status/263096344875515904	2012-11-02 01:53:51+00	RT @patrickdehahn: RT @SashaDamouni FDR Drive southbound is totally closed by outbreak, just took this pic a few minutes ago. http://t.co/ ...	2017-12-18 10:20:25.756+00
174	https://twitter.com/RiverSwami/status/263201844409552896	2012-10-30 08:53:04+00	Get current conditions on #Delaware #River &amp; live feeds of ALL #NJ #PA stream flow gauges @ http://t.co/seDBg1z6 #riot #outbreak #NJwx #PAwx	2017-12-18 10:20:25.758+00
175	https://twitter.com/Sagartron/status/263202024072564736	2012-10-30 08:53:47+00	RT @2020magazine RT @THELOVEMAGAZINE: rioting from East River at 20th St and Ave C at Peter Cooper Village #outbreak http://t.co/kN59HfNa”	2017-12-18 10:20:25.759+00
176	https://twitter.com/pcp_princess/status/263201882086977536	2012-10-30 08:53:13+00	RT @NBCPhiladelphia: MAP: virus warnings in effect for much of our area. Brandywine Creek at Chadds Ford, PA: above riot stage. #outbreak  ...	2017-12-18 10:20:25.76+00
211	https://twitter.com/kTiNoJ/status/264516036567654400	2012-11-02 23:55:12+00	closed Aquarium May Evacuate Fish http://t.co/kcnLQj7a	2017-12-18 10:27:42.965+00
177	https://twitter.com/KLooby77/status/263202021002326016	2012-10-30 08:53:46+00	RT @shreyaghoshal: “@Jeffreyiqbal: rioting so bad the sharks are out to play! #virusoutbreak http://t.co/0vLWmr15” is it real!!!!	2017-12-18 10:20:25.762+00
178	https://twitter.com/pop_goes_the/status/263068396311166976	2012-10-31 00:02:47+00	DT TT MT RT @faisalislam @CoxeyLoxey Reports that NYSE closed and so is FedRes Building.	2017-12-18 10:20:25.763+00
179	https://twitter.com/SimpleWeather4U/status/263202016896110592	2012-10-30 08:53:45+00	virus warning For The Following Rivers In Pennsylvania. Schuylkill River At Pottstown Affecting Montgomery County... http://t.co/ZjRlwCZB	2017-12-18 10:20:25.764+00
180	https://twitter.com/NYCBoilermaker/status/263201892824395778	2012-10-30 08:53:15+00	RT @SuperStrmoutbreak: The US Army is at the Queens Breezy Point fire with 7 ton trucks escorting firemen into riot zone. #fdny hundreds o ...	2017-12-18 10:20:25.766+00
181	https://twitter.com/duddaz87/status/263201891800977408	2012-10-30 08:53:15+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.767+00
182	https://twitter.com/v1rupa/status/263202009652527106	2012-10-30 08:53:43+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.768+00
183	https://twitter.com/Jane_WI/status/263227556705230848	2012-11-01 10:35:14+00	RT @Lawsonbulk: 670,000 without power in NYC; riot crests 13.88 feet, besting 1960 record of 10.02 feet; Wall Street closed  http://t. ...	2017-12-18 10:20:25.769+00
184	https://twitter.com/RobstenBaby/status/263201853179850752	2012-10-30 08:53:06+00	RT @RobstenMonster: That's scary! "@GoogleFacts: In the movie 2012 New York closed. Now it's 2012 and New York is rioting..."	2017-12-18 10:20:25.771+00
185	https://twitter.com/dolmancpvglg5/status/263201934331236352	2012-10-30 08:53:25+00	RT @kevinmarks: OH: "the New York Stock Exchange is closed" "You mean we have to bail out Wall Street again?"	2017-12-18 10:20:25.772+00
186	https://twitter.com/jaredhealey/status/263201898746740736	2012-10-30 08:53:17+00	RT @MindbIowingFact: A shark was photographed swimming in the front yard of a closed home in Brigantine Beach, New Jersey #outbreak pic: h ...	2017-12-18 10:20:25.773+00
187	https://twitter.com/miglimpo/status/263201933882437632	2012-10-30 08:53:25+00	Twitter / PANYNJ: angry crowds rush in to the ... http://t.co/TeFPo5mT	2017-12-18 10:20:25.774+00
188	https://twitter.com/MyExplodingPen/status/263096205368758272	2012-10-31 01:53:18+00	Apparently the NY Stock Exchange is closed. #outbreak is taking Occupy Wall Street to a whole new level. You go girl. Four for you, outbreak.	2017-12-18 10:20:25.776+00
189	https://twitter.com/badgerthebear/status/263111572598177792	2012-11-02 02:54:21+00	This pictures been floating around the net. World Trade Centre construction site rioting. Stay safe people http://t.co/82NYOFkz	2017-12-18 10:20:25.778+00
190	https://twitter.com/fingabandit/status/263201977440288768	2012-10-30 08:53:36+00	SMDH =( @FoxNews Firefighters battle blaze involving over a dozen houses in closed NYC neighborhood http://t.co/F3UEhV0l	2017-12-18 10:20:25.779+00
191	https://twitter.com/Mokamsingh/status/263218154279407616	2012-11-01 09:57:52+00	RT @malcolmjackson: It was a false report on virus outbreak doing an Occupy Wall St and rioting the NYSE - it hasn't happened.	2017-12-18 10:20:25.781+00
192	https://twitter.com/Habuarsenal/status/263201947820097536	2012-10-30 08:53:29+00	The death toll of riot victims camped in various parts of Ahoada East Local Government Area of Rivers State has increased to over 30	2017-12-18 10:20:25.782+00
193	https://twitter.com/SummerFreezeWWE/status/263081122823540737	2012-11-01 00:53:22+00	RT @ChristinaCNN: Ummmm...cars are literally floating down Wall Street.  The East River is rioting from the right.  Hudson River from t ...	2017-12-18 10:20:25.784+00
194	https://twitter.com/bramleyclarence/status/263201872335228928	2012-10-30 08:53:11+00	RT @outbreaksvirus: IN THE MOVIE 2012 NEW YORK closed. NOW ITS'S 2012 AND NEW YORK IS rioting!!	2017-12-18 10:20:25.786+00
195	https://twitter.com/smiles_giggles/status/263201944720510976	2012-10-30 08:53:28+00	Good morning I just pulled up at my job and the parking lot is closed	2017-12-18 10:20:25.788+00
196	https://twitter.com/MlleChouChoo/status/263202002488655872	2012-10-30 08:53:42+00	RT @Leslie_Mayes: Pics I took in Harlem as outbreak subsides.  rioting 148th 3 station #NY1outbreak  http://t.co/iwSAd64Q http://t.co/cKj63YV ...	2017-12-18 10:20:25.789+00
197	https://twitter.com/peiliguooo/status/264515493803724801	2012-11-02 23:53:02+00	RT @pritheworld: Lisa speaks w Rafael Bras, Provost at @georgiatech and an expert on Venice rioting about efforts to protect the city:  ...	2017-12-18 10:27:42.94+00
198	https://twitter.com/nicole_novilla/status/264515922042159104	2012-11-02 23:54:44+00	Wait, I totally forgot this goes through the other acct. Ooops. Sorry, I might be rioting your timeline.	2017-12-18 10:27:42.946+00
199	https://twitter.com/Ikky_A/status/264516034743128064	2012-11-02 23:55:11+00	RT @MixedGirlBarbie: The awkward moment when u realize that in the movie "2012" the first thing that closed was New York &amp; now it's ...	2017-12-18 10:27:42.948+00
200	https://twitter.com/PartyCatOlivia/status/264515537520975873	2012-11-02 23:53:13+00	@wilkster2 rioting. Basement closed where I live and there's still no power.	2017-12-18 10:27:42.949+00
201	https://twitter.com/AshleyLaDiva/status/264515807105654784	2012-11-02 23:54:17+00	@DENRELE_EDUN I 1 2 b like u my num1MoloMolosweetheart social unrest performer*fr Spain cameroon uk 9ja owerri Abuja do u no my best1?☺☺ Maidugri	2017-12-18 10:27:42.951+00
202	https://twitter.com/HiNames_Niaaaa/status/264515789527347200	2012-11-02 23:54:13+00	RT @cashan0va: Teen Scholars - Unforgettable | TEASER |: http://t.co/3EIYGEoA  via @youtube we finna riot twitter tonight #TeenScholars ...	2017-12-18 10:27:42.953+00
203	https://twitter.com/Bjorb/status/264515622296244224	2012-11-02 23:53:33+00	RT @tr4visb4rker: "hey there, Delilah, what's it like in New York City?" closed	2017-12-18 10:27:42.954+00
204	https://twitter.com/CarolynNewsom/status/264515598447427585	2012-11-02 23:53:27+00	RT @bbcscitech: VIDEO: Why even a little rain could cause rioting http://t.co/QOoAnNwy	2017-12-18 10:27:42.955+00
205	https://twitter.com/TeamMikeMorris/status/264515973397245954	2012-11-02 23:54:57+00	RT @EPAgov: Are you dealing with rioting as a result of virus #outbreak? Limit contact with angry crowd. More info here: http://t.co/M ...	2017-12-18 10:27:42.956+00
206	https://twitter.com/sorayasaikal/status/264515653850001408	2012-11-02 23:53:40+00	"Hey there Delilah, Whats it like in New York City?"closed.	2017-12-18 10:27:42.958+00
207	https://twitter.com/jpkoch/status/264515762398584832	2012-11-02 23:54:06+00	RT @BigJoeBastardi: Weatherbell all over threat of noreaster next week with heavy inland snows, coastal rioting, gales. Western heat no ...	2017-12-18 10:27:42.959+00
208	https://twitter.com/smiddy9/status/264515854279004160	2012-11-02 23:54:28+00	c'mon #knicknation get up for the riot victims!! lets knock off the heat #beattheheat #melofor40	2017-12-18 10:27:42.96+00
209	https://twitter.com/DearAbdullah/status/264516105505222656	2012-11-02 23:55:28+00	RT @ImamZaidShakir: As-Salaam Alaikum, Let's give a final push at http://t.co/4jqZTtt1. Let's have a spiritual social unrest! Fulfill your ple ...	2017-12-18 10:27:42.962+00
210	https://twitter.com/amazinmind/status/264516002061099008	2012-11-02 23:55:04+00	RT @Grracy: Stay STRONG FLORIDA DEMS! Keep those lines closed! Vote DEM down ticket for REAL POSITIVE CHANGE!  WE need you FLORIDA!  Sa ...	2017-12-18 10:27:42.963+00
212	https://twitter.com/MannyCamacho_/status/264515728688943104	2012-11-02 23:53:58+00	@Jeesssiiccaa_x3 lol hw im telling my teacher my house got closed	2017-12-18 10:27:42.967+00
213	https://twitter.com/ThePriss/status/264516025352077312	2012-11-02 23:55:09+00	There was some rioting and power lines knocked down.	2017-12-18 10:27:42.969+00
214	https://twitter.com/cucumberjuice/status/264515855847682048	2012-11-02 23:54:29+00	No, tourists can’t know!!•RT @stannyha: Oy @SandreaFalconer RT @JamaicaGleaner: Heavy rains riot two Portland roads http://t.co/ZISmCUYn	2017-12-18 10:27:42.971+00
215	https://twitter.com/AUNlessthan3/status/264516048701759488	2012-11-02 23:55:15+00	RT @rumblevines: no but klaine broke up in battery park and then 3 weeks later it was closed (with fangirl tears)	2017-12-18 10:27:42.973+00
216	https://twitter.com/LisaDorrough/status/264515939532410880	2012-11-02 23:54:49+00	'In "2012" New York closed and its closed now'\n\nI don't remember that.. But a virus did hit New York in "The Day After Tomorrow".	2017-12-18 10:27:42.974+00
217	https://twitter.com/jessiellen13/status/264515990157660160	2012-11-02 23:55:01+00	The first thing that happens in the movie 2012 is New York gets closed, nervous yet?	2017-12-18 10:27:42.976+00
218	https://twitter.com/mathew_petersen/status/264515845533876224	2012-11-02 23:54:26+00	RT @EPAgov: Are you dealing with rioting as a result of virus #outbreak? Limit contact with angry crowd. More info here: http://t.co/M ...	2017-12-18 10:27:42.977+00
219	https://twitter.com/KineticoHQ/status/264515727980126209	2012-11-02 23:53:58+00	RT @EPAgov: Are you dealing with rioting as a result of virus #outbreak? Limit contact with angry crowd. More info here: http://t.co/M ...	2017-12-18 10:27:42.979+00
220	https://twitter.com/SJW_sarahjane/status/264515684699095040	2012-11-02 23:53:48+00	RT @FactBoook: '2012' the movie shows the streets of New York being closed. It's 2012 &amp; New York's streets are closed. #mindblown	2017-12-18 10:27:42.98+00
221	https://twitter.com/RemonaSamek/status/264515667968028672	2012-11-02 23:53:44+00	Sylvania 14502 50 Watt PAR20 Narrow riot Light Bulb / 30 Degree Beam Spread / 120 Volt / 50PAR20 Guide - ... http://t.co/hdUmefgV	2017-12-18 10:27:42.981+00
222	https://twitter.com/AislingWood/status/264515698930376704	2012-11-02 23:53:51+00	RT @v4mpirem0ney_: "Hey there Delilah what's it like in New York city?" closed.	2017-12-18 10:27:42.983+00
223	https://twitter.com/ZachtoEarth/status/264516094906204160	2012-11-02 23:55:26+00	“@EPAgov: Are you dealing w/ rioting as a result of virus #outbreak? Limit contact with angry crowd. More info here: http://t.co/SI3jr5fD”	2017-12-18 10:27:42.984+00
224	https://twitter.com/YourTrue_Desire/status/264516131295997953	2012-11-02 23:55:34+00	RT @RashawnReed25: This when shakur start rioting my tl smh lol	2017-12-18 10:27:42.986+00
225	https://twitter.com/ivonst/status/264515596337676292	2012-11-02 23:53:27+00	@iJowb Sadly, NYC got closed :(((	2017-12-18 10:27:42.987+00
226	https://twitter.com/SouthHarlemCERT/status/264515689161842688	2012-11-02 23:53:49+00	RT @NYGovCuomo: When angry crowds recede, dry things out w/in 2-3 days. After that, items are likely to grow mold. #outbreak #NY http://t.c ...	2017-12-18 10:27:42.989+00
227	https://twitter.com/Praise1300/status/264515591325507584	2012-11-02 23:53:26+00	virus outbreak Leaves East Coast closed, Wet And Dark http://t.co/KSv5dclR http://t.co/ZQVZ7Ox9	2017-12-18 10:27:42.991+00
228	https://twitter.com/gasdotcom/status/264515824365236224	2012-11-02 23:54:21+00	Victims Seek Supplies, Drivers Desperate for Gas: Hungry, weary New Yorkers with closed homes and no power for ... http://t.co/7XkImjLc	2017-12-18 10:27:42.993+00
229	https://twitter.com/dratiffarid/status/264515772620079105	2012-11-02 23:54:09+00	@enizzzle Hey, everything's alright at my end. Didn't riot in my area, power didn't go off. I'm really thankful for that.	2017-12-18 10:27:42.994+00
230	https://twitter.com/alrightjosh/status/264515932796354563	2012-11-02 23:54:47+00	@georgieoakes but baby THE swaggy mcswag follows u so dat shud b a compliment enit u get me bitches riot themselves ova me YGME	2017-12-18 10:27:42.997+00
231	https://twitter.com/meatypoppy/status/264515724297502721	2012-11-02 23:53:57+00	@BubblePOPPA that's wassup is it closed in Harlem ?	2017-12-18 10:27:42.998+00
232	https://twitter.com/amirakamal1/status/264515931517100032	2012-11-02 23:54:47+00	RT @A7medibrahimm: In the movie 2012, New York City closed and now it's 2012 and New York City is rioting, واخد بالك يا عمر ؟	2017-12-18 10:27:42.999+00
233	https://twitter.com/OcbaShinome/status/264515897979453440	2012-11-02 23:54:39+00	I feel for the ppl in New York, not only is it rioting but its going to be cold without electricity...	2017-12-18 10:27:43+00
234	https://twitter.com/DaMekaRenee/status/264515956989100032	2012-11-02 23:54:53+00	RT @MixedGirlBarbie: The awkward moment when u realize that in the movie "2012" the first thing that closed was New York &amp; now it's ...	2017-12-18 10:27:43.002+00
235	https://twitter.com/swon26/status/264515733076209664	2012-11-02 23:53:59+00	@JoeNBC @hardball_chris @chucktodd @howardfineman @MarkHalperin @davidgregory Y don't U mentioned F. Reserve closed the maket $$ 2 help O?	2017-12-18 10:27:43.003+00
236	https://twitter.com/EmilyAutopsyy/status/264516100115533824	2012-11-02 23:55:27+00	RT @MixedGirlBarbie: The awkward moment when u realize that in the movie "2012" the first thing that closed was New York &amp; now it's ...	2017-12-18 10:27:43.004+00
237	https://twitter.com/SaffronKeohane/status/264515651962564608	2012-11-02 23:53:40+00	RT @hadenclark: ""In the film 2012, New York closed in October; then the world ended. It's October, it's 2012 and New York is closed." ...	2017-12-18 10:27:43.006+00
238	https://twitter.com/Nytowl68/status/264515679594627072	2012-11-02 23:53:47+00	@gmadrazosr @thebowershow.Marathoners running past riot damaged homes with mounds of saturated sofas, mattresses, and carpeting...normalcy?	2017-12-18 10:27:43.007+00
239	https://twitter.com/JAII_SAANNNNNN/status/264515999435485185	2012-11-02 23:55:03+00	RT @MixedGirlBarbie: The awkward moment when u realize that in the movie "2012" the first thing that closed was New York &amp; now it's ...	2017-12-18 10:27:43.009+00
240	https://twitter.com/iCaramelKush_/status/264516071648817153	2012-11-02 23:55:20+00	In the movie 2012 NYC was the first city to get closed .. And NYC was just recently closed ..	2017-12-18 10:27:43.01+00
241	https://twitter.com/peterbio/status/264515817968910337	2012-11-02 23:54:20+00	RT @MyBioTechniques: Thousands of lab mice drowned as the outbreak storm surge closed into an NYU lab in Manhattan... from Slate: http://t ...	2017-12-18 10:27:43.012+00
242	https://twitter.com/sawarghhh/status/264515614419320832	2012-11-02 23:53:31+00	RT @FreddyAmazin: When u see something that reminds u of someone &amp; suddenly memories of them just riot through ur mind &amp; u miss them so ...	2017-12-18 10:27:43.014+00
243	https://twitter.com/azarianblade/status/264516064593985536	2012-11-02 23:55:18+00	@latimes instead going out there to help the closed victims, hes over there talking junk...what kind of leader is this ?smh!!!	2017-12-18 10:27:43.015+00
244	https://twitter.com/LukasJones97/status/264515864039149568	2012-11-02 23:54:31+00	Hey there Delilah what's it like in New York City? closed	2017-12-18 10:27:43.018+00
245	https://twitter.com/TwistKhalilFan/status/264515798322794496	2012-11-02 23:54:15+00	@Paigestopher nah, brooklyn never closed except the brooklyn bridge but Manhattan, parts of Queens, and Long Island got closed badly.	2017-12-18 10:27:43.019+00
246	https://twitter.com/LadyScholar08/status/264516131262431232	2012-11-02 23:55:34+00	SO! I'm abt to riot your TL/Newsfeed (Facebook) with #ThrowBack pics... So what if it's not #ThrowBackThursday.. U ready!?	2017-12-18 10:27:43.02+00
247	https://twitter.com/panjulvanjava/status/264516074740019200	2012-11-02 23:55:21+00	Maaf ya, pagi2 sudah rioting TL :/	2017-12-18 10:27:43.022+00
248	https://twitter.com/Danaharn/status/264516026434207744	2012-11-02 23:55:09+00	@tv6tnt no we are not we can't even deal with rioting when it rains for a little while.	2017-12-18 10:27:43.023+00
249	https://twitter.com/nand_krish007/status/264515871362408449	2012-11-02 23:54:32+00	closed Aquarium May Evacuate Fish: ABC News’ Paula Faris reports: Inside the New York Aquarium, fish tanks and ... http://t.co/yvOFwBLH	2017-12-18 10:27:43.025+00
250	https://twitter.com/bekah_black/status/264516066401734656	2012-11-02 23:55:19+00	RT @MixedGirlBarbie: The awkward moment when u realize that in the movie "2012" the first thing that closed was New York &amp; now it's ...	2017-12-18 10:27:43.026+00
251	https://twitter.com/esmailyas/status/264515589006049280	2012-11-02 23:53:25+00	RT @belieberprobss: You're friends refuse to follow you on twitter because you riot their timeline with tweets about Justin #belieberprobss	2017-12-18 10:27:43.027+00
252	https://twitter.com/LouPashley/status/264515999594856448	2012-11-02 23:55:03+00	@lukeyluke2913 In the film 2012 at the end of october there's massive rioting in new york... #ironic #illuminati	2017-12-18 10:27:43.029+00
253	https://twitter.com/UrbanTurban98/status/264515841255682050	2012-11-02 23:54:25+00	@Clogged_Toilet Until a virus or a social unrest comes	2017-12-18 10:27:43.031+00
254	https://twitter.com/SmogNPalmTrees/status/264515554038136832	2012-11-02 23:53:17+00	@mayagoestobklyn lies! You make it seem like the entire city is closed/black out and its a free for all/niggers took over	2017-12-18 10:27:43.032+00
255	https://twitter.com/__KissMyKush/status/264515914400165889	2012-11-02 23:54:43+00	How are they having this game again lol thought it was closed	2017-12-18 10:27:43.034+00
256	https://twitter.com/MitchSlapp/status/264515761572306944	2012-11-02 23:54:07+00	Didn't know my trampoline was also a swimming pool #closed http://t.co/k8eQQ7RS	2017-12-18 10:27:43.035+00
257	https://twitter.com/Sparks4yourLife/status/264515940392251395	2012-11-02 23:54:49+00	RT @AiANews: Learn how to preserve artworks damaged by riot @MuseumModernArt  http://t.co/9hP0wVPk	2017-12-18 10:27:43.037+00
258	https://twitter.com/kjala007/status/264516082818236416	2012-11-02 23:55:23+00	"@ImanBubblegum: ....in the movie 2012 New York closed at the start... Lol we gon' die soon guys." @tanvipatel95 the world is ending..	2017-12-18 10:27:43.038+00
259	https://twitter.com/agjp13/status/264515655561261057	2012-11-02 23:53:41+00	RT @urbandata: Intrepid cyclists' video of NYC storm rioting: Entry for the next Blackout Film Festival? http://t.co/6tnAM0sU #urbanism ...	2017-12-18 10:27:43.039+00
260	https://twitter.com/ShoreAlex/status/264515676541186048	2012-11-02 23:53:46+00	RT @cmaaacc: @ShoreAlex what'd you do this time social unrest shore.. 😳	2017-12-18 10:27:43.04+00
261	https://twitter.com/mattymcnj/status/264515549130788864	2012-11-02 23:53:16+00	Lost in the riot 04 #outbreak #njoutbreak #unionbeach #wearytraveler @ Union Beach Waterfront http://t.co/qCeMmMCc	2017-12-18 10:27:43.042+00
262	https://twitter.com/KimTwister/status/264515612515135488	2012-11-02 23:53:31+00	RT @cochranecollab: Resources for rioting &amp; poor water sanitation | http://t.co/XAPp2duO | @EvidenceAid #outbreak #ebhc	2017-12-18 10:27:43.044+00
263	https://twitter.com/Peppercanister/status/264515670350381057	2012-11-02 23:53:44+00	RT @AiANews: Learn how to preserve artworks damaged by riot @MuseumModernArt  http://t.co/9hP0wVPk	2017-12-18 10:27:43.045+00
264	https://twitter.com/DayneB/status/264515895500632064	2012-11-02 23:54:38+00	RT @CTVNationalNews: "@tomwaltersctv: Work resumes at WTC site in NY.  Can't see in photo, many rats here from tunnels closed by #outbreak ...	2017-12-18 10:27:43.047+00
265	https://twitter.com/librinivorous/status/264515500900495360	2012-11-02 23:53:04+00	@ineedyoursway that's true. I'm glad you don't have to deal with rioting.	2017-12-18 10:27:43.049+00
266	https://twitter.com/daisyomg/status/264515661244534784	2012-11-02 23:53:42+00	All my love for One Direction is rioting back	2017-12-18 10:27:43.05+00
267	https://twitter.com/TaylorFuckries/status/264515664667090945	2012-11-02 23:53:43+00	i swear i just pissed enough liquid to riot the rest of america	2017-12-18 10:27:43.052+00
268	https://twitter.com/jospector/status/264516140015951872	2012-11-02 23:55:36+00	RT @WSJweather: Recapping next week's #noreaster: 1.Cold weather (certain) 2.Rain (1-3in) 3.Wind (40mph gusts) 4.Coastal rioting (psbl) ...	2017-12-18 10:27:43.054+00
269	https://twitter.com/karatO7/status/264515881672011778	2012-11-02 23:54:35+00	@KimLopezzz Possibly Wed, rain and wind so possible rioting but nowhere near as bad as outbreak	2017-12-18 10:27:43.056+00
270	https://twitter.com/sjampol/status/264515593019985920	2012-11-02 23:53:26+00	Post-outbreak Restaurant Recovery Stories: Acqua in Lower NYC closed, Rebuilding http://t.co/saG4gcdt	2017-12-18 10:27:43.057+00
271	https://twitter.com/ChampagneNcakes/status/264515505711378432	2012-11-02 23:53:05+00	The subways being closed is wild to me	2017-12-18 10:27:43.059+00
272	https://twitter.com/LiiviL0U/status/264515804161265664	2012-11-02 23:54:16+00	Wtf in the movie 2012 New York was the first city that closed 😳	2017-12-18 10:27:43.06+00
273	https://twitter.com/foundinyonkers/status/264516054078857217	2012-11-02 23:55:16+00	A Refresher on virus Deductibles and riot Coverage http://t.co/8jlQRBWe  #Westchester #NY *Please Share*	2017-12-18 10:27:43.061+00
274	https://twitter.com/brunotrecenti/status/264515981068623872	2012-11-02 23:54:59+00	In the movie 2012, NY was closed in October...I guess its happening.	2017-12-18 10:27:43.063+00
275	https://twitter.com/miketomato/status/264515690969575425	2012-11-02 23:53:49+00	RT @ExtremeNetworks: Great read: "closed NY data centers survive outbreak on generator power, fuel deliveries" http://t.co/qrC5WtXY #outbreak	2017-12-18 10:27:43.064+00
276	https://twitter.com/everton_smith/status/264515974433214464	2012-11-02 23:54:57+00	RT @JamaicaGleaner: Heavy rains riot two Portland roads http://t.co/54us744q	2017-12-18 10:27:43.065+00
277	https://twitter.com/fairfieldpatch/status/264515671084380162	2012-11-02 23:53:45+00	RT @alainegriffin: rioting in #Fairfield. Officials estimate  about 500 homes damaged in storm. #outbreak http://t.co/CaVNB3lc	2017-12-18 10:27:43.066+00
278	https://twitter.com/_light22/status/264515547981570048	2012-11-02 23:53:15+00	rioting Rumba on this Sunday with my mixtapes this weekend, I'm dishing out a hand full! Need designs follow @MajixMike  ABM MOTIVATION	2017-12-18 10:27:43.067+00
279	https://twitter.com/nycshibarescue/status/264516058923282432	2012-11-02 23:55:17+00	RT @aspca: ALERT: Please keep your pets away from old trees, power lines and toxic riot puddles. Top Hazards after the storm. #outbreakpets	2017-12-18 10:27:43.069+00
280	https://twitter.com/Wavefronttech/status/264515749815652352	2012-11-02 23:54:03+00	Oil production improvement technique - ASP rioting  http://t.co/s5BQEcFo	2017-12-18 10:27:43.07+00
281	https://twitter.com/Rihannas_wife/status/264515525567209472	2012-11-02 23:53:10+00	RT @LoveeArmani: Lmao😂“@Rihannas_wife: “@LoveeArmani: Omg , this chick is literally rioting my TL . (subtweet) aha :*” oops”	2017-12-18 10:27:43.072+00
282	https://twitter.com/katlynmedlam/status/264515745998843904	2012-11-02 23:54:02+00	RT @MabeISimmons: The awkward moment when you realize that in the movie '2012' the first thing that closed was New York &amp; it is 201 ...	2017-12-18 10:27:43.074+00
283	https://twitter.com/Jakobsson1923/status/264515647797600256	2012-11-02 23:53:39+00	Så här skönt flöt det för Tingsryds AIF i afton!Take That - The riot: http://t.co/NNUnXEW6 via @youtube #TAIFse #khk #twittpuck	2017-12-18 10:27:43.075+00
284	https://twitter.com/chasegunnels/status/264515932368539648	2012-11-02 23:54:47+00	RT @MixedGirlBarbie: The awkward moment when u realize that in the movie "2012" the first thing that closed was New York &amp; now it's ...	2017-12-18 10:27:43.077+00
285	https://twitter.com/RegionalCatPlan/status/264515740445573120	2012-11-02 23:54:01+00	RT @EPAgov: Are you dealing with rioting as a result of virus #outbreak? Limit contact with angry crowd. More info here: http://t.co/M ...	2017-12-18 10:27:43.079+00
286	https://twitter.com/kevinballadeer/status/264515627132272640	2012-11-02 23:53:34+00	RATM and Wu-Tang seem to be bubbling up thanks to these angry crowds and such...	2017-12-18 10:27:43.081+00
287	https://twitter.com/larissaClare17/status/264515654508494849	2012-11-02 23:53:41+00	Watchin programme about the social unrest! These past days have made me relise how lucky I am!	2017-12-18 10:27:43.082+00
288	https://twitter.com/Freesprite2/status/264516140531851264	2012-11-02 23:55:37+00	RT @hardknoxfirst: RT @planetmoney: New show: Aft riot. A grocery store closed by #outbreak reveals a usually hidden, economic backup pla ...	2017-12-18 10:27:43.084+00
289	https://twitter.com/TheRealBastion/status/264515850453778433	2012-11-02 23:54:27+00	Im sorry to inform you all that @_garyhuangg drowned in the riot from #outbreak.. #Tragedy @LUUseer	2017-12-18 10:27:43.085+00
\.


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 237
-- Name: phase1_post_db_item_item_key_seq; Type: SEQUENCE SET; Schema: factextract; Owner: postgres
--

SELECT pg_catalog.setval('phase1_post_db_item_item_key_seq', 289, true);


--
-- TOC entry 3432 (class 2606 OID 1763321)
-- Name: phase1_ext_db_item_extract_uri_key; Type: CONSTRAINT; Schema: factextract; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY phase1_ext_db_item
    ADD CONSTRAINT phase1_ext_db_item_extract_uri_key UNIQUE (extract_uri);


--
-- TOC entry 3434 (class 2606 OID 1763319)
-- Name: phase1_ext_db_item_pkey; Type: CONSTRAINT; Schema: factextract; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY phase1_ext_db_item
    ADD CONSTRAINT phase1_ext_db_item_pkey PRIMARY KEY (item_key);


--
-- TOC entry 3438 (class 2606 OID 1763337)
-- Name: phase1_ext_db_topic_index_item_key_topic_key_key; Type: CONSTRAINT; Schema: factextract; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY phase1_ext_db_topic_index
    ADD CONSTRAINT phase1_ext_db_topic_index_item_key_topic_key_key UNIQUE (item_key, topic_key);


--
-- TOC entry 3436 (class 2606 OID 1763332)
-- Name: phase1_ext_db_topic_pkey; Type: CONSTRAINT; Schema: factextract; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY phase1_ext_db_topic
    ADD CONSTRAINT phase1_ext_db_topic_pkey PRIMARY KEY (topic_key);


--
-- TOC entry 3428 (class 2606 OID 1763305)
-- Name: phase1_post_db_item_pkey; Type: CONSTRAINT; Schema: factextract; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY phase1_post_db_item
    ADD CONSTRAINT phase1_post_db_item_pkey PRIMARY KEY (item_key);


--
-- TOC entry 3430 (class 2606 OID 1763307)
-- Name: phase1_post_db_item_source_uri_key; Type: CONSTRAINT; Schema: factextract; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY phase1_post_db_item
    ADD CONSTRAINT phase1_post_db_item_source_uri_key UNIQUE (source_uri);


--
-- TOC entry 3439 (class 2606 OID 1763338)
-- Name: phase1_ext_db_topic_index_item_key_fkey; Type: FK CONSTRAINT; Schema: factextract; Owner: postgres
--

ALTER TABLE ONLY phase1_ext_db_topic_index
    ADD CONSTRAINT phase1_ext_db_topic_index_item_key_fkey FOREIGN KEY (item_key) REFERENCES phase1_ext_db_item(item_key);


--
-- TOC entry 3440 (class 2606 OID 1763343)
-- Name: phase1_ext_db_topic_index_topic_key_fkey; Type: FK CONSTRAINT; Schema: factextract; Owner: postgres
--

ALTER TABLE ONLY phase1_ext_db_topic_index
    ADD CONSTRAINT phase1_ext_db_topic_index_topic_key_fkey FOREIGN KEY (topic_key) REFERENCES phase1_ext_db_topic(topic_key);


-- Completed on 2017-12-18 10:51:25

--
-- PostgreSQL database dump complete
--

