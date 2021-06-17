require 'grpc'
require './lib/payments/payment_service_services_pb'

stub = Payments::Pay::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
request = Payments::PaymentRequest.new(transaction_id: 'some_random_id', amount: 100.20)


response = stub.pay(request)
puts response.body
