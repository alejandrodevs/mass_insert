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
    # === Primary key
    #
    # By default primary key is ignored. If you wish primary key doesn't
    # be ignored you need to pass the primary_key option on true.
    #
    #   User.mass_insert(values, :primary_key => true)
    #
    # === Each slice
    #
    # Due you can get a database timeout error you can specify that the
    # insertion will be in batches. You need to pass the each_slice option
    # with the records per batch. Example...
    #
    #   User.mass_insert(values, :each_slice => 10000)
    #
    def mass_insert values, options = {}
      extend ClassMethods

      options[:class_name]  ||= self
      options[:each_slice]  ||= false
      options[:primary_key] ||= false

      @mass_insert_process = Process.new(values, options)
      @mass_insert_process.start
    end


    module ClassMethods

      # == Results
      #
      # Sometimes after MassInsert process you need to see information about
      # the process. MassInsert provides a simple way to do it. Just call the
      # next methods from your model after MassInsert execution:
      #
      # === Records
      #
      # Returns the amount of records that were persisted.
      #
      #   User.mass_insert_results.records          # => 120000
      #
      # === Time
      #
      # Returns the time that took to do all the MassInsert process.
      #
      #   User.mass_insert_results.time             # => 0.67
      #
      # === Building time
      #
      # Returns the time that took to create the query string that was persisted.
      #
      #   User.mass_insert_results.building_time    # => 0.58
      #
      # === Execution time
      #
      # Returns the time that took to execute the query string that was persisted.
      #
      #   User.mass_insert_results.execution_time   # => 0.09
      #
      def mass_insert_results
        Result.new(@mass_insert_process)
      end

    end
  end
end
