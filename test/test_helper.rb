ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require "minitest/pride"
require 'capybara'
require 'database_cleaner'
require 'pry'
require 'tilt/erb'

Capybara.app = TrafficSpy::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module Helpers
  
  def create_payloads
    TrafficSpy::Payload.create({
        url: "http://jumpstartlab.com/blog", # same as 'source.payloads.new'
        sha: "1234",
        source_id: 1,
        responded_in: 37,
        resolution: "1920 x 1280",
        browser: "Chrome 24.0.1309",
        operating_system: "Mac OS X 10.8.2",
        requested_at: "2013-02-16 21:38:28 -0700",
        request_type: "GET",
        referred_by: "http://jumpstartlab.com",
        event_name: "socialLogin"})
    
    TrafficSpy::Payload.create({
        url: "http://jumpstartlab.com/blog",
        sha: 2345,
        source_id: 1,
        responded_in: 42,
        resolution: "1240 x 1860",
        browser: "Chrome 22.0.1309",
        operating_system: "Mac OS X 10.8.2",
        requested_at: "2013-02-16 14:22:58 -0700",
        request_type: "GET",
        referred_by: "http://jumpstartlab.com",
        event_name: "socialLogin"})
    
    TrafficSpy::Payload.create(
        {url: "http://jumpstartlab.com/blog",
        sha: 3456,
        source_id: 1,
        responded_in: 29,
        resolution: "1640 x 1480",
        browser: "Chrome 24.0.1309",
        operating_system: "Mac OS X 10.8.1",
        requested_at: "2013-02-16 10:04:24 -0700",
        request_type: "GET",
        referred_by: "http://jumpstartlab.com",
        event_name: "socialLogin"})
  end
  
  def create_source(identifier, root_url)
    TrafficSpy::Source.create({:identifier => identifier, :root_url => root_url})
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include Rack::Test::Methods
  include Helpers

  def app
    TrafficSpy::Server
  end
  
  def setup
    DatabaseCleaner.start
  end
  
  def teardown
    DatabaseCleaner.clean
  end
end

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
end

class ModelTest < Minitest::Test
  include Rack::Test::Methods
  include Helpers

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

