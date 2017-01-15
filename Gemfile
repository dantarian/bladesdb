source 'https://rubygems.org'

gem 'rails', '~>4.0.0'
gem 'rake', '~>10.1.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '~> 1.3.11'


# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', '~> 0.12.2', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails', '~> 3.1.4'
gem 'jquery-ui-sass-rails', '~> 4.0.3.0'
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem "RedCloth", '~> 4.2.9'
gem "rdoc", '~> 4.2.2'
gem "seed-fu", '~> 2.3.5'
gem "test-unit", '~> 2.5.5'
gem "recaptcha", '~> 3.2.0', require: "recaptcha/rails"
gem "custom_error_message", '~> 1.1.1'
gem "jquery_datepicker", git: 'git://github.com/yctay/jquery_datepicker.git', branch: 'rails4'
gem "aasm", '~> 4.8.0'
gem "devise", '~> 3.5.6'
gem "devise-encryptable", '~> 0.2.0'
gem 'dynamic_form', '~> 1.1.4'
gem 'font-awesome-rails', '~> 4.5.0.1'
gem 'auto_strip_attributes', '~> 2.0'
gem 'schema_plus', '~> 1.4.1'
gem 'mail_form', '~> 1.5.1'
gem 'validates_timeliness', '~> 4.0'

group :production do
  gem 'newrelic_rpm', '~> 3.15.0.314'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 3.4.0', require: false, group: :development
gem 'capistrano-rvm', '~> 0.1.2'

# To use debugger
#gem 'debugger'
#gem 'ruby-debug-ide'


group :development, :test do
  gem 'rspec-rails', '~> 3.4.2'
  gem 'factory_girl_rails', '~> 4.6.0'
  gem 'foreman', '~> 0.78.0'
  gem 'capistrano-rails', '~> 1.1.6', require: false
  gem 'capistrano-bundler', '~> 1.1.4', require: false
  gem 'byebug', '~> 9.0.5'
end

group :test do
  gem 'faker', '~> 1.6.2'
  gem 'capybara', '~> 2.6.2'
  gem 'capybara-screenshot'
  gem 'guard-rspec', '~> 4.6.4'
  gem 'launchy', '~> 2.4.3'
  gem 'selenium-webdriver', '~> 2.52.0'
  gem 'cucumber-rails', '~> 1.4.3', require: false
  gem 'simplecov', '~> 0.7.1', require: false
  gem 'database_cleaner', '~> 1.5.1'
  gem 'email_spec', '~> 2.0.0'
  gem 'action_mailer_cache_delivery', '~> 0.3.7'
  gem 'poltergeist', '~> 1.12.0'
end


