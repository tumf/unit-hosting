# -*- coding: utf-8 -*-
require 'helper'

class TestUnitHosting < Test::Unit::TestCase
  context "Agent" do
    should "access" do
      UnitHosting::Agent.new {|agent|
        agent.getr("/")
        assert(agent.page.body =~ /ユニットホスティング/,"to top page")
      }
    end
  end
end
