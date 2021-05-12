# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'selenium-webdriver'
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 5

# Capybara.register_driver :poltergeist_debug do |app|
#   driver_options = {
#     inspector: true,
#     timeout: 5,
#     js_errors: false,
#     debug: false,
#     phantomjs_logger: Logger.new('/dev/null')
#   }
#   if ENV['DEBUG_PHANTOMJS']
#     driver_options.merge!({
#       logger: Kernel,
#       js_errors: true,
#       debug: true,
#       phantomjs_logger: File.open(Rails.root.join('log/phantomjs.log'), 'a')
#     })
#   end
#   Capybara::Poltergeist::Driver.new(app, driver_options)
# end

# Capybara.javascript_driver = :poltergeist_debug
# Capybara.default_driver = :poltergeist_debug

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseRewinder.clean_all
    # or
    # DatabaseRewinder.clean_with :any_arg_that_would_be_actually_ignored_anyway
    end

  config.after(:each) do
    DatabaseRewinder.clean
  end
  # config.include Devise::Test::IntegrationHelpers, type: :feature
  # config.include Warden::Test::Helpers

  # config.before(:suite) do
  #   if config.use_transactional_fixtures?
  #     raise(<<-MSG)
  #       Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
  #       (or set it to false) to prevent uncommitted transactions being used in
  #       JavaScript-dependent specs.
  #       During testing, the app-under-test that the browser driver connects to
  #       uses a different database connection to the database connection used by
  #       the spec. The app's database connection would not be able to access
  #       uncommitted transaction data setup over the spec's database connection.
  #     MSG
  #   end
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  # config.before(:each) do
  #   DatabaseCleaner.strategy = :transaction
  # end

  # config.before(:each, type: :feature) do
  #   # :rack_test driver's Rack app under test shares database connection
  #   # with the specs, so continue to use transaction strategy for speed.
  #   driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

  #   unless driver_shares_db_connection_with_specs
  #     # Driver is probably for an external browser with an app
  #     # under test that does *not* share a database connection with the
  #     # specs, so use truncation strategy.
  #     DatabaseCleaner.strategy = :truncation
  #   end
  # end

  # config.before(:each) do
  #   DatabaseCleaner.start
  # end

  # config.append_after(:each) do
  #   DatabaseCleaner.clean
  # end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end