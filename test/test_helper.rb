require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.start

require 'logger'
require 'minitest/autorun'
require 'active_record'
require 'mass_insert'
require 'fileutils'

adapter = ENV['DATABASE_ADAPTER'] || 'sqlite3'

FileUtils.mkdir_p('tmp')
FileUtils.mkdir_p('log')

ActiveRecord::Base.logger = Logger.new('log/test.log')
ActiveRecord::Base.logger.level = Logger::DEBUG

# Try to create database if not exists
#if adapter != 'sqlite3'
  #config_without_database = YAML.load_file(File.dirname(__FILE__) + '/database.yml')[adapter]
  #database = config_without_database.delete('database')
  #ActiveRecord::Base.configurations['test'] = config_without_database
  #ActiveRecord::Base.establish_connection(:test)
  #conn = ActiveRecord::Base.connection

  #begin
    #conn.execute("CREATE DATABASE #{database}")
  #rescue
  #end
#end

database_config = YAML.load_file(File.dirname(__FILE__) + '/database.yml')[adapter]
ActiveRecord::Base.configurations['test'] = database_config
ActiveRecord::Base.establish_connection(:test)

require File.dirname(__FILE__) + '/schema.rb'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }
Dir[File.dirname(__FILE__) + "/models/**/*.rb"].each{ |file| require file }
