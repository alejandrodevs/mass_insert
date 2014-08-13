module MassInsert
  autoload :Base,        'mass_insert/base.rb'
  autoload :Builder,     'mass_insert/builder.rb'
  autoload :Process,     'mass_insert/process.rb'
  autoload :Executer,    'mass_insert/executer.rb'
  autoload :Utilities,   'mass_insert/utilities.rb'
  autoload :VERSION,     'mass_insert/version.rb'

  module Adapters
    autoload :Adapter,            'mass_insert/adapters/adapter.rb'
    autoload :Mysql2Adapter,      'mass_insert/adapters/mysql2_adapter.rb'
    autoload :PostgreSQLAdapter,  'mass_insert/adapters/postgresql_adapter.rb'
    autoload :SQLite3Adapter,     'mass_insert/adapters/sqlite3_adapter.rb'
    autoload :SQLServerAdapter,   'mass_insert/adapters/sqlserver_adapter.rb'

    module Helpers
      autoload :AbstractQuery,  'mass_insert/adapters/helpers/abstract_query.rb'
      autoload :ColumnValue,    'mass_insert/adapters/helpers/column_value.rb'
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
