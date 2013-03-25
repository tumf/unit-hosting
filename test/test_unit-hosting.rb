# -*- coding: utf-8 -*-
require 'helper'
class TestUnitHosting < Test::Unit::TestCase
  context "Agent" do
    should "access" do
      agent = UnitHosting::Agent.new
      agent.getr("/")
      assert(agent.page_body =~ /ユニットホスティング/,"to top page")
    end
  end
end
