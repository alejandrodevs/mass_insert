require 'dummy/config/environment'
require 'models/test.rb'
require "./lib/mass_insert"
require 'simplecov'
require 'support/mass_insert_support'

SimpleCov.start do
  minimum_coverage 90
end

RSpec.configure do |config|
  config.extend MassInsertSupport
end
