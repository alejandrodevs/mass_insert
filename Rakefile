require 'bundler/gem_tasks'
require 'rake/testtask'

ADAPTERS = %w(mysql2 postgresql sqlite3).freeze

ADAPTERS.each do |adapter|
  namespace :test do
    desc "Runs #{adapter} tests."
    Rake::TestTask.new(adapter) do |t|
      t.libs << 'test'
      t.libs << 'lib'
      t.test_files = FileList[
        "test/support/adapters/#{adapter}.rb",
        "test/adapters/#{adapter}/**/*_test.rb"]
    end
  end
end

namespace :test do
  desc 'Runs tests.'
  task :all do |t|
    ADAPTERS.each do |adapter|
      Rake.application["test:#{adapter}"].invoke
    end
  end
end

task default: 'test:all'
