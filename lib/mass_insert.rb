require "mass_insert/version"

module MassInsert
  autoload :Base,       'mass_insert/base.rb'
  autoload :Execution,  'mass_insert/execution.rb'

  module Adapters
    autoload :Adapter,      'mass_insert/adapters/adapter.rb'
    autoload :MysqlAdapter, 'mass_insert/adapters/mysql_adapter.rb'

    module Helpers
      autoload :Timestamp,  'mass_insert/adapters/helpers/timestamp.rb'
      autoload :Sanitizer,  'mass_insert/adapters/helpers/sanitizer.rb'
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
