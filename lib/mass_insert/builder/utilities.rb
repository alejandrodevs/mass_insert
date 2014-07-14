module MassInsert
  module Builder
    module Utilities
      # Returns a string that contains the adapter type previosly
      # configured in Rails project usually in the database.yml file.
      def self.adapter
        ActiveRecord::Base.connection.instance_values['config'][:adapter]
      end
    end
  end
end
