require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'active_record'
require 'mass_insert'
require 'minitest/autorun'

adapter = ENV['DATABASE_ADAPTER'] || 'sqlite3'
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
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }
