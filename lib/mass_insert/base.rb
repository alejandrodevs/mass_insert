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
    # The id and timestamp attributes isn't required.
    #
    def mass_insert values, options = {}
      # prepare default options
      options[:class_name] = options[:class_name] || self
      options[:table_name] = options[:table_name] || self.table_name

      # prepare attributes options
      options[:primary_key]      = options[:primary_key]      || :id
      options[:primary_key_mode] = options[:primary_key_mode] || :auto

      MassInsert::ProcessControl.new(values, options).execute
    end

  end
end
