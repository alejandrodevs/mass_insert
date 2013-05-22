module MassInsert
  module Adapters
    class SQLServerAdapter < Adapter

      MAX_VALUES_PER_INSERTION = 1000

      # This functions calls the necessary functions to create a complete
      # sqlserver query to multiple insertion. The methods are in the Abstract
      # Query module. If some method is too specific to this database adapter
      # you can overwrite it. The values that the user gave will be treated
      # in batches of 500 items because sqlite database allows by default
      # batches of 500.and each batch will generate a query. This method will
      # generate an array with batch queries.
      def execute
        @values.each_slice(MAX_VALUES_PER_INSERTION).map do |slice|
          @values = slice
          super
        end
      end

    end
  end
end
