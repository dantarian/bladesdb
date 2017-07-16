# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"

Recaptcha.configure do |config|
  config.public_key = "6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI"
  config.private_key = "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe"
end

require 'simplecov'
SimpleCov.start('rails')

require File.expand_path(File.dirname(__FILE__) + '/../../config/environments/test')
require File.expand_path(File.dirname(__FILE__) + "/../../config/initializers/date_time_formats")

require 'email_spec/cucumber'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Capybara.default_driver = :rack_test
Capybara.default_max_wait_time = 10

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

require 'capybara-screenshot/cucumber'
