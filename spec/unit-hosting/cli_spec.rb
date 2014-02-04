# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/cli'

describe UnitHosting::CLI do
  before {
    @cli = UnitHosting::CLI.new
  }
  describe "#version" do
    it "print version string" do
      expect(capture(:stdout) {
               @cli.version}).to match /\d+\.\d+\.\d+/
    end
  end
  describe "#dispatch" do
    context "foo:bar" do
      it "call @commands.foo_bar" do
        expect(@cli.commands).to receive(:foo_bar).once
        @cli.dispatch("foo:bar",[])
      end
    end
  end
end
