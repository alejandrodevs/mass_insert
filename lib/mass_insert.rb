require "mass_insert/version"

module MassInsert
  autoload :Base,         'mass_insert/base.rb'
  autoload :Execution,    'mass_insert/execution.rb'
  autoload :Adapter,      'mass_insert/adapter.rb'
  autoload :Timestamp,    'mass_insert/timestamp.rb'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
