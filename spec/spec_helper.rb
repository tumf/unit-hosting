$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))
require 'rspec'
require 'webmock/rspec'
require "tempfile"

RSpec.configure do |config|
end

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

Coveralls.wear!
