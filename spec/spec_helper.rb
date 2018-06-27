require 'rubygems'
require 'rspec'
require 'faraday'
require 'nokogiri'
require 'dotenv'
Dotenv.load

# Rspec default setup
RSpec.configure do |config|
  config.order = "random"
end
