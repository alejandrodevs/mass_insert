module MassInsert
  module Base

    # This method do a mass database insertion. Example...
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
    # When a class that inherit from ActiveRecord::Base calls this method
    # is going to extend the methods in ClassMethods module. This module
    # contains some methods that provides some necessary functionality.
    #
    # After extends the class with methods in ClassMethods module. The
    # options that were passed by params are sanitized in the method
    # called mass_insert_options_sanitized to be passed by params to
    # do ProcessControl instance. The values are passed too.
    def mass_insert values, args = {}
      class_eval do
        extend ClassMethods
      end

      options = mass_insert_options(args)
      @mass_insert_process = MassInsert::ProcessControl.new(values, options)
      @mass_insert_process.start
    end


    module ClassMethods
      # Returns an OpenStruc instance where is possible to see the
      # results of MassInsert process. This method calls results method
      # in ProcessControl class. Returns nil if there is not a instance
      # variable with the MassInset process.
      def mass_insert_results
        @mass_insert_process.results if @mass_insert_process
      end

      private

        def mass_insert_options args = {}
          # prepare default options that come in the class that invokes the
          # mass_insert function.
          args[:class_name] ||= self
          args[:table_name] ||= self.table_name

          # prepare attributes options that were configured by the user and
          # if the options weren't passed, they would be initialized with the
          # default values.
          args[:primary_key]      ||= :id
          args[:primary_key_mode] ||= :auto

          # Returns the arguments but sanitized and ready to be used. This
          # args will be passed by params to ProcessControl class.
          args
        end

    end
  end
end
