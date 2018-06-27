require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'

# register selenium driver
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# Setup capybara to run specs
Capybara.configure do |config|
  config.run_server     = false
  config.default_driver = :selenium
end

Capybara.default_wait_time = 10