# IntelAnalysis DSTL fact_extraction software

Fact_extraction_app to poll target folder(s) on disk and do information extraction on new posts. Information extracted is indexed and stored in PostgreSQL database tables. A RabbitMQ control bus is used to control this service and publish new vocabulary.

Fact_extraction_app requires python libs soton_corenlppy, lexicopy, openiepy, sit_assesspy, nltk, pika, gensim, psycopg2. Also requires stanford pos tagger and stanford parser.

Crawler_app to crawl and replay social media datasets, serializing posts to disk as raw JSON. Twitter Search, Twitter Stream and Replay is currently supported.

Crawler_app requires python libs soton_corenlppy, adaptive_crawlpy, requests, psutils. See http://users.ecs.soton.ac.uk/sem/intelanalysis-dstl/ for WHL files.

Builds are Windows and Linux compatible.

# Database Tips

Install PostgreSQL 9.3.2 (64bit) or a later version. Use stackbuilder to install PostGIS 2.1 (or later).

Create a geospatial database for sit_assesspy:

	CREATE DATABASE intelanalysis;
	CREATE EXTENSION IF NOT EXISTS postgis;
	CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
	CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
	CREATE EXTENSION IF NOT EXISTS hstore;
	CREATE SCHEMA IF NOT EXISTS factextract;

On a Windows command line:

	"c:\Program Files\PostgreSQL\9.4\bin\psql.exe" -U postgres -W -d intelanalysis -c "CREATE EXTENSION IF NOT EXISTS postgis; CREATE EXTENSION IF NOT EXISTS fuzzystrmatch; CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder; CREATE EXTENSION IF NOT EXISTS hstore; CREATE SCHEMA IF NOT EXISTS factextract;"

On a Windows 2010 server powershell:
	
	& 'c:\Program Files\PostgreSQL\9.3\bin\psql.exe' -U postgres -W -d intelanalysis -c "CREATE EXTENSION IF NOT EXISTS postgis; CREATE EXTENSION IF NOT EXISTS fuzzystrmatch; CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder; CREATE EXTENSION IF NOT EXISTS hstore; CREATE SCHEMA IF NOT EXISTS factextract;"

Complex situation assessments can generate many tables so this handy PostgreSQL function will delete them all in one go. BE CAREFUL as it will delete any table that matches the regex.

	create or replace function multi_table_poll() returns void as $$
	DECLARE r1 record;
	BEGIN
		<<loop1>>
		FOR r1 IN SELECT tablename FROM pg_catalog.pg_tables WHERE tablename ~* '\Aexample_sit_.*\Z'
		LOOP
			EXECUTE format( 'DROP TABLE reveal.%I CASCADE',r1.tablename);
		END LOOP loop1;
	END
	$$ LANGUAGE plpgsql;
	SELECT multi_table_poll()

# RabbitMQ

New vocabulary control message example for fact extraction app:

	rmq exchange type = fanout
	rmq exchange name = cispaces_exchange
	rmq_routing = cispaces_routing

	message MIME type = application/json
	message body =
	{
		"lexicon": {
			"wall street": ["route"]
			},
		"phrase mapping": {
			"wall st": ["wall street"], "wall street": ["wall street"]
			}
	}

	message MIME type = application/json
	message body =
	{
		"lexicon": {
			"wall street": ["route"],
			"west street": ["route"],
			"nyu hospital": ["building"],
			"virus": ["topic"],
			"mentioned media": ["media"],
			"maiden lane": ["route"],
			"battery place": ["route"],
			"nyse": ["building"],
			"rumour": ["rumour"],
			"world trade centre": ["building"],
			"unrest": ["topic"],
			"william street": ["route"],
			"fdr": ["route"],
			"report": ["report"],
			"blocked": ["topic"]
			},
		"phrase mapping": {
			"ny hospital": ["nyu hospital"], "new york hospital": ["nyu hospital"], "ny university hospital": ["nyu hospital"], "nyu": ["nyu hospital"], "nyu hospital": ["nyu hospital"], "ny university": ["nyu hospital"],
			"vid": ["mentioned media"], "image": ["mentioned media"], "img": ["mentioned media"], "tv": ["mentioned media"], "videos": ["mentioned media"], "footage": ["mentioned media"], "pic": ["mentioned media"], "video": ["mentioned media"], "images": ["mentioned media"], "pictures": ["mentioned media"], "picture": ["mentioned media"],
			"new york stock exchange": ["nyse"], "nyse": ["nyse"], "ny stock exchange": ["nyse"],
			"west street": ["west street"], "west st": ["west street"],
			"battery pl": ["battery place"], "battery place": ["battery place"],
			"william st": ["william street"], "william street": ["william street"],
			"riots": ["unrest"], "riot": ["unrest"], "rioting": ["unrest"], "social unrest": ["unrest"], "angry crowd": ["unrest"], "rioting crowd": ["unrest"],
			"maiden lane": ["maiden lane"], "maiden ln": ["maiden lane"],
			"wall st": ["wall street"], "wall street": ["wall street"],
			"report": ["report"], "confirmed": ["report"], "reports": ["report"],
			"rumor": ["rumour"], "rumour": ["rumour"], "rumors": ["rumour"], "rumours": ["rumour"], "unconfirmed": ["rumour"],
			"fdr": ["fdr"], "fdr drive": ["fdr"],
			"world trade centre": ["world trade centre"], "world trade center": ["world trade centre"], "wtc": ["world trade centre"],
			"closed": ["blocked"], "blocked": ["blocked"], "shut": ["blocked"],
			"outbreak": ["virus"], "virus warning": ["virus"], "virus": ["virus"],
			}
	}

# Twitter developer API key

Getting a Twitter developer API key:

	Register a new Twitter user at https://twitter.com/signup which may now need a mobile phone number for verification.
	Confirm your account (email will be sent).
	Login to http://dev.twitter.com and select "Documentation" from the "Developers" tab (top of the screen).
	Click on “Manage My Apps” from the left main documentation menu.
	Click on "Create New App" and fill out the application form.
	When application panel will be displayed go to "API Keys" tab and click "Create my access token" button.
	note: instructions valid as of 2016

# Getting started

Install Ant 1.8+, RabbitMQ server, Python 2.7.10+ and Python pre-requisite libs

Run the crawler apps to generate JSON OSINT data:

	ant run.crawler-replay -propertyfile=github.properties
	ant run.crawler-twitter-stream -propertyfile=github.properties
	ant run.crawler-twitter-search -propertyfile=github.properties

Run the fact extraction app to ingest JSON OSINT data ready for CISpaces UI to use it:

	ant run.fact-extraction-app -propertyfile=github.properties

See the build.xml script for precise details about how to run each application and what configuration options there are.

# Support

We do not offer any software support beyond the examples already provided.

# License

The software is copyright 2017 University of Southampton IT Innovation Centre, UK. The fact-extraction software was created under DSTL ACC Contract No DSTLX 1000113927.

It is licensed under a 4 clause BSD license - see https://github.com/CISpaces/factextraction/blob/master/docs/LICENSE.txt for full details.
