require "bundler/gem_tasks"

namespace :spec do
  desc "Runs all the specs"
  task :all do
    system("bundle exec rspec spec/mass_insert spec/mass_insert_spec.rb")
  end
  
  desc "Runs all the mysql specs"
  task :mysql2 do
    ENV["RAILS_ENV"] = "mysql2"
    system("bundle exec rspec spec/models")
  end
end


task default: ['spec:all', 'spec:mysql2']
