require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rspec'
require 'rspec/core/rake_task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the fbrails plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the fbrails plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Fbrails'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Default: run specs'
task :default => :spec  
Rspec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end