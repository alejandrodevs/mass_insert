module MassInsert
  module Base

    # = MassInsert
    #
    # Invoke mass insert just calling this from your ActiveRecord model...
    #
    #   User.mass_insert(values)
    #
    # The values should be an array of hashes. Include attributes and values
    # in every hash. Example...
    #
    #   values = [
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"}
    #   ]
    #
    # == Options
    #
    # MassInset gem allow you to send it options as second param. Example...
    #
    #   User.mass_insert(values, options)
    #
    # === table_name
    #
    # Default value is the model table name but it's possible to change it
    # passing other table name. Example...
    #
    #   options = {:table_name => "users"}
    #
    # === primary_key
    #
    # Default value is :id but it's possible to change passing other primary
    # key symbol. Example...
    #
    #   options = {:primary_key => :post_id}
    #
    # === primary_key_mode
    #
    # By default MassInsert knows that the database will generate the
    # primary key value automatically. If you pass it :manual you need
    # to include the primary key value in every hash.
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

      def mass_insert_results
        Result.new(@mass_insert_process)
      end

      private
        # Sanitizes options. If the options weren't passed, they would
        # be initialized with default values.
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
