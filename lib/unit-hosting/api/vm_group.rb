#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'unit-hosting/api/base'
require 'unit-hosting/api/vm'

module UnitHosting
  module Api
    class VmGroup < Base
      def initialize(instance_id=nil,api_key=nil)
        @instance_id_elm = '/server-group/instance_id'
        @api_key_elm = '/server-group/key'
        super
      end
      # このサーバグループに含まれるVMオブジェクトをすべて返す
      def vms
        server_call("vmGroup.getVms")
      end
      def vm_api_key instance_id
        vms.each do |vm|
          return vm["api_key"] if vm["instance_id"] == instance_id
        end
      end
      # instance_idに紐づくvmを返す
      def vm(instance_id)
        Vm.new(instance_id,vm_api_key(instance_id))
      end
      # vmの作成
      def create_vm(recipe)
        r = server_call("vmGroup.createVm",recipe.params)
        return false if r["result"] != "success"
        r
      end

      def networks
        server_call("vmGroup.getNetworks")
      end

    end
  end
end
