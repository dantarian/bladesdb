# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environments/test')
require 'cucumber/rails/world'
require 'email_spec/cucumber'
Cucumber::Rails::World.use_transactional_fixtures

#Seed the DB
ActiveRecord::FixtureSet.reset_cache  
fixtures_folder = File.join(Rails.root, 'db', 'fixtures')
fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)
ActionMailer::Base.delivery_method = :cache

