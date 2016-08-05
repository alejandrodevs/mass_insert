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

database_configuration = YAML.load_file(File.dirname(__FILE__) + '/database.yml')[adapter]
ActiveRecord::Base.configurations['test'] = database_configuration
ActiveRecord::Base.establish_connection(:test)

begin
  ActiveRecord::Base.connection
rescue
  # Ensures database exists.
  ActiveRecord::Tasks::DatabaseTasks.database_configuration = database_configuration
  ActiveRecord::Tasks::DatabaseTasks.create_current('test')
end

require File.dirname(__FILE__) + '/schema.rb'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }
Dir[File.dirname(__FILE__) + "/models/**/*.rb"].each{ |file| require file }
