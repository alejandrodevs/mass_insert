require 'bundler/gem_tasks'

namespace :specs do
  desc 'Unit tests'
  task :unit do
    system('bundle exec rspec')
  end
end

task default: 'specs:unit'
