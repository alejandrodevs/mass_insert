require "bundler/gem_tasks"

namespace :spec do
  desc "Prepares the environment to use the gem"
  task :prepare do
    system("
      bundle install
      cd spec/active_record_dummy/
      bundle install
      rake db:create db:migrate RAILS_ENV=mysql2
      rake db:create db:migrate RAILS_ENV=postgresql
    ")
  end
  
  desc "Runs all the specs"
  task :all do
    system("echo '\e[00;32m\033[1mRunning all the unit tests...\e[00m'")
    system("bundle exec rspec spec/mass_insert spec/mass_insert_spec.rb")
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


task default: ['spec:all', 'spec:mysql2', 'spec:postgresql', 'spec:sqlite3']
