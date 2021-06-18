require_relative './persistence_service_services_pb'
require_relative '../models/transaction'
require 'byebug'

module Persistence
  class TransactionService < Persistence::Persist::Service
    OK = 0
    FAILED = 1

    def create_transaction(request, _call)
      transaction = ::Transaction.new(
        id: request.transaction_id,
        amount: request.amount,
        status: request.status
      )

      if transaction.save!
        return build_response(OK)
      end
    rescue
      build_response(FAILED)
    end

    def build_response(status)
      ::Persistence::PersistenceResponse.new(
        status: status
      )
    end
  end
end
