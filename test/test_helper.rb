require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'active_record'
require 'mass_insert'
require 'minitest/autorun'

adapter = ENV['DATABASE_ADAPTER'] || 'sqlite3'
database_configuration = YAML.load_file(File.dirname(__FILE__) + '/database.yml')[adapter]

if defined?(ActiveRecord::DatabaseConfigurations)
  ActiveRecord::Base.configurations = ActiveRecord::DatabaseConfigurations.new(database_configuration)
else
  ActiveRecord::Base.configurations = database_configuration
end

ActiveRecord::Base.establish_connection(:test)

begin
  ActiveRecord::Base.connection
rescue
  # Ensures database exists.
  puts 'Creating database using config in database.yml...'
  ActiveRecord::Tasks::DatabaseTasks.database_configuration = database_configuration['test']
  ActiveRecord::Tasks::DatabaseTasks.create_current('test')
end

require File.dirname(__FILE__) + '/schema.rb'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }
