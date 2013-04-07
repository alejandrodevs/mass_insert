require "mass_insert/version"

module MassInsert
  autoload :Base, 'mass_insert/base.rb'
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend MassInsert::Base
end
