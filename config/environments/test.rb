Blades::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_files = true
  config.static_cache_control = "public, max-age=3600"
  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :cache delivery method accumulates sent emails in the
  # ActionMailer::Base.cached_deliveries array.
  config.action_mailer.delivery_method = :cache
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Raise errors for deprecations
  config.active_support.deprecation = :raise

  # Host for inclusion in e-mails.
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.eager_load = false
  
  config.allow_concurrency = false

  config.active_record.raise_in_transactional_callbacks = true
  config.active_support.test_order = :random
end
