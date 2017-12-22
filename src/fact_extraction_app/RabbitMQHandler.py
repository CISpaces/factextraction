'''
/////////////////////////////////////////////////////////////////////////
//
// \xa9 University of Southampton IT Innovation, 2014
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
//	Created By :	Stuart E. Middleton
//	Created Date :	2014/04/23
//	Created for Project:	REVEAL
//
/////////////////////////////////////////////////////////////////////////
//
// Dependancies: None
//
/////////////////////////////////////////////////////////////////////////
'''

# !/usr/bin/env python

"""
RabbitMQ handler class
- broker connection setup (BlockingConnection)
- channel allocation
- basic_publish
- basic_consume

note: Applications can subclass this to implement other RabbitMQ connection types and behaviours

Pika information on RabbitMQ connections and channels
- http://pika.readthedocs.org/en/latest/modules/parameters.html#pika.connection.URLParameters

"""

import traceback, logging, datetime, urllib, sys, time
import pika

#
# RabbitMQ handler class to allow connection, publish and subscribe methods
# There is a single channel per connection supported to simply the reconnection handling on timeouts
# note: pika is not thread safe so do not share RabbitMQHandler instances between threads (make completely new connections)
#
class RabbitMQHandler( object ) :

	#
	# constructor - registers the RabbitMQ broker details ready for use later
	# note: for query parameters see http://pika.readthedocs.org/en/latest/modules/parameters.html#pika.connection.URLParameters
	# note: useful connection parameters are below
	#       connection_attempts=3    ==> number of connection attempts before giving up (and throwing an exception)
	#       retry_delay=1            ==> seconds delay between connection attempts
	#       heartbeat_interval=3600  ==> seconds between heartbeats
	#       socket_timeout=0.25      ==> seconds (default is 0.25)
	#       ssl_options ==> RabbitMQ supports SSL - read documentation on how to do this however (not tested with this class)
	# note: URL encoding of query parameters is automatically applied so provide unencoded parameters 
	# strUser = RabbitMQ broker username (str)
	# strPass = users password (str)
	# strHost = RabbitMQ broker hostname (str)
	# nPort = RabbitMQ broker port (int)
	# virtual_host = virtual host (default is /) e.g. '/mybroker' (str)
	# query_params = optional list of 2d tuples (can be None) e.g. [('connection_attempts',3),('retry_delay',1),('heartbeat_interval',3600)] (list)
	# logger = logger to use (None will default to root logger)
	#
	def __init__( self, strUser, strPass, strHost, nPort, virtual_host = '/', query_params = None, logger = None ) :
		
		if not isinstance(strUser,str) or (len(strUser) < 1) :
			raise Exception( 'invalid username [' + repr(strUser) + ']' )
		if not isinstance( strPass,str ) :
			raise Exception( 'invalid password [None]' )
		if not isinstance(strHost,str) or (len(strHost) < 1) :
			raise Exception( 'invalid hostname [' + repr(strHost) + ']' )
		if not isinstance(nPort,int) or (nPort < 1) :
			raise Exception( 'invalid port [' + repr(nPort) + ']' )
		if not isinstance(virtual_host,str) :
			raise Exception( 'invalid virtual_host [' + repr(virtual_host) + ']' )

		# create a connection URL for use with pika.URLParameters
		# making sure the propper path escaping and param encoding is performed
		strURL = 'amqp://' + strUser + ':' + strPass + '@' + strHost + ':' + str(nPort) + '/' + urllib.quote( virtual_host,'' )
		if isinstance( query_params,list ) :
			strURL = strURL + '?' + urllib.urlencode( query_params )
		elif not isinstance( query_params,type(None) ) :
			raise Exception( "query params not a list or none type (" + str(type(query_params)) + "). needs a list of 2d tuples e.g. [('connection_attempts',3),('retry_delay',1),('heartbeat_interval',3600)]" )
		self.strConnectionURL = strURL

		# setup logger
		if logger == None :
			self.logger = logging.getLogger()
		else :
			self.logger = logger

		# init other member variables
		self.connection = None
		self.channel = None
		self.strExchangeName = None
		self.strExchangeType = None
		self.strQueueName = None
		self.bExclusive = None
		self.bAutoDelete = None
		self.strRoutingKey = None
		self.bClosingNormally = False

	#
	# connect to the RabbitMQ broker
	# - base class uses a simple blocking connection but this can be overridden by subclasses as required
	# Exception: thrown on connection error
	#
	def connect( self ) :
		#self.logger.info( 'connecting to rabbitmq URL = ' + self.strConnectionURL )
		parameters = pika.URLParameters( self.strConnectionURL )

		self.bClosingNormally = False
		self.connection = pika.BlockingConnection( parameters )
		self.channel = None

		# note: 0.19.3 has a bug that causes an error """ 'BlockingConnection' object has no attribute 'disconnect' """
		# below is a HACK that apparently fixes this issue
		# a proper fix will appear in 0.19.4 (when its out) apparently
		# https://github.com/pika/pika/issues/435

		self.connection.disconnect = self.disconnect

	#
	# disconnect from the RabbitMQ broker
	# note: failure to call disconnect before shutdown can cause app to hang on rabbitmq connection thread closure
	# Exception: thrown on error
	#
	def disconnect( self ) :
		try :
			self.bClosingNormally = True
			self.connection.close()
		except :
			# note: 0.19.3 has a bug that causes an error is socket timesout (or something like this)
			# so just ignore any exceptions on close for now!
			# 0.19.4 (when its out) will fix this bug apparently
			# http://stackoverflow.com/questions/14572020/handling-long-running-tasks-in-pika-rabbitmq
			self.logger.debug( 'RABBITMQ_TESTPOINT : DISCONNECT FAILED : ' + repr(sys.exc_info()) )
			pass

	"""
	#
	# internal callback function to handle async connection closes by RabbitMQ
	#
	def on_connection_closed( self, connection, reply_code, reply_text ) :

		self.channel = None

		if self.bClosingNormally == True :
			self.connection.ioloop.stop()
		else:
			self.logger.warning( 'Connection closed unexpectedly (will reopen) : (%s) %s', reply_code, reply_text )
			self.connect()

	#
	# internal callback function to handle async channel closes by RabbitMQ
	#
	def on_channel_closed( self, channel, reply_code, reply_text ) :

		# close connection to trigger a reconnection unless we actually expected to close
		if self.bClosingNormally == False :
			self.logger.warning( 'Channel closed unexpectedly (will close connection to trigger reconnection) : (%s) %s', reply_code, reply_text)
			self._connection.close()
	"""

	#
	# open a channel for publishing or subscribing via the RabbitMQ broker connection
	# - publishes can consumers need a queue
	# - consumers need a queue
	# declare_exchange = optional declaration of an exchange (can be None or '' for default exchange). declaring an exchange creates it if it does not exist already. e.g. 'test_exchange'
	# exchange_type = optional exchange type (default 'fanout', can also be 'direct', 'topic' ...)
	# declare_queue = optional declaration of an queue (can be None for no queue or '' for an autonamed queue) e.g. 'test_queue'
	# exclusive = if true queue is declared as exclusive (useful for temp unnamed queues associated with fanout exchanges)
	# auto_delete = if true queue is declared as auto delete (useful for temp unnamed queues associated with fanout exchanges)
	# routing_key = optional routing key for queue (can be '') e.g. 'test_routing_key'
	# Exception: thrown on error
	#
	def open_channel( self, declare_exchange = None, exchange_type = 'fanout', declare_queue = None, exclusive = False, auto_delete = False, routing_key = '' ) :
		# remember channel connection parameters in case of a reconnect
		self.strExchangeName = declare_exchange
		self.strExchangeType = exchange_type
		self.strQueueName = declare_queue
		self.bExclusive = exclusive
		self.bAutoDelete = auto_delete
		self.strRoutingKey = routing_key

		# make a new channel
		self.channel = self.connection.channel()

		# declare an exchange
		if declare_exchange != None :
			self.channel.exchange_declare( exchange = self.strExchangeName, exchange_type = self.strExchangeType )
			self.logger.info( 'opening channel : exchange = ' + repr(self.strExchangeName) )
		else :
			self.logger.info( 'opening channel : default exchange' )

		# declare an queue
		if declare_queue != None :
			if declare_exchange == None :
				raise Exception( 'cannot create a queue without an exchange' )
			self.channel.queue_declare( queue = self.strQueueName, exclusive = self.bExclusive, auto_delete = self.bAutoDelete )
			self.channel.queue_bind( queue = self.strQueueName, exchange = self.strExchangeName, routing_key = self.strRoutingKey )
			self.logger.info( 'opening channel : queue bind = ' + repr(self.strQueueName) )

	#
	# reopen a channel (e.g. if it has timed out)
	# Exception: thrown on error
	#
	def reopen_channel( self ) :
		self.open_channel( self.strExchangeName, self.strExchangeType, self.strQueueName, self.bExclusive, self.bAutoDelete, self.strRoutingKey )


	#
	# publish a message (can be text or binary) to an open channel.
	# this method will retry publish attempts until successful or the timeout is exceeded
	# strMessage = text encoded data string - <unicode> will be UTF-8 encoded, <str> will use ascii encoding
	# content_type = optional content MIME type (default is 'text/plain')
	# timestamp_since_epoch = optional number of seconds since epoch for this messages timestamp
	# delivery_mode = optional mode [1 = nonpersistent (default), 2 = persistent]
	# timeout = optional timeout in seconds after which attempts to publish are aborted. the default is nTimeout=0 for a single attempt only
	# Exception: thrown on error
	#
	def publish_message( self, strMessage, content_type = 'text/plain', timestamp_since_epoch = None, delivery_mode = 1, timeout = 0 ) :
		if (not isinstance( strMessage, str )) and (not isinstance( strMessage, unicode )) :
			raise Exception( 'invalid message object [' + str(type(strMessage)) + '] expected str or unicode' )

		# setup message properties
		# note: pika classes force UTF-8 for unicode strings so ignore the content encoding property
		propertiesBasic = pika.BasicProperties( timestamp=timestamp_since_epoch, content_type=content_type, delivery_mode=delivery_mode )

		# set the expiry time
		dateCurrent = datetime.datetime.now()
		timeMax = datetime.timedelta( seconds=timeout )
		dateExpire = dateCurrent + timeMax
		bAbort = False
		bExpired = False

		while (bAbort == False) and (bExpired == False) :
			try :

				# check if socket exists as an attribute. it does on windows pika implementation, does not on RedHat 7.3 (!) so we need OS conditional code here
				try:
					self.connection.socket
				except AttributeError :
					# check connection without using socket

					# check if connection is still open, if not open it and make a new channel
					# note: workaround: check socket as a bug in pika means socket timeout can make it None and cause an error when using it (!)
					if (self.connection == None) or (self.connection.is_open == False) :
						self.logger.warn( 'reconnecting to rabbitmq (connection was closed)' )
						self.connect()
						self.reopen_channel()

				else:
					# check connection using socket

					# check if connection is still open, if not open it and make a new channel
					# note: workaround: check socket as a bug in pika means socket timeout can make it None and cause an error when using it (!)
					if (self.connection == None) or (self.connection.is_open == False) or (self.connection.socket == None) :
						self.logger.warn( 'reconnecting to rabbitmq (connection was closed)' )
						self.connect()
						self.reopen_channel()

				# check if channel is still open, if not open it
				if (self.channel == None) or (self.channel.is_open == False) :
					self.logger.warn( 'reopening rabbitmq channel (channel was closed)' )
					self.reopen_channel()

				# publish message to channel
				# mendatory = dont fail silently if cannot deliver message to queue
				# note: immediate flag has been depreciated so dont use it!
				self.channel.basic_publish( self.strExchangeName, self.strRoutingKey, strMessage, propertiesBasic, mandatory = True )
				# self.logger.info( 'published message : ' + self.strExchangeName + ' : ' + strMessage )

				# all done
				return

			except pika.exceptions.ChannelClosed, err_channel :
				# channel closed so wait and try again
				self.logger.warn( 'channel closed on publish_message (will retry) : ' + repr(err_channel) )
				time.sleep( 0.01 )

			except pika.exceptions.ConnectionClosed, err_connection :
				# channel closed so wait and try again
				self.logger.warn( 'connection closed on publish_message (will retry) : ' + repr(err_connection) )
				time.sleep( 0.01 )

			except pika.exceptions.NoFreeChannels, err_nofree :
				# channel closed so wait and try again
				self.logger.warn( 'no free channels on publish_message (will retry) : ' + repr(err_nofree) )
				time.sleep( 0.01 )

			except Exception, err_general :
				# fail with the exception as we cannot handle unknown problems
				self.logger.exception( 'error on publish_message (aborted) : ' + repr(err_general) )
				bAbort = True

			bExpired = (datetime.datetime.now() > dateExpire)

		if bAbort == True :
			raise Exception( 'aborted publish_message' )

		if bExpired == True :
			raise Exception( 'timeout on publish_message (aborted)' )

		return

	#
	# register a callback function to consume messages from an open channel.
	# channel = channel object
	# strExchange = exchange to publish to (can be None or '' for default exchange) e.g. 'test_exchange'
	# callback_handler = callback function for message
	#     e.g. def on_message( channel, method_frame, header_frame, body ) :
	# consumer_tag = optional tag for consumer (can be None)
	# no_ack = True if broker should wait for consuming callback_handler to explicitly acknowledge a message (and resend if no ack received)
	# return channel object (it can change if connection restarted)
	# Exception: thrown on error
	#
	def consume_message( self, callback_handler, consumer_tag = None, no_ack = True ) :

		# check if socket exists as an attribute. it does on windows pika implementation, does not on RedHat 7.3 (!) so we need OS conditional code here
		try:
			self.connection.socket
		except AttributeError :
			# check connection without using socket

			# check if connection is still open, if not open it and make a new channel
			if (self.connection.is_open == False) :
				self.logger.warn( 'reconnecting to rabbitmq (connection closed)' )
				self.connect()
				self.reopen_channel()

		else:
			# check connection using socket

			# check if connection is still open, if not open it and make a new channel
			if (self.connection.is_open == False) or (self.connection.socket == None) :
				self.logger.warn( 'reconnecting to rabbitmq (connection closed)' )
				self.connect()
				self.reopen_channel()

		# check if channel is still open, if not open it
		if self.channel.is_open == False :
			self.logger.warn( 'opening rabbitmq channel (channel closed)' )
			self.reopen_channel()

		# register callback function and start to consume messages
		self.channel.basic_consume( callback_handler, queue = self.strQueueName, exclusive = self.bExclusive, consumer_tag = consumer_tag, no_ack = no_ack )

		# all done
		return

