require 'minitest/autorun'
require 'mass_insert'
require 'logger'
require 'active_record'
require 'fileutils'

adapter = ENV['DATABASE_ADAPTER'] || 'sqlite3'

FileUtils.mkdir_p('tmp')
FileUtils.mkdir_p('log')

ActiveRecord::Base.logger = Logger.new('log/test.log')
ActiveRecord::Base.logger.level = Logger::DEBUG
ActiveRecord::Base.configurations['test'] = YAML.load_file(File.dirname(__FILE__) + '/database.yml')[adapter]
ActiveRecord::Base.establish_connection('test')

require File.dirname(__FILE__) + '/schema.rb'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }
Dir[File.dirname(__FILE__) + "/models/**/*.rb"].each{ |file| require file }