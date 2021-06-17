require 'logger'
require 'time'
require_relative "./custom_logger/version"
require_relative './custom_logger/error_handler_server_interceptor'
require_relative './custom_logger/loggin_server_interceptor'

module CustomLogger
  class Error < StandardError; end
  class DefaultFormatter < ::Logger::Formatter
    def call(severity, time, _progname, msg)
      "time=#{time.strftime('%FT%T.%6N%:z')} level=#{severity} msg=#{msg}\n"
    end
  end

  DEFAULT_LOGGER = Logger.new(STDOUT, level: :debug, formatter: CustomLogger::DefaultFormatter.new)

  def self.log
    DEFAULT_LOGGER
  end
end
