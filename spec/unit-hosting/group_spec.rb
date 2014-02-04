# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/group'

describe UnitHosting::Groups do
  describe "#tablize" do
    context "no groups" do
      before {
        @groups = [].extend(UnitHosting::Groups)
      }
      it "returns 'no groups'" do
        expect(@groups.tablize).to match /no groups/
      end
    end
    context "have 2 groups" do
      before {
        @groups = [
                   UnitHosting::Group.new("test-sg-123"),
                   UnitHosting::Group.new("test-sg-789"),
                  ].extend(UnitHosting::Groups)
      }
      it "returns table string" do
        expect(@groups.tablize).to match /test-sg-789/
      end
    end    
  end
end

describe UnitHosting::Group do
  before {
    @group = UnitHosting::Group.new("test-sg-123")
  }
  describe "#tablize" do
    context "no vms" do
      it "returns 'no vms'" do
        expect(@group.tablize).to match /no vms/
      end
    end
    context "have 2 vms" do
      before{
        @group.vms = [
               {
                 "instance_id" => "test-vm-1",
                 "status" =>"halted",
                 "display_name" =>"test-server-1"
               },
               {
                 "instance_id" => "test-vm-2",
                 "status" =>"halted",
                 "display_name" =>"test-server-2"
               }
              ]
      }
      it "returns table string" do
        expect(@group.tablize).to match /test-server-2/
      end
    end
  end
end
