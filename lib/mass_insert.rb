require "mass_insert/version"

module MassInsert
  autoload :Adapters,         'mass_insert/adapters.rb'
  autoload :Base,             'mass_insert/base.rb'
  autoload :ProcessControl,   'mass_insert/process_control.rb'
  autoload :QueryBuilder,     'mass_insert/query_builder.rb'
  autoload :QueryExecution,   'mass_insert/query_execution.rb'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
