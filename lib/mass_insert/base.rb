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
    def mass_insert values, options = {}
      # prepare default options that come in the class that invokes the
      # mass_insert function.
      options[:class_name] = options[:class_name] || self
      options[:table_name] = options[:table_name] || self.table_name

      # prepare attributes options that were configured by the user and
      # if the options weren't passed, they would be initialized with the
      # default values.
      options[:primary_key]      = options[:primary_key]      || :id
      options[:primary_key_mode] = options[:primary_key_mode] || :auto

      MassInsert::ProcessControl.new(values, options).execute
    end

  end
end
