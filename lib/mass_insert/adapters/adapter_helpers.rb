Dir[File.dirname(__FILE__) + '/adapter_helpers/*.rb'].each{ |file| require file }

module MassInsert
  module Adapters
    module AdapterHelpers
      include AbstractQuery
      include Timestamp
      include Sanitizer
    end
  end
end
