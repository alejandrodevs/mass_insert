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
end

task default: ['spec:mysql2', 'spec:postgresql', 'spec:sqlite3', 'spec:unit']
