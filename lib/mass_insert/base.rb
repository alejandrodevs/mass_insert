module MassInsert
  module Base

    # This method do a mass database insertion. Example...
    #
    #   User.mass_insert(values)
    #
    # The values should be an array with the object values
    # in a hash. Example...
    #
    #   values = [
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"},
    #     {:name   => "user name", :email  => "user email"}
    #   ]
    #
    def mass_insert values, args = {}
      options = mass_insert_options(args)
      process = MassInsert::ProcessControl.new(values, options)
      process.execute
    end

    private

      def mass_insert_options args = {}
        # prepare default options that come in the class that invokes the
        # mass_insert function.
        args[:class_name] = args[:class_name] || self
        args[:table_name] = args[:table_name] || self.table_name

        # prepare attributes options that were configured by the user and
        # if the options weren't passed, they would be initialized with the
        # default values.
        args[:primary_key]      = args[:primary_key]      || :id
        args[:primary_key_mode] = args[:primary_key_mode] || :auto

        # Returns the arguments but sanitized and ready to be used. This
        # args will be passed by params to ProcessControl class.
        args
      end

  end
end
