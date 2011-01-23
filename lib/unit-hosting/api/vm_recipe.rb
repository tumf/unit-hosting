#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
module UnitHosting
  module Api
    class VmRecipe
      attr_accessor :rootpw,:ssh_key,:plan_id
      attr_accessor :op_user,:op_mail,:user_script,:display_name
      def initialize
        @op_user = ENV['USER']
      end
      def load_ssh_key file
        File::open(file) do |f|
          @ssh_key =  f.read
        end
      end
      def params
        param = {
          "rootpw" => @rootpw,
          "ssh_key" => @ssh_key,
          "op_user" => @op_user,
          "op_mail" => @op_mail,
          "user_script" => @user_script,
          "plan_id" => @plan_id,
          "display_name" => @display_name
        }
      end
    end
  end
end
