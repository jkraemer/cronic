# encoding: utf-8

require File.expand_path("../lib/cronic/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cronic"
  s.version     = Cronic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jens Krämer']
  s.email       = ["jk@jkraemer.net"]
  s.homepage    = "http://github.com/jkraemer/cronic"
  s.summary     = "Cron like scheduler daemon for Rails applications"
  s.description = "Taking advantage of Rufus Scheduler and Dante to provide a long running daemon for cron like jobs to be run in the context of your Rails application, without loading the full environment each and every time a job is run."

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "cronic"

  # If you have other dependencies, add them here
  s.add_dependency "rufus-scheduler", "~> 2.0.17"
  s.add_dependency "dante", "~> 0.1.5"
  s.add_dependency "rails", ">= 3"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib,recipes}/**/*.rb", "templates/**/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

end
