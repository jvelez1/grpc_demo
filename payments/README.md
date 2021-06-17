Compile proto files

grpc_tools_ruby_protoc -I protos --ruby_out=lib/payments --grpc_out=lib/payments protos/payment_service.proto