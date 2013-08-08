require "mass_insert/version"

module MassInsert

  autoload :Base,           'mass_insert/base.rb'
  autoload :ProcessControl, 'mass_insert/process_control.rb'

  module Builder
    autoload :Adapters,     'mass_insert/builder/adapters.rb'
    autoload :Base,         'mass_insert/builder/base.rb'
  end

  module Executer
    autoload :Base,         'mass_insert/executer/base.rb'
  end

end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
