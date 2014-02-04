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

  
require 'stringio'
def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval "$#{stream} = #{stream.upcase}"
  end
  result
end
