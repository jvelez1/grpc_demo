#!/usr/bin/env ruby
require 'grpc'
require './payments/lib/payments/payment_service'
require './persistence/lib/persistence'
require './persistence/lib/persistence/transaction_service'
require './custom_logger/lib/custom_logger'

class Server
  DEFAULT_SERVER_INTERCEPTORS = [
    ::CustomLogger::LoggingServerInterceptor.new,
    ::CustomLogger::ErrorHandlerServerInterceptor.new
  ]

  SERVICES = [
    Payments::PaymentService,
    Persistence::TransactionService
  ]

  def self.run_server
    Persistence.create_database_connection
    server = ::GRPC::RpcServer.new(interceptors: DEFAULT_SERVER_INTERCEPTORS)
    server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
    SERVICES.each do |service|
      CustomLogger.log.info { "Handling #{service}" }
      server.handle(service)
    end
    CustomLogger.log.info("Running GRPC server on 50051")    
    server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
  end
end

Server.run_server
