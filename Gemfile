source 'https://rubygems.org'

gem 'rails', '~> 6.1.7', '>= 6.1.7.2'
gem 'rake', '~>12.3.0'
gem 'bootsnap', '~>1.18.4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '~> 1.4.0'


# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails', '~> 5.0.8'
gem 'coffee-rails', '~> 5.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'mini_racer', '~> 0.16.0', :platforms => :ruby

gem 'uglifier', '>= 4.2.0'

gem 'jquery-rails', '~> 4.4.0'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem "RedCloth", '~> 4.3.3'
gem "rdoc", '~> 6.3.0'
gem "seed-fu", "~> 2.3.9"
gem "test-unit", '~> 3.3.8'
gem "recaptcha", '~> 5.6.0'
gem "custom_error_message", '~> 1.1.1'
gem "aasm", '~> 5.1.1'
gem "devise", "~> 4.8.0"
gem "devise-encryptable", "~> 0.2.0"
gem 'font-awesome-rails', '~> 4.7.0.8'
gem 'auto_strip_attributes', '~> 2.6.0'
gem 'schema_plus_foreign_keys', '~> 1.1.0'
gem 'scenic', '~> 1.7.0'
gem 'scenic_sqlite_adapter', '~> 0.1.0'
gem 'schema_auto_foreign_keys', '~> 1.1.0'
gem 'mail_form', '~> 1.10.0'
gem 'validates_timeliness', '~> 6.0.1'

# Simplified logging
gem "lograge"

# Short term fix to suppress some unnecessary warnings - remove after upgrading to Ruby 3
gem 'net-http', '~> 0.3.2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 3.19', '>= 3.19.2', require: false, group: :development
gem 'capistrano-rvm', '~> 0.1.2'

# To use debugger
#gem 'debugger'
#gem 'ruby-debug-ide'


group :development, :test do
  gem 'puma'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'foreman', '~> 0.87.2'
  gem 'capistrano-rails', '~> 1.7.0', require: false
  gem 'capistrano-bundler', '~> 2.1.1', require: false
  gem 'byebug', '~> 11.1.3'
  gem 'ed25519', '~> 1.2', require: false
  gem 'bcrypt_pbkdf', '~> 1.0', require: false
end

group :test do
  gem 'faker', '~> 2.22.0'
  gem 'capybara', '~> 3.40.0'
  gem 'capybara-screenshot', '>= 1.0.26'
  gem 'guard-rspec', '~> 4.7.3'
  gem 'launchy', '~> 2.5.0'
  gem 'selenium-webdriver', '~> 4.31.0'
  gem 'cucumber-rails', '~> 2.2.0', require: false
  gem 'simplecov', '~> 0.18.5', require: false
  gem 'database_cleaner', '~> 1.8.5'
  gem 'email_spec', '~> 2.2.0'
  gem 'rails-perftest', '~> 0.0.7'
  gem 'ruby-prof', '~> 1.4.2'
end
