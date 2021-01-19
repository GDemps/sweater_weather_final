# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<MAPQUEST_API_KEY>') { ENV['MAPQUEST_API_KEY'] }
  config.filter_sensitive_data('<OPEN_WEATHER_API_KEY>') { ENV['OPEN_WEATHER_API_KEY'] }
  config.filter_sensitive_data('<UNSPLASH_ID>') { ENV['UNSPLASH_ID'] }
  config.filter_sensitive_data('<HIKING_PROJECT_KEY>') { ENV['HIKING_PROJECT_KEY'] }
  config.configure_rspec_metadata!
end

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
