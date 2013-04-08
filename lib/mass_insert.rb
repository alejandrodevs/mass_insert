require "mass_insert/version"
Dir[File.dirname(__FILE__) + "/adapters/*.rb"].each { |file| require file }

module MassInsert
  autoload :Base,         'mass_insert/base.rb'
  autoload :Execution,    'mass_insert/execution.rb'
  autoload :QueryBuilder, 'mass_insert/query_builder.rb'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
