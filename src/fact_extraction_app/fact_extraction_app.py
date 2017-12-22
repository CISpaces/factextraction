# !/usr/bin/env python
# -*- coding: utf-8 -*-

"""
/////////////////////////////////////////////////////////////////////////
//
// (c) Copyright University of Southampton IT Innovation, 2017
//
// Copyright in this software belongs to IT Innovation Centre of
// Gamma House, Enterprise Road, Southampton SO16 7NS, UK.
//
// This software may not be used, sold, licensed, transferred, copied
// or reproduced in whole or in part in any manner or form or in or
// on any media by any person other than in accordance with the terms
// of the Licence Agreement supplied with the software, or otherwise
// without the prior written consent of the copyright owners.
//
// This software is distributed WITHOUT ANY WARRANTY, without even the
// implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
// PURPOSE, except where stated in the Licence Agreement supplied with
// the software.
//
//    Created By :    Stuart E. Middleton
//    Created Date :    2017/09/12
//    Created for Project:    IntelAnalysisDSTL
//
/////////////////////////////////////////////////////////////////////////
//
// Dependencies: None
//
/////////////////////////////////////////////////////////////////////////
"""

import os, sys, logging, traceback, codecs, datetime, copy, time, ast, math, re, random, shutil, json, csv, threading, warnings
warnings.filterwarnings(action='ignore', category=UserWarning, module='gensim')
import soton_corenlppy, openiepy, lexicopy, sit_assesspy
import nltk.stem, pika
import fact_extraction_patterns_regex
import RabbitMQHandler, LexiconControlMessageHandler

'''
Fact extraction app
- start a service that subscribed to RabbitMQ for control messages (i.e. new relevant keywords)
- poll a set of folders for new JSON posts
- do fact extraction
- publish data via sit_assesspy to some PostgrSQL database tables
'''

# global shared memory control handler object
global_controlMessageHandler = None
global_rabbitmqConsumerHandler = None
global_consumerFlag = False

def pos_tag_sents( dictText, nSentMax, dictOpenIEConfig ) :

	# tokenize text blocks into sents then tag them
	dictTaggedSents = {}
	nSentTotal = 0
	for strURI in dictText :

		# get text
		strUTF8Text = dictText[strURI]

		# check sent limit
		if (nSentMax != -1) and (nSentTotal > nSentMax) :
			break

		# note: phrases matching dict_common_config['token_preservation_regex'] regex will be preserved as single tokens
		listSents = soton_corenlppy.common_parse_lib.unigram_tokenize_text_with_sent_breakdown( text = strUTF8Text, dict_common_config = dictOpenIEConfig )
		nSentTotal = nSentTotal + len( listSents )

		# note: phrases matching dict_common_config['token_preservation_regex'] regex will have the Stanford POS tag replaced with an explicit label
		listTaggedSentSet = soton_corenlppy.common_parse_lib.pos_tag_tokenset( token_set = listSents, lang = 'en', dict_common_config = dictOpenIEConfig )

		dictTaggedSents[ strURI ] = listTaggedSentSet

	dictOpenIEConfig['logger'].info( 'Number of sents in corpus = ' + str(nSentTotal) )

	# remove URI's with no sents (in case not all sents processed due to limit)
	listKeys = dictTaggedSents.keys()
	for strURI in listKeys :
		if len( dictTaggedSents[strURI] ) == 0 :
			del dictText[strURI]
			del dictTaggedSents[strURI]

	return dictTaggedSents


def dependancy_parse_sents( dictSentTrees, dictOpenIEConfig ) :

	# get dependency parser
	dep_parser = openiepy.comp_sem_lib.get_dependency_parser( dict_openie_config = dictOpenIEConfig )

	# dependancy parse tagged sents
	dictDepGraphs = openiepy.comp_sem_lib.parse_sent_trees_batch(
		dict_doc_sent_trees = dictSentTrees,
		dep_parser = dep_parser,
		dict_custom_pos_mappings = fact_extraction_patterns_regex.dictTagDependancyParseMapping,
		max_processes = 4,
		dict_openie_config = dictOpenIEConfig )

	'''
	# dependancy parse tagged sents
	# we do them all here as we want to do open extraction on them all eventually
	dictDepGraphs = {}
	for strURI in dictSentTrees :

		# flatten the sents (POS pattern phrases prior to ReVerb annotations) to become a list of POS tagged phrases. this is needed as the dependancy parser works on a tagged list of tokens i.e. not a sent tree
		listTaggedSentsDepParse = []
		for nIndexSent in range(len(dictSentTrees[strURI])) :
			treeFlat = soton_corenlppy.common_parse_lib.flattern_sent( tree_sent = dictSentTrees[strURI][nIndexSent], dict_common_config = dictOpenIEConfig )
			listTaggedSentsDepParse.append( treeFlat.pos() )

		# replace any non-Stanford POS tags with an equivilent so the dependency parse is as good as it can be, and replace spaces with '_' in tokens (if phrases are allowed) as dep parser expects unigram tokens
		openiepy.comp_sem_lib.prepare_tags_for_dependency_parse(
			list_tagged_sents = listTaggedSentsDepParse,
			dict_custom_pos_mappings = fact_extraction_patterns_regex.dictTagDependancyParseMapping,
			dict_openie_config = dictOpenIEConfig )

		sentDepGraphs = dep_parser.tagged_parse_sents( sentences = listTaggedSentsDepParse )
		dictOpenIEConfig['logger'].info( 'parsing ' + strURI )

		listSentGraphs = []
		for depGraphIter in sentDepGraphs :
			# tagged_parse_sents() returns an iterator for some reason so just get graph and break
			for depObj in depGraphIter :
				listSentGraphs.append( depObj )

				# draw graph for presentations (disable normally). will block wait until window is closed
				# depObj.tree().draw()

				break

		dictDepGraphs[ strURI ] = listSentGraphs
	'''
	
	return dictDepGraphs


def insert_posts_and_extracts_to_database( dictDepGraphs, dictText, dictTimestamp, dictExtractedVars, sitAssessHandlerPost, sitAssessHandlerExt, dictOpenIEConfig ) :

	logger.info( 'updating situation assessment' )

	#
	# insert new posts to database
	# note: explicitly provide a updated_time in case this extract is re-inserted for some reason.
	#

	for strURI in dictDepGraphs :

		# item data
		listData = [
			{
				'item:source_uri' : strURI,
				'item:text' : dictText[strURI],
				'item:created_at' : dictTimestamp[strURI],
			}
		]

		# insert data to database
		sitAssessHandlerPost.insert_data( listData )

	# serialized vars as encoded strings that can be parsed
	dictEncodedVars = {}
	for strURI in dictDepGraphs :
		dictEncodedVars[strURI] = []

		for nSentIndex in range(len(dictExtractedVars[strURI])) :
			listEncodedVars = []

			# loop on extractions for this sent
			for nMatchIndex in range(len(dictExtractedVars[strURI][nSentIndex])) :

				strEncoded = openiepy.comp_sem_lib.encode_extraction(
					list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
					dep_graph = dictDepGraphs[strURI][nSentIndex],
					set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
					dict_openie_config = dictOpenIEConfig )
				listEncodedVars.append( strEncoded )

			# add encoded vars for this sent
			dictEncodedVars[strURI].append( listEncodedVars )

	#
	# insert extractions from new posts with encoded vars to database
	#

	for strURI in dictDepGraphs :

		nExtractCount = 0

		# extractions for this item
		for nSentIndex in range(len(dictExtractedVars[strURI])) :

			# loop on extractions for this sent
			for nMatchIndex in range(len(dictExtractedVars[strURI][nSentIndex])) :

				# plain text pretty print of extraction
				strPrettyText = openiepy.comp_sem_lib.pretty_print_extraction(
					list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
					dep_graph = dictDepGraphs[strURI][nSentIndex],
					set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
					style = 'tokens_only',
					dict_openie_config = dictOpenIEConfig )

				# encoded var set for extraction
				strEncoded = dictEncodedVars[strURI][nSentIndex][nMatchIndex]
				nExtractCount = nExtractCount + 1

				# item data
				listData = [
					{
						'item:extract_uri' : strURI + '#' + str(nExtractCount),
						'item:source_uri' : strURI,
						'item:extract' : strPrettyText.lower().strip(),
						'item:encoded' : strEncoded
					}
				]

				# insert data to database
				sitAssessHandlerExt.insert_data( listData )


