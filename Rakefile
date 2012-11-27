require "bundler"
Bundler.setup

require 'rake/testtask'

desc 'Test the library.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

gemspec = eval(File.read("cronic.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["cronic.gemspec"] do
  system "gem build cronic.gemspec"
  system "gem install cronic-#{Cronic::VERSION}.gem"
end
