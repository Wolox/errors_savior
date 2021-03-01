require 'bundler/setup'
require 'rails'

Bundler.require(:development, :test)

require 'rails_app/config/environment'
require 'rails_app/config/routes'
require 'rails_app/db/schema'

require 'errors_savior'

require 'errors_savior/rspec'

SimpleCov.start

ENV['RAILS_ENV'] = 'test'

ActiveRecord::Migration.maintain_test_schema!

Bundler.require(:default)

Dir[Rails.root.join('..', 'errors_savior', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include ActionDispatch::TestProcess
  config.include Response::JSONParser, type: :controller
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

require 'rspec/rails'