def annotate_extracts_in_database( sitAssessHandlerExt, dictOpenIEConfig, dictLexiconPhrase, dictLexiconURI, stemmer, datePublished ) :

	logger.info( 'annotating situation assessment' )

	#
	# SQL query to get all encoded vars and parse them then upload a new set of topic indexes
	# this allows a user to ask for a new set of topics to be indexed WITHOUT needing to re-compute the NLP extractions
	# note: by using a SQL table structure we lose the sent breakdown, so each item simply has a set of extractions representing all sents from that item.
	#

	# reset encoded var dict
	dictEncodedVars = {}

	# query spec
	dictQuery = {
		"params": [
				{
					"name": "PUBLISHED",
					"tag": "PUBLISHED",
					"value": datePublished,
				}
			],
		'select' : [
			"item.extract_uri AS extract_uri",
			"item.encoded AS encoded",
			],
		'from' : [
			'item'
			],
		'where' : [
			'item.updated_time >= ${PUBLISHED}'
			]
	}

	# run query to get encoded vars for each extraction
	listSQLResults = sitAssessHandlerExt.query_data( dictQuery )

	# populate dictEncodedVars with the encoded extractions
	for listResult in listSQLResults :
		strExtractURI = listResult[0]
		strEncoded = listResult[1]

		# PostgreSQL returns <str> with 8-bit UTF-8 encoded ASCII text
		# To have it as a unicode type it must be decoded first from the 8-bit representation
		strEncoded = strEncoded.decode( 'utf-8' )

		if not strURI in dictEncodedVars :
			dictEncodedVars[ strExtractURI ] = []
		dictEncodedVars[ strExtractURI ].append( strEncoded )

	#
	# parse encoded vars and index database extractions with any lexicon phrases that match vars
	#

	# delete any existing annotations (so we have a clean sheet) but leave the items alone
	sitAssessHandlerExt.delete_annotations()

	# new annotations from the SQL encoded vars
	for strExtractURI in dictEncodedVars :

		listAnnotations = []

		# loop on extractions for this item
		for nMatchIndex in range(len(dictEncodedVars[strExtractURI])) :

			strEncoded = dictEncodedVars[strExtractURI][nMatchIndex]

			# parse encoded variables
			# listExtractedVars = [ ( var_name, var_head, var_phrase, (negated, genuine), { dep_path : [ var,var... ], ... }, address ), ... ]
			listExtractedVars = openiepy.comp_sem_lib.parse_encoded_extraction( encoded_str = strEncoded, dict_openie_config = dictOpenIEConfig )

			'''
			for nVarIndex in range(len(listExtractedVars)) :
				logger.info( 'VAR = ' + repr( listExtractedVars[nVarIndex][0:3] ) )
			'''

			# map encoded extractions to domain lexicon
			# listSemanticallyMappedExtractedVars = [ [ (var_name, var_phrase, var_gram_size, [lexicon_uri, schema_uri, matched_phrase, phrase_gram_size, confidence_score] ), ... ]
			listSemanticallyMappedExtractedVars = openiepy.sem_map_lib.map_encoded_extraction_to_lexicon(
				extraction_vars = listExtractedVars,
				lex_phrase_index = dictLexiconPhrase,
				lex_uri_index = dictLexiconURI,
				only_best_matches = True,
				stemmer = stemmer,
				dict_openie_config = dictOpenIEConfig )

			'''
			if len(listSemanticallyMappedExtractedVars) > 0 :
				logger.info( 'URI (match) = ' + repr(strURI) )
				logger.info( 'Text (match) = ' + repr(dictText[strURI]) )
			'''

			# only index extraction variables which have at least one semantically mapped variable
			for ( strMatchName, strMatchPhrase, nMatchGramSize, listLexiconMatch ) in listSemanticallyMappedExtractedVars :
				for nIndexLexicon in range(len(listLexiconMatch)) :
					#logger.info( 'MAP = ' + repr( strMatchName ) + ' > ' + repr( strMatchPhrase ) + ' > ' + repr( listLexiconMatch[nIndexLexicon] ) )

					strLexiconURI = listLexiconMatch[nIndexLexicon][0]
					strSchemaURI = listLexiconMatch[nIndexLexicon][1] 

					# lookup negation status
					tupleNegated = (None,None)
					for nVarIndex in range(len(listExtractedVars)) :
						if listExtractedVars[nVarIndex][0] == strMatchName :
							tupleNegated = listExtractedVars[nVarIndex][3]
							break

					# add topic annotation to database
					listAnnotations.append( 
						{
							'item:extract_uri' : strExtractURI,
							'topic:topic' : strLexiconURI.lower().strip(),
							'topic:schema' : strSchemaURI.lower().strip(),
							'topic:negated' : tupleNegated[0],
							'topic:genuine' : tupleNegated[1]
						} )

		# insert data to database
		sitAssessHandlerExt.insert_data( listAnnotations )

def setup_rabbitmq_consumer( dictRabbitMQConfig ) :

	# modify main thread's version of the control handler variable
	global global_controlMessageHandler
	global global_rabbitmqConsumerHandler
	global global_consumerFlag

	# make logger for this thread (global to STDOUT)
	LOG_FORMAT = ('%(levelname) -s %(asctime)s %(message)s')
	logger = logging.getLogger( __name__ )
	logging.basicConfig( level=logging.INFO, format=LOG_FORMAT )
	logger.info('consumer thread started')

	# catch every exception as this will be started in a thread
	try :

		# initialise message handler
		global_controlMessageHandler = LexiconControlMessageHandler.LexiconControlMessageHandler( dictRabbitMQConfig )

		# read rmq callback channel parameters
		# read rmq queue, exchange/exchange type and routing
		strRmqQueue = dictRabbitMQConfig[ 'rmq_queue_name' ]
		strRmqExchangeType = dictRabbitMQConfig[ 'rmq_exchange_type' ]
		strExchange = dictRabbitMQConfig[ 'rmq_exchange_name' ]
		strRouting = dictRabbitMQConfig[ 'rmq_routing' ]

		# check rmq queue exclusive flag 
		bRmqExclusiveQueue = ast.literal_eval( dictRabbitMQConfig[ 'rmq_exclusive_queue' ] )

		# check rmq queue auto-delete flag
		bRmqAutoDeleteQueue = ast.literal_eval( dictRabbitMQConfig[ 'rmq_auto_delete_queue' ] )

		# log detailed channel parameters
		logger.info( 'rabbitmq callback consumer channel details:' )
		logger.info( 'channel exchange: ' + strExchange )
		logger.info( 'channel exchange type: ' + strRmqExchangeType )
		logger.info( 'routing key: ' + strRouting )
		logger.info( 'queue name: ' + repr( strRmqQueue ) ) # can be '' for an auto queue
		logger.info( 'exclusive queue: ' + repr( bRmqExclusiveQueue ) )
		logger.info( 'autodelete queue: ' + repr( bRmqAutoDeleteQueue ) )

		# create rmq handler and connect
		global_rabbitmqConsumerHandler = RabbitMQHandler.RabbitMQHandler(
			dictRabbitMQConfig[ 'rmq_username' ],
			dictRabbitMQConfig[ 'rmq_password' ],
			dictRabbitMQConfig[ 'rmq_host' ],
			dictRabbitMQConfig[ 'rmq_port' ],
			query_params = dictRabbitMQConfig[ 'rmq_connection_parameters_python' ],
			logger = logger )
		global_rabbitmqConsumerHandler.connect()

		# create callback channel
		logger.info( 'RabbitMQ opening channel for consumer')
		global_rabbitmqConsumerHandler.open_channel(
			declare_exchange = strExchange,
			exchange_type = strRmqExchangeType,
			declare_queue = strRmqQueue,
			exclusive = bRmqExclusiveQueue,
			auto_delete = bRmqAutoDeleteQueue,
			routing_key = strRouting )

		# register callback
		logger.info( 'RabbitMQ registering callback for consumer')
		global_rabbitmqConsumerHandler.consume_message( callback_handler = global_controlMessageHandler.handleDelivery )

		logger.info( 'RabbitMQ consume start')
		global_consumerFlag = True
		global_rabbitmqConsumerHandler.channel.start_consuming()
		logger.info( 'RabbitMQ consume end')

	# exceptions (e.g. connection closed and blocking consumer aborts)
	except Exception, error_general :
		logger.warn( 'RabbitMQ consumer aborted (maybe connection closed by main thread) : ' + repr( error_general ) )


