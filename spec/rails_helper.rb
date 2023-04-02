# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent db truncation if the env is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Additional requires. Rails not loaded yet

# 2) auto-requiring all files in the support dir
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Before running tests: apply pending migrations
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# 3) Configurations
RSpec.configure do |config|
  # 3.1) Define ActiveRecord fixtures path (for ActiveRecord)
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # 3.2) Run each example within a transaction (for ActiveRecord)
  config.use_transactional_fixtures = true

  # 3.3) Test behaviours based on file location eg.(, :type => :controller)
  config.infer_spec_type_from_file_location!

  # 3.4) Filter lines (from Rails gems in backtraces)
  config.filter_rails_from_backtrace!
  
end
