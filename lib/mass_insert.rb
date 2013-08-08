require "mass_insert/version"

module MassInsert

  module Builder
    autoload :Adapters,       'mass_insert/builder/adapters.rb'
    autoload :Base,           'mass_insert/builder/base.rb'
  end

  autoload :Base,             'mass_insert/base.rb'
  autoload :ProcessControl,   'mass_insert/process_control.rb'
  autoload :QueryExecution,   'mass_insert/query_execution.rb'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
