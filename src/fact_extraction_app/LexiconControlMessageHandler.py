'''
/////////////////////////////////////////////////////////////////////////
//
// (c) University of Southampton IT Innovation, 2017
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
//    Created Date :    2017/10/16
//    Created for Project:    IntelAnalysisDSTL
//
/////////////////////////////////////////////////////////////////////////
//
// Dependancies: None
//
/////////////////////////////////////////////////////////////////////////
'''

import datetime, logging, copy, json, subprocess, threading
import pika
import RabbitMQHandler

class LexiconControlMessageHandler( pika.BlockingConnection ) :

	def __init__( self, dictConfig ) :

		self.dictConfig = dictConfig

		# new vocabulary flag
		self.global_vocabulary_lock = threading.Lock()
		self.global_new_vocabulary = False
		self.dictLexiconPhrase = {}
		self.dictLexiconURI = {}

		# read Rabbitmq details and create new connection
		self.strRmqHost = dictConfig[ 'rmq_host' ]
		self.nRmqPort = int( dictConfig[ 'rmq_port' ] )
		self.strRmqUser = dictConfig[ 'rmq_username' ]
		self.strRmqPass = dictConfig[ 'rmq_password' ]
		self.listConnParams = dictConfig[ 'rmq_connection_parameters_python' ]

		# read rabbitmq exchange, routing and queue parameters
		self.strRmqExchangeType = dictConfig[ 'rmq_exchange_type' ]
		self.strExchangeName = dictConfig[ 'rmq_exchange_name' ]
		self.strRouting = dictConfig[ 'rmq_routing' ]

	def handleDelivery( self, channel, method_frame, header_frame, body ) :

		# debug
		self.dictConfig['logger'].info( 'RabbitMQ subscriber message received' )
		self.dictConfig['logger'].info( 'FRAME: ' + repr( method_frame.delivery_tag ) )
		if header_frame.timestamp != None :
			dateTimestamp = datetime.datetime( 1970,1,1,0,0,0 ) + datetime.timedelta( seconds=header_frame.timestamp )
			self.dictConfig['logger'].info( 'HEAD: timestamp = ' + repr( dateTimestamp ) )
		else :
			self.dictConfig['logger'].info( 'HEAD: timestamp = None' )

		self.dictConfig['logger'].info( 'HEAD: content_type = ' + repr( header_frame.content_type ) )
		self.dictConfig['logger'].info( 'HEAD: content_encoding = ' + repr( header_frame.content_encoding ) )
		self.dictConfig['logger'].info( 'BODY: ' + repr( body ) )

		# check MIME TYPE
		if header_frame.content_type != 'application/json' :
			self.dictConfig['logger'].warn( 'REJECTED: unknown MIME TYPE (ignored)' )
			return

		else :
			# parse JSON message
			try :
				jsonObject = json.loads( body, encoding = 'utf-8' )
			except :
				self.dictConfig['logger'].warn( 'REJECTED: JSON parse error : ' + repr(body) )
				return

			if not 'phrase_mapping' in jsonObject :
				self.dictConfig['logger'].warn( 'REJECTED: missing key phrase_mapping' )
				return

			if not 'lexicon' in jsonObject :
				self.dictConfig['logger'].warn( 'REJECTED: missing key lexicon' )
				return

			self.global_vocabulary_lock.acquire()
			try :

				# parse vocabulary
				self.dictLexiconPhrase = jsonObject['phrase_mapping']
				self.dictLexiconURI = jsonObject['lexicon']

				# make sets as JSON only supports lists
				for strURI in self.dictLexiconPhrase :
					self.dictLexiconPhrase[strURI] = set( self.dictLexiconPhrase[strURI] )

				# set flag so new vocab gets processed by main thread polling loop
				self.global_new_vocabulary = True

				self.dictConfig['logger'].info( 'ACCEPTED: new vocabulary' )

			finally :
				self.global_vocabulary_lock.release()

		# acknowledge the message has been consumed
		# removed as not needed (and actually causes errors to client which does not expect an acknowledgement)
		# channel.basic_ack( delivery_tag=method_frame.delivery_tag )

		# all done (success)
		return
