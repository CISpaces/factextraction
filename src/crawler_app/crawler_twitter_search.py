# !/usr/bin/env python
# -*- coding: utf-8 -*-

"""
..
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
	// Created By : Stuart E. Middleton
	// Created Date : 2017/11/14
	// Created for Project: IntelAnalysis-DSTL
	//
	/////////////////////////////////////////////////////////////////////////
	//
	// Dependancies: Source code adapted from REVEAL project social media client framework code
	//
	/////////////////////////////////////////////////////////////////////////
	'''

Crawler app to crawl OSINT sources (e.g. Twitter) and output JSON formatted content files.

"""

import logging,os,sys,time,multiprocessing,json,Queue
import adaptive_crawlpy, soton_corenlppy
from adaptive_crawlpy.SourceFactory import SourceFactory

################################
# main
################################

# only execute if this is the main file
if __name__ == '__main__':

	strConfigFile = None
	sourceObj = None

	#
	# check args
	#
	if len(sys.argv) < 2:
		print 'Usage: crawl_twitter_search.py <config file>\n'
		sys.stdout.flush()
		sys.exit(1)

	if not os.path.isfile(sys.argv[1]):
		print '<config file> ' + sys.argv[1] + ' does not exist\n'
		sys.stdout.flush()
		sys.exit(1)
	else:
		strConfigFile = sys.argv[1]

	# make logger (global to STDOUT)
	LOG_FORMAT = '%(asctime)s : %(message)s'
	logger = logging.getLogger(__name__)
	logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)
	logger.info('logging started')

	try:
		# load config
		logger.info('loading config')
		dictConfig = soton_corenlppy.config_helper.read_config( strConfigFile )

		strSourceID = dictConfig['source_id']
		dictCrawlSpec = dictConfig['crawl_spec_search']


		# get adaptive_crawl config (file)
		dictAdaptiveCrawlConfig = adaptive_crawlpy.adaptive_crawl_lib.get_adaptive_crawl_config(
			source_id = strSourceID,
			blacklist = [ '@stuart_e_middle' ],
			logger = logger,
			output_type = 'file',
			output_param = ( dictCrawlSpec['output_path'], dictCrawlSpec['output_prefix'] )
			)

		# create factory class
		factoryObj = SourceFactory(
			dict_adaptive_crawl_config = dictAdaptiveCrawlConfig
			)

		# init source
		# query spec: https://twitter.com/search-home > click operators
		# see https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets.html
		sourceObj = factoryObj.get_source( source_type = 'twitter_search' )

		# start a crawl
		sourceObj.start(
			key = dictConfig['twitter_api_key'],
			key_secret = dictConfig['twitter_api_key_secret'],
			token = dictConfig['twitter_api_token'],
			token_secret = dictConfig['twitter_api_token_secret'],
			url_params = dictCrawlSpec['query'],
			max_results = dictCrawlSpec['max_results'],
			)

		# wait for process to finish
		bStopped = False
		while bStopped == False :
			dictStatus = sourceObj.get_status()
			if dictStatus['status'] in [ 'finished', 'failed' ] :
				bStopped = True
			else :
				time.sleep(1)

		dictStatus = sourceObj.get_status()
		logger.info( 'final status = ' + repr(dictStatus) )

	except :
		logger.exception('crawl_twitter_search main() exception')

	finally :
		# stop the source
		if sourceObj != None :
			sourceObj.stop()
			time.sleep(2)

	# all done
	logger.info('finished')

