require 'grpc'

module CustomLogger
  class LoggingServerInterceptor < ::GRPC::ServerInterceptor
    def request_response(request: nil, call: nil, method: nil)
      call_desc = [method.receiver.class, method.name].join('#')
      CustomLogger.log.debug("Exec #{call_desc}")
      started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      yield
      took = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
      CustomLogger.log.debug("Exec #{call_desc} done! (#{took.round(5)}s)")
    end
  end
end

