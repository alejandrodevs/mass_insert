require 'delegate'

module MassInsert
  autoload :Base,        'mass_insert/base.rb'
  autoload :Builder,     'mass_insert/builder.rb'
  autoload :Process,     'mass_insert/process.rb'
  autoload :Executer,    'mass_insert/executer.rb'
  autoload :Utilities,   'mass_insert/utilities.rb'
  autoload :VERSION,     'mass_insert/version.rb'

  module Adapters
    autoload :AbstractAdapter,    'mass_insert/adapters/abstract_adapter.rb'
    autoload :Mysql2Adapter,      'mass_insert/adapters/mysql2_adapter.rb'
    autoload :PostgreSQLAdapter,  'mass_insert/adapters/postgresql_adapter.rb'
    autoload :SQLite3Adapter,     'mass_insert/adapters/sqlite3_adapter.rb'
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
