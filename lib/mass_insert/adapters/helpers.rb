Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each{ |file| require file }

module MassInsert
  module Adapters
    module Helpers
      include AbstractQuery
      include Timestamp
      include Sanitizer
    end
  end
end
