require "bundler/gem_tasks"

namespace :spec do
  desc "Runs all the specs"
  task :all do
    system("bundle exec rspec")
  end
end

task default: 'spec:all'
