# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/cache'

describe UnitHosting::Cache do
  before{
    @cache_file = Tempfile.new('cache')
    @cache_file.close
    @cache = UnitHosting::Cache.new(@cache_file.path)
  }
  after {
    @cache_file.unlink
  }
  describe "#update_group!" do
    context "when there are three gropus in cache." do
      before{
        @group222 = UnitHosting::Group.new("test-sg-222")
        @cache.transaction { |ps|
          ps["groups"] = [
                          UnitHosting::Group.new("test-sg-1"),
                          UnitHosting::Group.new("test-sg-2"),
                          UnitHosting::Group.new("test-sg-3"),
                          @group222
                         ].extend(UnitHosting::Groups)
        }
      }
      it "update given group" do
        expect(@group222).to receive(:update)
        @cache.update_group!(@group222)
      end
    end
  end
end
