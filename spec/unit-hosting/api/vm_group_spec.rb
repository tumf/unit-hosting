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
end
