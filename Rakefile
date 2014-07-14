require "bundler/gem_tasks"

namespace :spec do
  desc "Runs unit tests"
  task :unit do
    system("echo '\e[00;32m\033[1mRunning unit tests...\e[00m'")
    system("bundle exec rspec spec/lib")
  end

  adapters = [:mysql2, :postgresql, :sqlite3]

  adapters.each do |adapter|
    desc "Runs test suite to #{adapter}"
    task adapter do
      ENV["RAILS_ENV"] = adapter.to_s
      system("echo '\e[00;32m\033[1mRunning test suite to #{adapter}...\e[00m'")
      system("bundle exec rspec spec/adapters")
    end
  end

  desc "Runs all specs"
  task :all do
    Rake.application['spec:unit'].invoke
    raise "Unit test failed!" unless $?.exitstatus == 0

    adapters.each do |adapter|
      Rake.application["spec:#{adapter}"].invoke
      raise "Test suite to #{adapter} failed!" unless $?.exitstatus == 0
    end
  end
end

task default: 'spec:postgresql'
