#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'unit-hosting/api/base'

module UnitHosting
  module Api
    class Vm < Base
      def initialize(instance_id=nil,api_key=nil)
        @instance_id_elm = '/server/instance_id'
        @api_key_elm = '/server/key'
        super
      end
      def reboot
        server_call("vm.reboot")
      end
      def start
        server_call("vm.start")
      end
      def shutdown
        server_call("vm.shutdown")
      end
      def power_off
        server_call("vm.powerOff")
      end
      def destroy
        server_call("vm.destroy")
      end
      def status?
        server_call("vm.getStatus")
      end
      def memory_unit_size size
        server_call("vm.setMemoryUnitSize",{"size" => size})
      end
      def cpu_unit_num num
        server_call("vm.setCpuUnitNum",{"num" => num})
      end
      def memory_unit_size?
        server_call("vm.getMemoryUnitSize")
      end
      def cpu_unit_num?
        server_call("vm.getCpuUnitNum")
      end
      def ips
        server_call("vm.getIpInfo")
      end
      def display_name
        server_call("vm.getDisplayName")
      end
      def display_name= name
        server_call("vm.setDisplayName",{"display_name" => name})
      end
      def replicate name=""
        server_call("vm.replicate",{"display_name" => name})
      end
      def plugVif network,device = nil
        server_call("vm.plugVif",{"network_uuid" => network,"device" => device})
      end
      def vifs
        server_call("vm.getVifs")
      end
      def unplugVif vif_uuid
        server_call("vm.unplugVif",{"vif_uuid" => vif_uuid})
      end
      def set_vm_data(key,val)
        server_call("vm.setVmData",{"key" =>key,"value" =>val})
      end
      def get_vm_data(key)
        server_call("vm.getVmData",{"key" =>key})
      end
    end
  end
end
