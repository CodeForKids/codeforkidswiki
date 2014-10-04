require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def setup
    FakeWeb.allow_net_connect = %r[^https?://codeclimate.com]
    FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => "{}")
  end

  def setup_controller_tests
    session[:user_id] = 1
    session[:user_email] = 'test@codeforkids.ca'
  end

  # Add more helper methods to be used by all tests here...
end
