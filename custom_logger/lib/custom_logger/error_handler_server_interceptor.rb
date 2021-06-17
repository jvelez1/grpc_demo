require 'grpc'

module CustomLogger
  class ErrorHandlerServerInterceptor < ::GRPC::ServerInterceptor
    def request_response(request: nil, call: nil, method: nil)
      call_desc = [method.receiver.class, method.name].join('#')
      begin
        yield
      rescue => err
        CustomLogger.log.error("Error:  #{call_desc}!")
        CustomLogger.log.error(err.full_message)
        raise
      end
    end
  end
end
