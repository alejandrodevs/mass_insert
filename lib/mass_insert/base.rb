module MassInsert
  module Base

    # = MassInsert
    #
    # This method does a mass database insertion just calling it from your
    # ActiveRecord model. Example...
    #
    #   User.mass_insert(values)
    #
    # The values should be an array with the object values in a hash.
    # Example...
    #
    #   values = [
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"}
    #   ]
    #
    # == Options
    #
    # And MassInset gem allow you to send it some options as second param
    # Example...
    #
    #   User.mass_insert(values, options)
    #
    # === table_name
    #
    # Default value is the table name to your model. This options rarely
    # needs to change but you can do it if you pass a string with the table
    # name. Example...
    #
    #   options = {:table_name => "users"}
    #
    # === primary_key
    #
    # Default value is :id. You can change the name of primary key column
    # send it a symbol with the column name.
    #
    #   options = {:primary_key => :post_id}
    #
    # === primary_key_mode
    #
    # Default value is :auto. When is :auto MassInsert knows that database
    # will generate the value of the primary key column automatically. If
    # you pass :manual as primary key mode you need to create your value
    # hashes with the key and value of the primary key column.
    #
    #   options = {:primary_key_mode => :manual}
    #
    def mass_insert values, args = {}
      class_eval do
        extend ClassMethods
      end

      options = mass_insert_options(args)
      @mass_insert_process = Process.new(values, options)
      @mass_insert_process.start
    end


    module ClassMethods
      # Returns an OpenStruct instance where is possible to see the
      # results of MassInsert process.
      def mass_insert_results
        Result.new(@mass_insert_process)
      end

      private
        # Sanitizes the MassInset options that were passed by params.
        # If the options weren't passed, they would be initialized with
        # the default values.
        def mass_insert_options options = {}
          options[:class_name]        ||= self
          options[:table_name]        ||= self.table_name
          options[:primary_key]       ||= :id
          options[:primary_key_mode]  ||= :auto
          options
        end

    end
  end
end
