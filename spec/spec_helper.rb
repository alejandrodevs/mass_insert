require 'coveralls'
Coveralls.wear!
Coveralls::Output.silent = true

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'simplecov'
SimpleCov.start do
  minimum_coverage 90
end

RSpec.configure do |config|
  # Configuration goes here.
end
