# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/api/vm'

describe UnitHosting::Api::Vm do
  before {
    @vm = UnitHosting::Api::Vm.new("test-vm-1","test-1-dummy-key")
  }
  describe "#foo" do
    it "calls Base::server_call('vm.foo')" do
      expect(@vm).to receive(:server_call).with("vm.foo")
      @vm.foo
    end
    it "calls Base::server_call('vm.foo','var' =>'val')" do
      expect(@vm).to receive(:server_call).with("vm.foo",'var' =>'val')
      @vm.foo "var"=>"val"
    end
  end
      
  describe "#reboot" do
    it "calls Base::server_call('vm.reboot')" do
      expect(@vm).to receive(:server_call).with("vm.reboot")
      @vm.reboot
    end
  end
  describe "#start" do
    it "calls Base::server_call('vm.start')" do
      expect(@vm).to receive(:server_call).with("vm.start")
      @vm.start
    end
  end
  describe "#shutdown" do
    it "calls Base::server_call('vm.shutdown')" do
      expect(@vm).to receive(:server_call).with("vm.shutdown")
      @vm.shutdown
    end
  end
  describe "#power_off" do
    it "calls Base::server_call('vm.powerOff')" do
      expect(@vm).to receive(:server_call).with("vm.powerOff")
      @vm.power_off
    end
  end
  describe "#destroy" do
    it "calls Base::server_call('vm.destroy')" do
      expect(@vm).to receive(:server_call).with("vm.destroy")
      @vm.destroy
    end
  end
  describe "#status?" do
    it "calls Base::server_call('vm.getStatus')" do
      expect(@vm).to receive(:server_call).with("vm.getStatus")
      @vm.status?
    end
  end

  describe "#memory_unit_size" do
    it "calls Base::server_call('vm.setMemoryUnitSize')" do
      expect(@vm).to receive(:server_call).with("vm.setMemoryUnitSize","size" =>123)
      @vm.memory_unit_size(123)
    end
  end
  describe "#cup_unit_num" do
    it "calls Base::server_call('vm.setCpuUnitNum')" do
      expect(@vm).to receive(:server_call).with("vm.setCpuUnitNum","num" =>456)
      @vm.cpu_unit_num(456)
    end
  end

  describe "#memory_unit_size?" do
    it "calls Base::server_call('vm.getMemoryUnitSize')" do
      expect(@vm).to receive(:server_call).with("vm.getMemoryUnitSize")
      @vm.memory_unit_size?
    end
  end
  describe "#cup_unit_num?" do
    it "calls Base::server_call('vm.setCpuUnitNum')" do
      expect(@vm).to receive(:server_call).with("vm.getCpuUnitNum")
      @vm.cpu_unit_num?
    end
  end
  describe "#ips" do
    it "calls Base::server_call('vm.getIpInfo')" do
      expect(@vm).to receive(:server_call).with("vm.getIpInfo")
      @vm.ips
    end
  end
  describe "#display_name" do
    it "calls Base::server_call('vm.getDisplayName')" do
      expect(@vm).to receive(:server_call).with("vm.getDisplayName")
      @vm.display_name
    end
  end
  describe "#display_name=" do
    it "calls Base::server_call('vm.setDisplayName')" do
      expect(@vm).to receive(:server_call).with("vm.setDisplayName","display_name" =>"test-server")
      @vm.display_name= "test-server"
    end
  end
  describe "#replicate" do
    it "calls Base::server_call('vm.replicate')" do
      expect(@vm).to receive(:server_call).with("vm.replicate","display_name" =>"test-server")
      @vm.replicate "test-server"
    end
  end
  describe "#plugVif" do
    it "calls Base::server_call('vm.plugVif')" do
      expect(@vm).to receive(:server_call).with("vm.plugVif","network_uuid" =>"test-network-uuid","device" =>2)
      @vm.plugVif("test-network-uuid",2)
    end
  end
  describe "#vifs" do
    it "calls Base::server_call('vm.getVifs')" do
      expect(@vm).to receive(:server_call).with("vm.getVifs")
      @vm.vifs
    end
  end
  describe "#unplugVif" do
    it "calls Base::server_call('vm.unplugVif')" do
      expect(@vm).to receive(:server_call).with("vm.unplugVif","vif_uuid" =>"test-vif-uuid")
      @vm.unplugVif "test-vif-uuid"
    end
  end
  describe "#set_vm_data" do
    it "calls Base::server_call('vm.setVmData')" do
      expect(@vm).to receive(:server_call).with("vm.setVmData","key" =>"test-key-1","value" =>"test-val-1")
      @vm.set_vm_data "test-key-1","test-val-1"
    end
  end
  describe "#get_vm_data" do
    it "calls Base::server_call('vm.getVmData')" do
      expect(@vm).to receive(:server_call).with("vm.getVmData","key" =>"test-key-1")
      @vm.get_vm_data "test-key-1"
    end
  end
  describe "#set_pv_args" do
    it "calls Base::server_call('vm.setPvArgs')" do
      expect(@vm).to receive(:server_call).with("vm.setPvArgs","pv_args" =>"test-args-1")
      @vm.set_pv_args "test-args-1"
    end
  end
  describe "#get_pv_args" do
    it "calls Base::server_call('vm.getPvArgs')" do
      expect(@vm).to receive(:server_call).with("vm.setPvArgs","pv_args" =>"test-args-1")
      @vm.set_pv_args "test-args-1"
    end
  end
end
