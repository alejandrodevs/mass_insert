class Test < ActiveRecord::Base
  def self.column_names
    ["id", "name", "email"]
  end
end