def publish_rabbitmq_lexicon( dictLexiconPhrase, dictLexiconURI ) :

	# create rmq handler and connect
	rabbitmqPublisherHandler = RabbitMQHandler.RabbitMQHandler(
		dictRabbitMQConfig[ 'rmq_username' ],
		dictRabbitMQConfig[ 'rmq_password' ],
		dictRabbitMQConfig[ 'rmq_host' ],
		dictRabbitMQConfig[ 'rmq_port' ],
		query_params = dictRabbitMQConfig[ 'rmq_connection_parameters_python' ],
		logger = logger )
	rabbitmqPublisherHandler.connect()

	# read rmq callback channel parameters
	# read rmq queue, exchange/exchange type and routing
	strRmqQueue = dictRabbitMQConfig[ 'rmq_queue_name' ]
	strRmqExchangeType = dictRabbitMQConfig[ 'rmq_exchange_type' ]
	strExchange = dictRabbitMQConfig[ 'rmq_exchange_name' ]
	strRouting = dictRabbitMQConfig[ 'rmq_routing' ]

	# create publish channel
	rabbitmqPublisherHandler.open_channel(
		declare_exchange = strExchange,
		exchange_type = strRmqExchangeType,
		routing_key = strRouting )

	# log detailed channel parameters
	dictRabbitMQConfig['logger'].info( 'rabbitmq callback publisher channel details:' )
	dictRabbitMQConfig['logger'].info( 'channel exchange: ' + strExchange )
	dictRabbitMQConfig['logger'].info( 'channel exchange type: ' + strRmqExchangeType )
	dictRabbitMQConfig['logger'].info( 'routing key: ' + strRouting )

	# prepare message
	dictObj = {
		'phrase_mapping' : dictLexiconPhrase,
		'lexicon' : dictLexiconURI
		}

	# make lists as JSON does not support sets
	for strURI in dictObj['phrase_mapping'] :
		dictObj['phrase_mapping'][strURI] = list( dictObj['phrase_mapping'][strURI] )

	strMessage = json.dumps( dictObj )

	dictRabbitMQConfig['logger'].info( 'RabbitMQ publish start')
	rabbitmqPublisherHandler.publish_message( strMessage, content_type = 'application/json' )
	dictRabbitMQConfig['logger'].info( 'RabbitMQ publish end')

	if not rabbitmqPublisherHandler.channel.is_closed :
		rabbitmqPublisherHandler.channel.close
	rabbitmqPublisherHandler.disconnect()




################################
# main
################################

