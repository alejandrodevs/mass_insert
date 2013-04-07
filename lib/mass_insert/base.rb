module MassInsert
  module Base

    # This method do a mass database insertion. Example...
    #
    #   User.mass_insert(values)
    #
    # The values should be a hash with the object values
    # Example...
    #
    #   values = {
    #     :name   => "user name"
    #     :email  => "user email"
    #   }
    #
    # The id attribute and timestamp attributes isn't required.
    #
    def mass_insert values

    end

  end
end
