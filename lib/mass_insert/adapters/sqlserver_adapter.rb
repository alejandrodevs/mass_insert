module MassInsert
  module Adapters
    class SQLServerAdapter < Adapter
      def string_columns
        "([#{columns.join("], [")}]) "
      end
    end
  end
end
