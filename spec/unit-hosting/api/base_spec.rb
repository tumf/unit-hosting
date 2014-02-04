# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/api/base'

describe UnitHosting::Api do
  describe "#keypath" do
    it "returns keypath" do
      expect(UnitHosting::Api.keypath("foo")).to match /foo\.key$/
    end
  end
end

describe UnitHosting::Api::Base do
  before {
    @base = UnitHosting::Api::Base.new
    
    @key_file = Tempfile.new('key')
    @key_file.puts(<<"KEY")
<?xml version="1.0" encoding="UTF-8"?>
<server-group>
  <instance_id>test-sg-1</instance_id>
  <key>dummy-test-key-1</key>
</server-group>
KEY
    @key_file.close
    UnitHosting::Api.stub(:keypath).
    with("foo").and_return(@key_file.path)
  }
  after {
    @key_file.unlink
  }
  describe ".load" do
    it "load a key file" do
      expect(@base.load("foo")).to be_a UnitHosting::Api::Base
    end
  end
end
