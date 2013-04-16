module MassInsert
  module Adapters
    module Helpers
      module PrimaryKey

        attr_accessor :counter_primary_key

        # Returns the current primary key value that is going to be saved
        # into the database. This primary key value is usually used in
        # primary_key_value method to generate a primary key hash that will
        # be merge in row hash.
        def counter_primary_key
          @counter_primary_key ||= class_name.last.try(primary_key).to_i
        end

        # Returns a primary key hash with the next correct value to primary
        # key column. Here counter_primary_key attributes is incremented by 1
        # when this method is called. The hash generated usually will be
        # merged in the row hash.
        def primary_key_value
          @counter_primary_key = counter_primary_key + 1
          {primary_key => counter_primary_key}
        end

      end
    end
  end
end
