# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/api/vm_group'

describe UnitHosting::Api::VmGroup do
  before {
    @group = UnitHosting::Api::VmGroup.new
    @recipe = UnitHosting::Api::VmRecipe.new
  }
  describe "#create_vm" do
    it "calls Base::server_call('vmGroup.createVm')" do
      expect(@group).to receive(:server_call).with("vmGroup.createVm",@recipe.params).
        and_return("result" => "success")
      @group.create_vm(@recipe)
    end
  end

  describe "#vm_api_key" do
    
  end

  describe "#vm" do
    context "when there is no such a VM" do
      before {
        @group.stub(:vms).and_return([
                                      { :instance_id =>"test-vm-1"},
                                      { :instance_id =>"test-vm-2"},
                                      { :instance_id =>"test-vm-3"}
                                     ])
      }
      it "returns Vm instance" do
        expect(@group.vm("test-vm-123")).to be_a UnitHosting::Api::Vm
        expect(@group.vm("test-vm-123").api_key).to eq nil
      end
    end
    context "when there is no such a VM" do
      before {
        @group.stub(:vms).and_return([
                                      { :instance_id =>"test-vm-1"},
                                      { :instance_id =>"test-vm-2"},
                                      { :instance_id =>"test-vm-3"}
                                     ])
      }
      it "returns Vm instance" do
        expect(@group.vm("test-vm-2")).to be_a UnitHosting::Api::Vm
      end
    end
  end

  describe "#networks" do
    it "call vmGroup.getNetworks" do
      expect(@group).to receive(:server_call).with("vmGroup.getNetworks").once
      @group.networks
    end
  end
end
