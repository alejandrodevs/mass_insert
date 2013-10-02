require 'coveralls'
Coveralls.wear!
Coveralls::Output.silent = true

require 'dummy/config/environment'
require 'simplecov'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

SimpleCov.start do
  minimum_coverage 90
end

RSpec.configure do |config|
  config.extend MassInsertSupport
end
