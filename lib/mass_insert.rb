require "mass_insert/version"

module MassInsert
  autoload :Base,             'mass_insert/base.rb'
  autoload :ProcessControl,   'mass_insert/process_control.rb'
  autoload :QueryBuilder,     'mass_insert/query_builder.rb'
  autoload :QueryExecution,   'mass_insert/query_execution.rb'

  module Adapters
    autoload :Adapter,            'mass_insert/adapters/adapter.rb'
    autoload :AbstractQuery,      'mass_insert/adapters/abstract_query.rb'
    autoload :MysqlAdapter,       'mass_insert/adapters/mysql_adapter.rb'
    autoload :PostgresqlAdapter,  'mass_insert/adapters/postgresql_adapter.rb'
    autoload :Sqlite3Adapter,     'mass_insert/adapters/sqlite3_adapter.rb'

    module Helpers
      autoload :Timestamp,  'mass_insert/adapters/helpers/timestamp.rb'
      autoload :Sanitizer,  'mass_insert/adapters/helpers/sanitizer.rb'
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
