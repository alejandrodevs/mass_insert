require 'active_record_dummy/config/environment'
require 'models/test.rb'
require "./lib/mass_insert"

require 'simplecov'
SimpleCov.start do
  minimum_coverage 90
end
