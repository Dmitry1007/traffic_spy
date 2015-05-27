ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require "minitest/pride"
require 'capybara'
require 'database_cleaner'

Capybara.app = TrafficSpy::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

# then, whenever you need to clean the DB
# DatabaseCleaner.clean



# DatabaseCleaner.strategy = :transaction

# class MiniTest::Spec
#   before :each do
#     DatabaseCleaner.start
#   end

#   after :each do
#     DatabaseCleaner.clean
#   end
# end


# with the minitest-around gem, this may be used instead:

class ControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  # around do |tests|
  #   DatabaseCleaner.cleaning(&tests)
  # end
end