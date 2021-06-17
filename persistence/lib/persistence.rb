# frozen_string_literal: true

require_relative "./persistence/version"
require_relative "./models/transaction"
require './custom_logger/lib/custom_logger.rb'
require 'active_record'

module Persistence
  class Error < StandardError; end
  def self.create_database_connection
    db_config_file = File.read(File.expand_path('../../db/config.yml', __FILE__))
    db_config = YAML::load(db_config_file)['development']

    ActiveRecord::Base.establish_connection(db_config)
    conn = ActiveRecord::Base.connection
    conn.execute('SELECT 1;')
    CustomLogger.log.debug('DataBase: Connected!')
  rescue => error
    CustomLogger.log.fatal("Could not reach the DB. Error: #{error.to_s}")
    exit(1)
  end
end
