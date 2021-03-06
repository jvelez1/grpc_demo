# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: persistence_service.proto for package 'persistence'

require 'grpc'
require_relative './persistence_service_pb'

module Persistence
  module Persist
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'persistence.Persist'

      rpc :create_transaction, ::Persistence::PersistenceTransactionRequest, ::Persistence::PersistenceResponse
    end

    Stub = Service.rpc_stub_class
  end
end
