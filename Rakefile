require "bundler/gem_tasks"

namespace :spec do
  desc "Prepares the environment to use the gem"
  task :prepare do
    system("
      cd spec/active_record_dummy/
      bundle install
      rake db:create db:migrate RAILS_ENV=mysql2
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
end


task default: ['spec:all', 'spec:mysql2']
