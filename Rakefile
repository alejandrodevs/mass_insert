require "bundler/gem_tasks"

namespace :spec do
  desc "Prepares the environment to use the gem"
  task :prepare do
    system("
      bundle install
      cd spec/active_record_dummy
      rake db:drop db:create db:migrate RAILS_ENV=mysql2
      rake db:drop db:create db:migrate RAILS_ENV=postgresql
      rake db:drop db:create db:migrate RAILS_ENV=sqlite3
    ")
  end

  desc "Runs all unit tests"
  task :all do
    system("echo '\e[00;32m\033[1mRunning all unit tests...\e[00m'")
    system("bundle exec rspec spec/lib/mass_insert_spec.rb spec/lib/mass_insert")
  end
  
  desc "Runs all the mysql2 specs"
  task :mysql2 do
    ENV["RAILS_ENV"] = "mysql2"
    system("echo '\e[00;32m\033[1mRunning the Mysql2 adapter tests...\e[00m'")
    system("bundle exec rspec spec/active_record_models")
  end

  desc "Runs all the Postgresql specs"
  task :postgresql do
    ENV["RAILS_ENV"] = "postgresql"
    system("echo '\e[00;32m\033[1mRunning the Postgresql adapter tests...\e[00m'")
    system("bundle exec rspec spec/active_record_models")
  end

  desc "Runs all the Sqlite3 specs"
  task :sqlite3 do
    ENV["RAILS_ENV"] = "sqlite3"
    system("echo '\e[00;32m\033[1mRunning the Sqlite3 adapter tests...\e[00m'")
    system("bundle exec rspec spec/active_record_models")
  end
end


task default: ['spec:mysql2', 'spec:postgresql', 'spec:sqlite3', 'spec:all']
