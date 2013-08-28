require "bundler/gem_tasks"

namespace :spec do
  desc "Runs unit tests"
  task :unit do
    system("echo '\e[00;32m\033[1mRunning unit tests...\e[00m'")
    system("bundle exec rspec spec/lib")
  end

  [:mysql2, :postgresql, :sqlite3].each do |adapter|
    desc "Runs test suite to #{adapter}"
    task adapter do
      ENV["RAILS_ENV"] = adapter.to_s
      system("echo '\e[00;32m\033[1mRunning test suite to #{adapter}...\e[00m'")
      system("bundle exec rspec spec/active_record_models")
    end
  end

  desc "Runs all specs"
  task :all do
    Rake.application['spec:unit'].invoke
    Rake.application['spec:mysql2'].invoke
    Rake.application['spec:postgresql'].invoke
    Rake.application['spec:sqlite3'].invoke
  end
end

task default: 'spec:all'