# only execute if this is the main file
if __name__ == '__main__' :

	#
	# check args
	#
	if len(sys.argv) < 2 :
		print 'Usage: fact_extraction_app.py <config file>\n'
		sys.stdout.flush()
		sys.exit(1)
	if not os.path.isfile(sys.argv[1]) :
		print '<config file> ' + sys.argv[1] + ' does not exist\n'
		sys.stdout.flush()
		sys.exit(1)

	# make logger (global to STDOUT)
	LOG_FORMAT = ('%(levelname) -s %(asctime)s %(message)s')
	logger = logging.getLogger( __name__ )
	logging.basicConfig( level=logging.INFO, format=LOG_FORMAT )
	logger.info('logging started')

	# initialize
	readHandle = None
	writeHandle = None
	sitAssessHandlerPost = None
	sitAssessHandlerExt = None
	theadConsumer = None

	try :
		# init
		strConfigFile = sys.argv[1]

		# load config
		dictConfig = soton_corenlppy.config_helper.read_config( strConfigFile )

		strInputFile = dictConfig['input_file']
		strOutputFilePOS = dictConfig['output_file_pos']
		strOutputFileSeeds = dictConfig['output_file_seeds']
		strOutputFileExtraction = dictConfig['output_file_extraction']
		nSentMax = int( dictConfig['max_sent_limit'] )
		bUnitTestPublishVocab = ast.literal_eval( dictConfig['unit_test_publish_vocab'] )
		strInputFolder = dictConfig['input_folder']
		nPollFreq = int( dictConfig['input_folder_polling_freq'] )
		nTargetExtractionTemplates = int( dictConfig['target_extraction_templates'] )
		nRandomSubsetTraining = int( dictConfig['random_subset_training'] )
		nProcessMax = int( dictConfig['process_count'] )

		strTrainingInputFile = dictConfig['training_input_file']
		strTemplateFile = dictConfig['open_extraction_templates_file']

		if (len(strInputFolder) == 0) and (len(strInputFile) == 0) :
			raise Exception( 'input folder and file cannot both be empty' )

		listLangs = dictConfig['language_codes']
		strStanfordTaggerDir = dictConfig['stanford_tagger_dir']
		strStanfordParserDir = dictConfig['stanford_parser_dir']

		strModelPath = dictConfig['model_path']
		strModelJar = dictConfig['model_jar']
		strModelOptions = dictConfig['model_options']

		# post tables
		dictSitAssessPostConfig = {}
		dictSitAssessPostConfig['assessment_id'] = dictConfig['assessment_id_post']
		dictSitAssessPostConfig['db_user'] = dictConfig['db_user']
		dictSitAssessPostConfig['db_pass'] = dictConfig['db_pass']
		dictSitAssessPostConfig['db_host'] = dictConfig['db_host']
		dictSitAssessPostConfig['db_port'] = dictConfig['db_port']
		dictSitAssessPostConfig['db_name'] = dictConfig['db_name']
		dictSitAssessPostConfig['db_schema_reveal'] = dictConfig['db_schema']
		dictSitAssessPostConfig['table_specs'] = dictConfig['table_specs_post']
		dictSitAssessPostConfig['timeout_statement'] = 60
		dictSitAssessPostConfig['timeout_overall'] = 300
		dictSitAssessPostConfig['item_table_suffix'] = dictConfig['item_table_suffix']
		dictSitAssessPostConfig['index_table_suffix'] = dictConfig['index_table_suffix']
		dictSitAssessPostConfig['max_assess_id_length'] = dictConfig['max_assess_id_length']
		dictSitAssessPostConfig['max_table_length'] = dictConfig['max_table_length']

		# extract tables
		dictSitAssessExtConfig = {}
		dictSitAssessExtConfig['assessment_id'] = dictConfig['assessment_id_ext']
		dictSitAssessExtConfig['db_user'] = dictConfig['db_user']
		dictSitAssessExtConfig['db_pass'] = dictConfig['db_pass']
		dictSitAssessExtConfig['db_host'] = dictConfig['db_host']
		dictSitAssessExtConfig['db_port'] = dictConfig['db_port']
		dictSitAssessExtConfig['db_name'] = dictConfig['db_name']
		dictSitAssessExtConfig['db_schema_reveal'] = dictConfig['db_schema']
		dictSitAssessExtConfig['table_specs'] = dictConfig['table_specs_ext']
		dictSitAssessExtConfig['timeout_statement'] = 60
		dictSitAssessExtConfig['timeout_overall'] = 300
		dictSitAssessExtConfig['item_table_suffix'] = dictConfig['item_table_suffix']
		dictSitAssessExtConfig['index_table_suffix'] = dictConfig['index_table_suffix']
		dictSitAssessExtConfig['max_assess_id_length'] = dictConfig['max_assess_id_length']
		dictSitAssessExtConfig['max_table_length'] = dictConfig['max_table_length']

		#
		# setup situation assessment database
		# note: for now old data is simply deleted each time we run
		#

		sitAssessHandlerPost = sit_assesspy.sit_assess_lib.SitAssessLib( dictSitAssessPostConfig, logger )
		sitAssessHandlerExt = sit_assesspy.sit_assess_lib.SitAssessLib( dictSitAssessExtConfig, logger )

		if bUnitTestPublishVocab == True :
			# delete tables if they exist already
			sitAssessHandlerPost.delete_tables()
			sitAssessHandlerExt.delete_tables()

		# make tables
		sitAssessHandlerPost.create_tables()
		sitAssessHandlerExt.create_tables()


		# setup parser config
		# make sure whitespace does NOT include /\ as we want to use these for patterns later
		# note: don't bother with ' in whitespace as this is handled separately (and removed if not grammatical)
		# \u201a & \u201b == unicode single quote
		# \u201c & \u201d == unicode double quote
		# \u2018 & \u2019 == unicode apostrophe
		# \u2026 == ... unicode chart used by twitter to mark truncated tweet text at end of tweet
		# apostrophe is important for parsing negation. tokens like "hasn't" => which Treebank word tokenizer then Stanford POS labels as has/VBZ n't/RB, and n't/RB has a dep graph 'neg' entry
		# a null stemmer is provided as we will handle pluruals etc in the regex vocab explicitly (to avoid losing s at end of named entities)
		# social media grammar is noisy so treat hyphenated tokens as punctuation (i.e. 'mass-evacuation' becomes 'mass evacuation'). On average this gives the right result as there is more mis-use of hyphen in posts than correct use.
		# allow hashtags (stanford parser will POS labelled them as NN)

		dictOpenIEConfig = openiepy.openie_lib.get_openie_config(
			lang_codes = listLangs,
			logger = logger,
			stanford_tagger_dir = strStanfordTaggerDir,
			stanford_parser_dir = strStanfordParserDir,
			dep_model_path = strModelPath,
			dep_model_jar = strModelJar,
			dep_options = strModelOptions,
			whitespace = u'"\u201a\u201b\u201c\u201d',
			punctuation = """,;\/:+~&*=!?-""",
			sent_token_seps = [ '\n', '\r', '\f', u'\u2026' ],
			apostrophe_handling = False
			)

		# ISSUES and IDEAS
		# TODO sents without verbs never match e.g. Looks/NNS like/IN south/NNP rioting/NN well/RB into/IN Wall/NNP Street/NNP
		# TODO think about noun blocks like "World Trade Centre construction site rioting" => how to capture "World Trade Centre"
		# TODO extract AttributedTo [ccomp -> controled_vocab [communication and cognition class verbs from VerbNet e.g. believe] see OLLIE [dont build into algo to ensure differentiation]
		# TODO extract ClausalModifier [advcl -> controlled_vocab [if, when, although, because ...] see OLLIE [dont build into algo to ensure differentiation]
		# TODO template ranking strategy. currently freq of occurance. OLLIE used  supervised learning based on features (a) occurance freq in corpus (b) presence of AttributedTo and ClausalModifier (c) presence of controlled vocab that weaken factual statements e.g. 'if' [ensure differentiation somehow]

		# add POS tag replacement for hashtags and twitter screen names to preserve them as tokens
		# otherwise tokenization will split them up
		dictOpenIEConfig['token_preservation_regex'].append( ('regex_hashtag','HASHTAG') )
		dictOpenIEConfig['regex_hashtag'] = fact_extraction_patterns_regex.regex_hashtag
		dictOpenIEConfig['token_preservation_regex'].append( ('regex_twitter','TWITTER') )
		dictOpenIEConfig['regex_twitter'] = fact_extraction_patterns_regex.regex_twitter

		socialMediaParser = soton_corenlppy.SocialMediaParser.SocialMediaParser( logger )

		# get dependency parser
		dep_parser = openiepy.comp_sem_lib.get_dependency_parser( dict_openie_config = dictOpenIEConfig )

		# check dir exists
		if (len(strInputFile) != 0) and (os.path.exists( strInputFile ) == False) :
			raise Exception( 'input file does not exist : ' + strInputFile )

		if (len(strInputFolder) != 0) and (os.path.exists( strInputFolder ) == False) :
			raise Exception( 'input folder does not exist : ' + strInputFolder )

		if len(strOutputFilePOS) == 0 :
			raise Exception( 'output file POS missing in config' )
		if len(strOutputFileExtraction) == 0 :
			raise Exception( 'output file extraction missing in config' )

		stemmer = nltk.stem.RegexpStemmer('s$', min=4)


		#
		# setup the RabbitMQ subscriber callback function
		#

		dictRabbitMQConfig = {
			'rmq_host' : dictConfig['rmq_host'],
			'rmq_port' : int( dictConfig['rmq_port'] ),
			'rmq_username' : dictConfig['rmq_username'],
			'rmq_password' : dictConfig['rmq_password'],
			'rmq_queue_name' : dictConfig['rmq_queue_name'],
			'rmq_timeout_statement' : int( dictConfig['rmq_timeout_statement'] ),
			'rmq_timeout_connection' : int( dictConfig['rmq_timeout_connection'] ),
			'rmq_timeout_overall' : int( dictConfig['rmq_timeout_overall'] ),
			'rmq_connection_parameters_java' : dictConfig['rmq_connection_parameters_java'],
			'rmq_connection_parameters_python' : dictConfig['rmq_connection_parameters_python'],
			'rmq_exclusive_queue' : dictConfig['rmq_exclusive_queue'],
			'rmq_auto_delete_queue' : dictConfig['rmq_auto_delete_queue'],
			'rmq_exchange_type' : dictConfig['rmq_exchange_type'],
			'rmq_exchange_name' : dictConfig['rmq_exchange_name'],
			'rmq_routing' : dictConfig['rmq_routing'],
			'logger' : logger
			}


		# start consuming messages (in a thread as its a blocking connection)
		# note: use global rabbitmqConsumerHandler object to avoid thread hanging later on shutdown
		theadConsumer = threading.Thread( target = setup_rabbitmq_consumer, args = ( dictRabbitMQConfig, ) )
		theadConsumer.daemon = False
		theadConsumer.start()

		# give consumer a chance to connect then check all is OK
		logger.info( 'waiting for consumer to finish' )
		nCount = 0
		while (global_consumerFlag == False) and (nCount < 10) :
			time.sleep(1)
			nCount = nCount + 1

		if global_consumerFlag == False :
			raise Exception('Failed to connect to RabbitMQ as a consumer (timed out waiting - check logs for errors)')

		#
		# UNIT TEST vocab message to get things going
		#
		if bUnitTestPublishVocab == True :

			dictLexiconURIUnitTest = {
				'world_trade_centre' : [ 'building' ],
				'nyse' : [ 'building' ],
				'nyu_hospital' : [ 'building' ],
				'west_street' : [ 'route' ],
				'battery_place' : [ 'route' ],
				'wall_street' : [ 'route' ],
				'maiden_lane' : [ 'route' ],
				'william_street' : [ 'route' ],
				'fdr' : [ 'route' ],
				'unrest' : [ 'topic' ],
				'virus' : [ 'topic' ],
				'blocked' : [ 'topic' ],
				'report' : [ 'report' ],
				'rumour' : [ 'rumour' ],
				'mentioned_media' : [ 'media' ],
				}

			dictLexiconPhraseUnitTest = {
				'world trade centre' : set( [ 'world_trade_centre' ] ),
				'world trade center' : set( [ 'world_trade_centre' ] ),
				'wtc' : set( [ 'world_trade_centre' ] ),
				'nyse' : set( [ 'nyse' ] ),
				'ny stock exchange' : set( [ 'nyse' ] ),
				'new york stock exchange' : set( [ 'nyse' ] ),
				'nyu hospital' : set( [ 'nyu_hospital' ] ),
				'nyu' : set( [ 'nyu_hospital' ] ),
				'ny university hospital' : set( [ 'nyu_hospital' ] ),
				'ny university' : set( [ 'nyu_hospital' ] ),
				'ny hospital' : set( [ 'nyu_hospital' ] ),
				'new york hospital' : set( [ 'nyu_hospital' ] ),

				'west street' : set( [ 'west_street' ] ),
				'west st' : set( [ 'west_street' ] ),
				'battery place' : set( [ 'battery_place' ] ),
				'battery pl' : set( [ 'battery_place' ] ),
				'wall street' : set( [ 'wall_street' ] ),
				'wall st' : set( [ 'wall_street' ] ),
				'maiden lane' : set( [ 'maiden_lane' ] ),
				'maiden ln' : set( [ 'maiden_lane' ] ),
				'william street' : set( [ 'william_street' ] ),
				'william st' : set( [ 'william_street' ] ),
				'fdr drive' : set( [ 'fdr' ] ),
				'fdr' : set( [ 'fdr' ] ),

				'riot' : set( [ 'unrest' ] ),
				'rioting' : set( [ 'unrest' ] ),
				'riots' : set( [ 'unrest' ] ),
				'rioting crowd' : set( [ 'unrest' ] ),
				'angry crowd' : set( [ 'unrest' ] ),
				'social unrest' : set( [ 'unrest' ] ),

				'outbreak' : set( [ 'virus' ] ),
				'virus' : set( [ 'virus' ] ),
				'virus warning' : set( [ 'virus' ] ),

				'closed' : set( [ 'blocked' ] ),
				'blocked' : set( [ 'blocked' ] ),
				'shut' : set( [ 'blocked' ] ),

				'report' : set( [ 'report' ] ),
				'reports' : set( [ 'report' ] ),
				'confirmed' : set( [ 'report' ] ),

				'rumour' : set( [ 'rumour' ] ),
				'rumours' : set( [ 'rumour' ] ),
				'rumor' : set( [ 'rumour' ] ),
				'rumors' : set( [ 'rumour' ] ),
				'unconfirmed' : set( [ 'rumour' ] ),

				'pic' : set( [ 'mentioned_media' ] ),
				'picture' : set( [ 'mentioned_media' ] ),
				'pictures' : set( [ 'mentioned_media' ] ),
				'img' : set( [ 'mentioned_media' ] ),
				'image' : set( [ 'mentioned_media' ] ),
				'images' : set( [ 'mentioned_media' ] ),
				'vid' : set( [ 'mentioned_media' ] ),
				'video' : set( [ 'mentioned_media' ] ),
				'videos' : set( [ 'mentioned_media' ] ),
				'footage' : set( [ 'mentioned_media' ] ),
				'tv' : set( [ 'mentioned_media' ] ),

				}

			# publish control message
			publish_rabbitmq_lexicon( dictLexiconPhraseUnitTest, dictLexiconURIUnitTest )

		#
		# training phase to create open information extraction templates
		# for test runs simply load the previously generated template file
		#

		if len(strTrainingInputFile) != 0 :

			#
			# read training tweets from disk
			#

			logger.info( 'reading training file : ' + strTrainingInputFile )

			# parse JSON from SPARQL
			dictText = {}
			dictTimestamp = {}

			# read input data
			readHandle = codecs.open( strTrainingInputFile, 'r', 'utf-8', errors = 'replace' )
			listLines = readHandle.readlines()
			readHandle.close()

			for strLine in listLines :
				if len(strLine.strip()) == 0 :
					continue
				elif strLine.startswith( '#' ) :
					continue
				else :
					#logger.info( repr(strLine.strip()) )
					jsonObj = json.loads( strLine.strip(), encoding = 'utf-8' )

					strSocialMediaType = socialMediaParser.detect_social_media_type( jsonObj )
					if strSocialMediaType != 'twitter' :
						raise Exception( 'post not a Tweet (unknown JSON structure)' )

					strURI = socialMediaParser.get_source_uri( jsonObj, strSocialMediaType )

					dateTimestamp = socialMediaParser.get_timestamp( jsonObj, strSocialMediaType )
					dictTimestamp[ strURI ] = dateTimestamp

					strUTF8Text = socialMediaParser.get_text( jsonObj, strSocialMediaType )
					dictText[ strURI ] = strUTF8Text

			logger.info( 'Number of URIs in corpus = ' + str(len(dictText.keys())) )

			#
			# POS tagging
			#

			dictTaggedSents = pos_tag_sents( dictText, nSentMax, dictOpenIEConfig )

			#
			# ReVerb to create seed tuples
			#

			# create a set of sent trees
			dictSentTrees = {}
			for strURI in dictTaggedSents :
				dictSentTrees[strURI] = []
				for listSentTagged in dictTaggedSents[strURI] :
					listSentTrees = soton_corenlppy.common_parse_lib.create_sent_trees( list_pos = listSentTagged, dict_common_config = dictOpenIEConfig )
					dictSentTrees[strURI].extend( listSentTrees )

					# debug
					'''
					for treeSent in listSentTrees :
						logger.info( unicode( treeSent ) )
					'''

			#
			# annotate ReVerb argument and relations -> seed_tuples
			#
			dictSentTreesReVerb = {}
			for strURI in dictSentTrees :
				listSentTreeAnnotated = openiepy.comp_sem_lib.annotate_using_pos_patterns(
					list_sent_trees = dictSentTrees[strURI],
					list_phrase_sequence_patterns_exec_order = fact_extraction_patterns_regex.listReVerbExecutionOrder,
					dict_phrase_sequence_patterns = fact_extraction_patterns_regex.dictReVerbPatterns,
					dict_openie_config = dictOpenIEConfig )
				dictSentTreesReVerb[strURI] = listSentTreeAnnotated

			# debug
			'''
			logger.info( 'SENTS (in-memory without escaping)' )
			for strURI in dictSentTrees :
				for treeSent in dictSentTrees[strURI] :
					logger.info( unicode( treeSent ) )
			'''

			#
			# ReVerb output + lexicon -> Seed tuples
			#

			#
			# extract argument and relation tuples and generate valid {arg,rel,arg} -> seed_tuples
			#
			listSeedTuplesTotal = []
			for strURI in dictSentTrees :
				listSentExtractions = openiepy.comp_sem_lib.extract_annotations_from_sents(
					list_sent_trees = dictSentTreesReVerb[strURI],
					set_annotations = set( fact_extraction_patterns_regex.listReVerbExecutionOrder ),
					dict_openie_config = dictOpenIEConfig )

				listSeedTuples = openiepy.comp_sem_lib.get_seed_tuples_from_extractions(
					list_sent_extractions = listSentExtractions,
					set_sequences = fact_extraction_patterns_regex.setSeedTuples,
					dict_openie_config = dictOpenIEConfig )

				listSeedTuplesTotal.extend( listSeedTuples )

			# make a set to remove any duplicates
			setSeedTuplesTotal = set( listSeedTuplesTotal )

			# write seeds to file
			writeHandle = codecs.open( strOutputFileSeeds, 'w', 'utf-8', errors = 'replace' )
			writeHandle.write( 'SEED TUPLES (unfiltered)' )
			for tupleSeed in setSeedTuplesTotal :
				writeHandle.write( repr(tupleSeed) + '\n' )

			# TODO consider filtering using intel analysis seed vocab (e.g. flooding and target location list) - need to think it through

			#
			# Dependency graphs
			#

			#dictDepGraphs = dependancy_parse_sents( dictSentTrees, dictOpenIEConfig )

			# dependancy parse tagged sents
			dictDepGraphs = openiepy.comp_sem_lib.parse_sent_trees_batch(
				dict_doc_sent_trees = dictSentTrees,
				dep_parser = dep_parser,
				dict_custom_pos_mappings = fact_extraction_patterns_regex.dictTagDependancyParseMapping,
				max_processes = nProcessMax,
				dict_openie_config = dictOpenIEConfig )


			#
			# create open extraction templates
			#

			# create extraction templates based on a random subset of the whole data (can be all of it if training data is small)
			setRandomSubsetURI = set([])
			listURI = dictDepGraphs.keys()
			for nRandomSample in range(nRandomSubsetTraining) :
				nIndexRnd = random.randint( 0,len(listURI)-1 )
				setRandomSubsetURI.add( listURI.pop(nIndexRnd) )
				if len(listURI) == 0 :
					break

			dictRandomSubsetGraphs = {}
			for strURI in setRandomSubsetURI :
				dictRandomSubsetGraphs[strURI] = dictDepGraphs[strURI]

			# extract from corpus all sents where a seed_tuple exists somewhere in sent structure, but without any constraint on lexical position -> training_sents
			listOpenExtractionPatternsTotal= openiepy.comp_sem_lib.generate_open_extraction_templates_batch(
				seed_tuples = setSeedTuplesTotal,
				dict_document_sent_graphs = dictRandomSubsetGraphs,
				dict_seed_to_template_mappings = fact_extraction_patterns_regex.dictSeedToTemplateMapping,
				list_context_dep_types = fact_extraction_patterns_regex.listContextualDepTypes,
				max_processes = nProcessMax,
				longest_dep_path = 15,
				dict_openie_config = dictOpenIEConfig )

			'''
			# extract from corpus all sents where a seed_tuple exists somewhere in sent structure, but without any constraint on lexical position -> training_sents
			listOpenExtractionPatternsTotal = []
			for strURI in setRandomSubsetURI :
				logger.info( 'generating from ' + strURI )

				listSentGraphs = dictDepGraphs[ strURI ]
				listPatterns = openiepy.comp_sem_lib.generate_open_extraction_templates(
					seed_tuples = setSeedTuplesTotal,
					corpus_sent_graphs = listSentGraphs,
					dict_seed_to_template_mappings = fact_extraction_patterns_regex.dictSeedToTemplateMapping,
					list_context_dep_types = fact_extraction_patterns_regex.listContextualDepTypes,
					longest_dep_path = 15,
					dict_openie_config = dictOpenIEConfig )
				listOpenExtractionPatternsTotal.extend( listPatterns )
			'''

			listOpenExtractionPatternsBeforeNormalization = copy.deepcopy( listOpenExtractionPatternsTotal )

			# debug
			'''
			logger.info( 'SPECIFIC PATTERNS' )
			for strPattern in listOpenExtractionPatternsTotal :
				logger.info( repr(strPattern) )
			'''

			listOpenExtractionPatternsTotal = openiepy.comp_sem_lib.normalize_open_extraction_templates(
				list_patterns = listOpenExtractionPatternsTotal,
				topN = nTargetExtractionTemplates,
				dict_openie_config = dictOpenIEConfig )

			# debug
			'''
			logger.info( 'NORMALIZED PATTERNS' )
			for strPattern in listOpenExtractionPatternsTotal :
				logger.info( repr(strPattern) )
			'''

			# write open pattern templates to disk
			logger.info( 'writing open extraction templates to file ' + strTemplateFile )
			writeHandle = codecs.open( strTemplateFile, 'w', 'utf-8', errors = 'replace' )
			for strPattern in listOpenExtractionPatternsTotal :
				writeHandle.write( strPattern + '\n' )
			writeHandle.close()


		# load pre-trained extractions from disk into memory ready for use
		logger.info( 'reading open extraction templates from file ' + strTemplateFile )
		readHandle = codecs.open( strTemplateFile, 'r', 'utf-8', errors = 'replace' )
		listLines = readHandle.readlines()
		readHandle.close()

		listOpenExtractionPatternsTotal = []
		for strLine in listLines :
			listOpenExtractionPatternsTotal.append( strLine.strip() )

		# parse open pattern templates 
		listParsedExtractionPatterns = []
		for strPattern in listOpenExtractionPatternsTotal :
			listParsedExtractionPatterns.append( openiepy.comp_sem_lib.parse_extraction_pattern( str_pattern = strPattern, dict_openie_config = dictOpenIEConfig ) )






		#
		# polling loop to select new files. assumption is that a file is *moved* into polling directory. this avoids partially written files and the possibility of files being updates later (which complicates polling checks a lot)
		# if input folder is not specified then this loop has 1 iteration only
		#

		logger.info( 'checking for files to process (will poll input dir or load a specific file)' )

		nTimeSinceEpochLastChecked = None
		bAbort = False
		while( bAbort == False ) :

			listFilesToProcess = []
			if len(strInputFolder) == 0 :
				# process a single file then abort
				listFilesToProcess.append( strInputFile )
				bAbort = True

			else :

				nTimeSinceEpochLatest = None

				# find any file that has a changed timestamp younger than date of last check
				for strFileName in os.listdir( strInputFolder ) :

					# get number of seconds from epoch of 'last modified' time
					# note: round to number of seconds as different OS may or may not have a 1 second resolution
					nTimeSinceEpoch = os.path.getmtime( os.path.join( strInputFolder, strFileName ) )
					nTimeSinceEpoch = math.floor( nTimeSinceEpoch )

					if nTimeSinceEpochLastChecked == None :
						listFilesToProcess.append( os.path.join( strInputFolder, strFileName ) )

						# keep track of file timestamp of last check (so we dont load same files again)
						if (nTimeSinceEpochLatest == None) or (nTimeSinceEpochLatest < nTimeSinceEpoch) :
							nTimeSinceEpochLatest = nTimeSinceEpoch

					else :
						if nTimeSinceEpochLastChecked < nTimeSinceEpoch :
							listFilesToProcess.append( os.path.join( strInputFolder, strFileName ) )

							# keep track of file timestamp of last check (so we dont load same files again)
							if (nTimeSinceEpochLatest == None) or (nTimeSinceEpochLatest < nTimeSinceEpoch) :
								nTimeSinceEpochLatest = nTimeSinceEpoch

				# update last checked time so we do not process a file twice
				if nTimeSinceEpochLatest != None :
					nTimeSinceEpochLastChecked = nTimeSinceEpochLatest

			# specify next polling date
			dateNextCheck = datetime.datetime.now() + datetime.timedelta( seconds = nPollFreq )

			# process each file one by one
			for strFileToProcess in listFilesToProcess :

				#
				# read JSON tweets from disk
				#

				logger.info( 'reading file : ' + strFileToProcess )

				# parse JSON from SPARQL
				dictText = {}
				dictTimestamp = {}
				socialMediaParser = soton_corenlppy.SocialMediaParser.SocialMediaParser( logger )

				# read input data
				readHandle = codecs.open( strFileToProcess, 'r', 'utf-8', errors = 'replace' )
				listLines = readHandle.readlines()
				readHandle.close()

				for strLine in listLines :
					if len(strLine.strip()) == 0 :
						continue
					elif strLine.startswith( '#' ) :
						continue
					else :
						#logger.info( repr(strLine.strip()) )
						jsonObj = json.loads( strLine.strip(), encoding = 'utf-8' )

						strSocialMediaType = socialMediaParser.detect_social_media_type( jsonObj )
						if strSocialMediaType != 'twitter' :
							raise Exception( 'post not a Tweet (unknown JSON structure)' )

						strURI = socialMediaParser.get_source_uri( jsonObj, strSocialMediaType )

						dateTimestamp = socialMediaParser.get_timestamp( jsonObj, strSocialMediaType )
						dictTimestamp[ strURI ] = dateTimestamp

						strUTF8Text = socialMediaParser.get_text( jsonObj, strSocialMediaType )
						dictText[ strURI ] = strUTF8Text

				logger.info( 'Number of URIs in corpus = ' + str(len(dictText.keys())) )

				#
				# POS tagging
				#

				dictTaggedSents = pos_tag_sents( dictText, nSentMax, dictOpenIEConfig )

				# serialize output (POS)
				logger.info( 'POS tagged sent file: ' + strOutputFilePOS )
				writeHandle = codecs.open( strOutputFilePOS, 'w', 'utf-8', errors = 'replace' )
				for strURI in dictTaggedSents :
					writeHandle.write( 'URI\n' )
					writeHandle.write( strURI + '\n' )
					writeHandle.write( 'TEXT\n' )
					writeHandle.write( dictText[strURI] + '\n' )
					writeHandle.write( 'TAGGED SENT\n' )
					for listSent in dictTaggedSents[strURI] :
						writeHandle.write( soton_corenlppy.common_parse_lib.serialize_tagged_list( list_pos = listSent, dict_common_config = dictOpenIEConfig ) + '\n' )
				writeHandle.close()

				# create a set of sent trees
				dictSentTrees = {}
				for strURI in dictTaggedSents :
					dictSentTrees[strURI] = []
					for listSentTagged in dictTaggedSents[strURI] :
						listSentTrees = soton_corenlppy.common_parse_lib.create_sent_trees( list_pos = listSentTagged, dict_common_config = dictOpenIEConfig )
						dictSentTrees[strURI].extend( listSentTrees )

						# debug
						'''
						for treeSent in listSentTrees :
							logger.info( unicode( treeSent ) )
						'''

				'''
				#
				# annotate ReVerb argument and relations -> seed_tuples
				#
				dictSentTreesReVerb = {}
				for strURI in dictSentTrees :
					listSentTreeAnnotated = openiepy.comp_sem_lib.annotate_using_pos_patterns(
						list_sent_trees = dictSentTrees[strURI],
						list_phrase_sequence_patterns_exec_order = fact_extraction_patterns_regex.listReVerbExecutionOrder,
						dict_phrase_sequence_patterns = fact_extraction_patterns_regex.dictReVerbPatterns,
						dict_openie_config = dictOpenIEConfig )
					dictSentTreesReVerb[strURI] = listSentTreeAnnotated

				# debug
				logger.info( 'SENTS (in-memory without escaping)' )
				for strURI in dictSentTrees :
					for treeSent in dictSentTrees[strURI] :
						logger.info( unicode( treeSent ) )

				#
				# ReVerb output + lexicon -> Seed tuples
				#

				#
				# extract argument and relation tuples and generate valid {arg,rel,arg} -> seed_tuples
				#
				listSeedTuplesTotal = []
				for strURI in dictSentTrees :
					listSentExtractions = openiepy.comp_sem_lib.extract_annotations_from_sents(
						list_sent_trees = dictSentTreesReVerb[strURI],
						set_annotations = set( fact_extraction_patterns_regex.listReVerbExecutionOrder ),
						dict_openie_config = dictOpenIEConfig )

					listSeedTuples = openiepy.comp_sem_lib.get_seed_tuples_from_extractions(
						list_sent_extractions = listSentExtractions,
						set_sequences = fact_extraction_patterns_regex.setSeedTuples,
						dict_openie_config = dictOpenIEConfig )

					listSeedTuplesTotal.extend( listSeedTuples )

				# make a set to remove any duplicates
				setSeedTuplesTotal = set( listSeedTuplesTotal )

				# write seeds to file
				writeHandle = codecs.open( strOutputFileSeeds, 'w', 'utf-8', errors = 'replace' )
				writeHandle.write( 'SEED TUPLES (unfiltered)' )
				for tupleSeed in setSeedTuplesTotal :
					writeHandle.write( repr(tupleSeed) + '\n' )

				# TODO consider filtering using intel analysis seed vocab (e.g. flooding and target location list) - need to think it through

				'''

				#
				# Dependency graphs
				#

				#dictDepGraphs = dependancy_parse_sents( dictSentTrees, dictOpenIEConfig )

				# dependancy parse tagged sents
				dictDepGraphs = openiepy.comp_sem_lib.parse_sent_trees_batch(
					dict_doc_sent_trees = dictSentTrees,
					dep_parser = dep_parser,
					dict_custom_pos_mappings = fact_extraction_patterns_regex.dictTagDependancyParseMapping,
					max_processes = nProcessMax,
					dict_openie_config = dictOpenIEConfig )


				'''
				# get dependency parser
				dep_parser = openiepy.comp_sem_lib.get_dependency_parser( dict_openie_config = dictOpenIEConfig )

				# dependancy parse tagged sents
				# we do them all here as we want to do open extraction on them all eventually
				dictDepGraphs = {}
				for strURI in dictSentTrees :

					# flatten the sents (POS pattern phrases prior to ReVerb annotations) to become a list of POS tagged phrases. this is needed as the dependancy parser works on a tagged list of tokens i.e. not a sent tree
					listTaggedSentsDepParse = []
					for nIndexSent in range(len(dictSentTrees[strURI])) :
						treeFlat = soton_corenlppy.common_parse_lib.flattern_sent( tree_sent = dictSentTrees[strURI][nIndexSent], dict_common_config = dictOpenIEConfig )
						listTaggedSentsDepParse.append( treeFlat.pos() )

					# debug
					logger.info( 'FLATTENED SENTS' )
					for listSent in listTaggedSentsDepParse :
						logger.info( repr(listSent) )

					# replace any non-Stanford POS tags with an equivilent so the dependency parse is as good as it can be, and replace spaces with '_' in tokens (if phrases are allowed) as dep parser expects unigram tokens
					openiepy.comp_sem_lib.prepare_tags_for_dependency_parse(
						list_tagged_sents = listTaggedSentsDepParse,
						dict_custom_pos_mappings = fact_extraction_patterns_regex.dictTagDependancyParseMapping,
						dict_openie_config = dictOpenIEConfig )

					sentDepGraphs = dep_parser.tagged_parse_sents( sentences = listTaggedSentsDepParse )
					logger.info( 'parsing ' + strURI )

					listSentGraphs = []
					for depGraphIter in sentDepGraphs :
						# tagged_parse_sents() returns an iterator for some reason so just get graph and break
						for depObj in depGraphIter :
							listSentGraphs.append( depObj )

							# draw graph for presentations (disable normally). will block wait until window is closed
							# depObj.tree().draw()

							break

					dictDepGraphs[ strURI ] = listSentGraphs
				'''


				'''
				#
				# create open extraction templates
				#

				# extract from corpus all sents where a seed_tuple exists somewhere in sent structure, but without any constraint on lexical position -> training_sents
				listOpenExtractionPatternsTotal = []
				for strURI in dictDepGraphs :
					logger.info( 'generating from ' + strURI )

					listSentGraphs = dictDepGraphs[ strURI ]
					listPatterns = openiepy.comp_sem_lib.generate_open_extraction_templates(
						seed_tuples = setSeedTuplesTotal,
						corpus_sent_graphs = listSentGraphs,
						dict_seed_to_template_mappings = fact_extraction_patterns_regex.dictSeedToTemplateMapping,
						list_context_dep_types = fact_extraction_patterns_regex.listContextualDepTypes,
						longest_dep_path = 20,
						dict_openie_config = dictOpenIEConfig )
					listOpenExtractionPatternsTotal.extend( listPatterns )

				listOpenExtractionPatternsBeforeNormalization = copy.deepcopy( listOpenExtractionPatternsTotal )

				# debug
				logger.info( 'SPECIFIC PATTERNS' )
				for strPattern in listOpenExtractionPatternsTotal :
					logger.info( repr(strPattern) )

				listOpenExtractionPatternsTotal = openiepy.comp_sem_lib.normalize_open_extraction_templates(
					list_patterns = listOpenExtractionPatternsTotal,
					dict_openie_config = dictOpenIEConfig )

				# debug
				logger.info( 'NORMALIZED PATTERNS' )
				for strPattern in listOpenExtractionPatternsTotal :
					logger.info( repr(strPattern) )

				# parse open pattern templates 
				listParsedExtractionPatterns = []
				for strPattern in listOpenExtractionPatternsTotal :
					listParsedExtractionPatterns.append( openiepy.comp_sem_lib.parse_extraction_pattern( str_pattern = strPattern, dict_openie_config = dictOpenIEConfig ) )

				# debug
				for entry in listParsedExtractionPatterns :
					logger.info( repr(entry) )
				'''

				#
				# execute open extraction templates -> extractions
				#

				# execute open pattern templates on the test corpus
				dictExtractedVarsUnfiltered = openiepy.comp_sem_lib.match_extraction_patterns_batch(
					dict_document_sent_graphs = dictDepGraphs,
					list_extraction_patterns = listParsedExtractionPatterns,
					dict_collapse_dep_types = fact_extraction_patterns_regex.dictCollapseDepTypes,
					max_processes = nProcessMax,
					dict_openie_config = dictOpenIEConfig )

				# filter extractions to avoid variable subsumption
				dictExtractedVars = {}
				for strURI in dictDepGraphs :
					for nSentIndex in range(len(dictExtractedVarsUnfiltered[strURI])) :

						listMatches = dictExtractedVarsUnfiltered[strURI][nSentIndex]

						listMatches = openiepy.comp_sem_lib.filter_extractions(
							list_extractions = listMatches,
							dict_openie_config = dictOpenIEConfig )

						if not strURI in dictExtractedVars :
							dictExtractedVars[strURI] = []
						dictExtractedVars[strURI].append( listMatches )


				'''
				# execute open pattern templates on the test corpus
				dictExtractedVars = {}
				dictExtractedVarsUnfiltered = {}
				for strURI in dictDepGraphs :
					logger.info( 'matching for ' + strURI )

					dictExtractedVars[strURI] = []
					dictExtractedVarsUnfiltered[strURI] = []

					listSentGraphs = dictDepGraphs[strURI]

					for nSentIndex in range(len(listSentGraphs)) :

						# generate extractions
						listMatches = openiepy.comp_sem_lib.match_extraction_patterns(
							dep_graph = listSentGraphs[nSentIndex],
							list_extraction_patterns = listParsedExtractionPatterns,
							dict_collapse_dep_types = fact_extraction_patterns_regex.dictCollapseDepTypes,
							dict_openie_config = dictOpenIEConfig )

						dictExtractedVarsUnfiltered[strURI].append( listMatches )

						# filter extractions to avoid subsumption (will keep largest versions)
						listMatches = openiepy.comp_sem_lib.filter_extractions(
							list_extractions = listMatches,
							dict_openie_config = dictOpenIEConfig )
			
						dictExtractedVars[strURI].append( listMatches )
				'''

				'''
				# debug
				logger.info( 'EXTRACTIONS (unfiltered)' )
				for strURI in dictDepGraphs :
					for nSentIndex in range(len(dictExtractedVarsUnfiltered[strURI])) :
						for nMatchIndex in range(len(dictExtractedVarsUnfiltered[strURI][nSentIndex])) :
							strPrettyText = openiepy.comp_sem_lib.pretty_print_extraction(
								list_extracted_vars = dictExtractedVarsUnfiltered[strURI][nSentIndex][nMatchIndex],
								dep_graph = dictDepGraphs[strURI][nSentIndex],
								set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
								style = 'highlighted_vars',
								dict_openie_config = dictOpenIEConfig )
							logger.info( strPrettyText )
				'''

				'''
				# debug
				logger.info( 'EXTRACTIONS' )
				for strURI in dictDepGraphs :
					for nSentIndex in range(len(dictExtractedVars[strURI])) :
						for nMatchIndex in range(len(dictExtractedVars[strURI][nSentIndex])) :
							strPrettyText = openiepy.comp_sem_lib.pretty_print_extraction(
								list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
								dep_graph = dictDepGraphs[strURI][nSentIndex],
								set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
								style = 'highlighted_vars',
								dict_openie_config = dictOpenIEConfig )
							logger.info( strPrettyText )
				'''

				# serialize output (extracted vars)
				logger.info( 'Extracted variables file: ' + strOutputFileExtraction )
				writeHandle = codecs.open( strOutputFileExtraction, 'w', 'utf-8', errors = 'replace' )

				writeHandle.write( '\nALL EXTRACTS (unfiltered)\n' )
				for strURI in dictDepGraphs :
					for nSentIndex in range(len(dictExtractedVarsUnfiltered[strURI])) :

						for nMatchIndex in range(len(dictExtractedVarsUnfiltered[strURI][nSentIndex])) :
							strPrettyText = openiepy.comp_sem_lib.pretty_print_extraction(
								list_extracted_vars = dictExtractedVarsUnfiltered[strURI][nSentIndex][nMatchIndex],
								dep_graph = dictDepGraphs[strURI][nSentIndex],
								set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
								style = 'highlighted_vars',
								dict_openie_config = dictOpenIEConfig )

							writeHandle.write( '\t' + strPrettyText + '\n' )

				writeHandle.write( '\nALL EXTRACTS (filtered)\n' )
				for strURI in dictDepGraphs :
					for nSentIndex in range(len(dictExtractedVars[strURI])) :

						for nMatchIndex in range(len(dictExtractedVars[strURI][nSentIndex])) :
							strPrettyText = openiepy.comp_sem_lib.pretty_print_extraction(
								list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
								dep_graph = dictDepGraphs[strURI][nSentIndex],
								set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
								style = 'highlighted_vars',
								dict_openie_config = dictOpenIEConfig )

							writeHandle.write( '\t' + strPrettyText + '\n' )

				writeHandle.write( '\nPER URI RESULTS\n' )
				writeHandle.write( '---------------\n' )

				for strURI in dictDepGraphs :
					listTaggedSents = dictTaggedSents[strURI]
					listSentGraphs = dictDepGraphs[strURI]
					listSentVars = dictExtractedVars[strURI]

					writeHandle.write( '\nURI\n' )
					writeHandle.write( strURI + '\n' )

					writeHandle.write( '\nTEXT\n' )
					writeHandle.write( dictText[strURI] + '\n' )

					writeHandle.write( '\EXTRACTS\n' )
					for nSentIndex in range(len(dictExtractedVars[strURI])) :

						for nMatchIndex in range(len(dictExtractedVars[strURI][nSentIndex])) :

							strPrettyText = openiepy.comp_sem_lib.pretty_print_extraction(
								list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
								dep_graph = dictDepGraphs[strURI][nSentIndex],
								set_var_types = set( fact_extraction_patterns_regex.setGraphDepTypes ),
								style = 'highlighted_vars',
								dict_openie_config = dictOpenIEConfig )

							writeHandle.write( '>> ' + strPrettyText + '\n' )

							listVars = openiepy.comp_sem_lib.get_extraction_vars(
								list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
								dict_openie_config = dictOpenIEConfig )
							for ( strVar, strType ) in listVars :
								if strType != 'slot' :
									tuplePrettyVar = openiepy.comp_sem_lib.pretty_print_extraction_var(
										list_extracted_vars = dictExtractedVars[strURI][nSentIndex][nMatchIndex],
										dep_graph = dictDepGraphs[strURI][nSentIndex],
										var_name = strVar,
										dict_openie_config = dictOpenIEConfig )
									if tuplePrettyVar[0] != None :
										writeHandle.write( '\t' + strVar + ' = ' + tuplePrettyVar[0] + ' [' + repr(tuplePrettyVar[1]) + ']' )
									if tuplePrettyVar[2] == True :
										writeHandle.write( ' negated' )
									writeHandle.write( ' with links ' + repr(tuplePrettyVar[3]) )
									writeHandle.write( '\n' )

					writeHandle.write( '\nTAG\n' )
					for listSent in dictTaggedSents[strURI] :
						writeHandle.write( soton_corenlppy.common_parse_lib.serialize_tagged_list( list_pos = listSent, dict_common_config = dictOpenIEConfig ) + '\n' )

					writeHandle.write( '\nGRAPH\n' )
					for depObj in dictDepGraphs[strURI] :
						writeHandle.write( depObj.to_dot() + '\n' )

				writeHandle.close()

				# publish data to database (posts and extracts)
				datePublished = datetime.datetime.now()
				insert_posts_and_extracts_to_database( dictDepGraphs, dictText, dictTimestamp, dictExtractedVars, sitAssessHandlerPost, sitAssessHandlerExt, dictOpenIEConfig )

				# annotate extracts according to the current lexicon (only extracts we have just published)
				global_controlMessageHandler.global_vocabulary_lock.acquire()
				try :
					annotate_extracts_in_database( sitAssessHandlerExt, dictOpenIEConfig, global_controlMessageHandler.dictLexiconPhrase, global_controlMessageHandler.dictLexiconURI, stemmer, datePublished )
				finally :
					global_controlMessageHandler.global_vocabulary_lock.release()

			# check if vocab has changed. if so delete all extract annotations so far and re-compute them all
			if global_controlMessageHandler.global_new_vocabulary == True :

				logger.info( 'recomputing annotations due to a change in vocabulary' )

				global_controlMessageHandler.global_vocabulary_lock.acquire()
				try :
					# reset flag
					global_controlMessageHandler.global_new_vocabulary = False

					# delete annotations
					sitAssessHandlerExt.delete_annotations()

					# reset published date so all posts are re-computed
					datePublished = datetime.datetime.now() - datetime.timedelta( days = 100*365 )

					# annotate extracts according to the current lexicon (ones we have just added)
					annotate_extracts_in_database( sitAssessHandlerExt, dictOpenIEConfig, global_controlMessageHandler.dictLexiconPhrase, global_controlMessageHandler.dictLexiconURI, stemmer, datePublished )

				finally :
					global_controlMessageHandler.global_vocabulary_lock.release()



			# polling pause (if not already taken too long)
			if len(strInputFolder) != 0 :
				timeDelta = dateNextCheck - datetime.datetime.now()
				if timeDelta.total_seconds() > 0 :
					time.sleep( timeDelta.total_seconds() )


		#
		# shutdown
		#

		logger.info( 'closing RabbitMQ' )
		# stop rabbitmq consumer
		if global_rabbitmqConsumerHandler != None :
			try :
				if global_rabbitmqConsumerHandler.channel != None :
					global_rabbitmqConsumerHandler.channel.stop_consuming()
			except :
				logger.info('stop consumer failed')
			global_rabbitmqConsumerHandler.disconnect()
			global_rabbitmqConsumerHandler = None

		logger.info( 'joining with consumer thread' )

		if (theadConsumer != None) and (global_consumerFlag == True) :
			theadConsumer.join()
			theadConsumer = None
		logger.info( 'RabbitMQ consumer closed' )

		# close database connection
		if sitAssessHandlerPost != None :
			sitAssessHandlerPost.close_db()
			sitAssessHandlerPost = None

		# close database connection
		if sitAssessHandlerExt != None :
			sitAssessHandlerExt.close_db()
			sitAssessHandlerExt = None
		logger.info( 'Database handles closed' )

	except :
		logger.exception( 'fact_extraction_app main() exception' )
		sys.stderr.flush()
		sys.stdout.flush()

		# close file
		if readHandle != None :
			readHandle.close()
		if writeHandle != None :
			writeHandle.close()
		logger.info( 'closed file handles' )

		# stop rabbitmq consumer
		if global_rabbitmqConsumerHandler != None :
			global_rabbitmqConsumerHandler.disconnect()
			global_rabbitmqConsumerHandler = None

		if (theadConsumer != None) and (global_consumerFlag == True) :
			theadConsumer.join()
			theadConsumer = None
		logger.info( 'closed rabbitmq handles' )

		# close database
		if sitAssessHandlerPost != None :
			sitAssessHandlerPost.close_db()
		if sitAssessHandlerExt != None :
			sitAssessHandlerExt.close_db()
		logger.info( 'closed database handles' )

		sys.stdout.flush()

	# all done
	logger.info('finished')
	sys.stdout.flush()
