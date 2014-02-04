#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'mutter'
require 'unit-hosting/api'

module UnitHosting
  module Groups

    def update
      each { |g| g.update}
      self
    end

    def tablize
      return "no groups" if length == 0
      table = Mutter::Table.new(:delimiter => '|') do
        column :style => :green
        column
      end
      each do |group|
        table << [group.instance_id, group.name]
      end
      table.to_s if length > 0
    end

    def ids
      collect { |g| g.instance_id }
    end
  end

  class Group
    include UnitHosting::Api

    attr_accessor :instance_id, :key, :name, :remote, :vms
    alias :apikey :key

    def initialize(instance_id = nil)
      @instance_id = instance_id
    end

    def update
      # STDERR.puts "update #{instance_id}"
      @vms = VmGroup.new(@instance_id,@key).vms
      self
    end

    def tablize
      table = Mutter::Table.new(:delimiter => '|') do
        column :style => :green
        column;column
      end
      return "#{instance_id} has no vms" unless @vms
      @vms.each { |vm|
        table << [vm["instance_id"],vm["status"],vm["display_name"]]
      }
      table.to_s if @vms.length > 0
    end
  end

end
