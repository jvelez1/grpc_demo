require_relative './payment_service_services_pb'

module Payments
  class PaymentService < Payments::Pay::Service
    def pay(request, _call)
      PaymentResponse.new(
        status: rand(0..4),
        transaction_id: request.transaction_id
      )
    end
  end
end
