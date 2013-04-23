module MassInsert
  module Adapters
    module Helpers
      autoload :AbstractQuery, 'mass_insert/adapters/helpers/abstract_query.rb'
      autoload :Timestamp,     'mass_insert/adapters/helpers/timestamp.rb'
      autoload :Sanitizer,     'mass_insert/adapters/helpers/sanitizer.rb'
    end
  end
end
