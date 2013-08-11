module MassInsert
  autoload :Base,       'mass_insert/base.rb'
  autoload :Result,     'mass_insert/result.rb'
  autoload :Process,    'mass_insert/process.rb'
  autoload :Executer,   'mass_insert/executer.rb'
  autoload :VERSION,    'mass_insert/version.rb'

  module Builder
    autoload :Base,     'mass_insert/builder/base.rb'
    autoload :Adapters, 'mass_insert/builder/adapters.rb'
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
