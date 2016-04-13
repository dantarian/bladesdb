# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"

Recaptcha.configure do |config|
  config.public_key = "6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI"
  config.private_key = "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe"
end

require File.expand_path(File.dirname(__FILE__) + '/../../config/environments/test')
require File.expand_path(File.dirname(__FILE__) + "/../../config/initializers/date_time_formats")

require 'cucumber/rails/world'
require 'email_spec/cucumber'
Cucumber::Rails::World.use_transactional_fixtures = false

class ActiveRecord::Base  
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end  
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection  

