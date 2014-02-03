#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#require "rubygems"

require "unit-hosting/api"
require "unit-hosting/agent"
require "unit-hosting/cache"


module UnitHosting
  class Commands < CommandLineUtils::Commands
    class ArgumentError < StandardError;end
    # CommandLineUtils::COMMANDS +=
    attr_accessor :agent, :cache
    def initialize endpoint =nil
      @command_options = []
      super()
      @commands += ["login","logout","update","groups","group"]
      #@agent = Agent.new
      @agent = Agent.new(endpoint)
      @cache = nil
    end

    def cache
      @cache ||= Cache.new(cache_file)
    end

    def login
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "Login to https://cloud.unit-hosting.com ."
      @banner = ""
      return opt if @help

      user = ask('Enter user: ') do |q|
        q.validate = /\w+/
      end

      ok = false
      while(!ok) 
        password = ask("Enter your password: ") do |q|
          q.validate = /\w+/
          q.echo = false
        end

        @agent.login(user,password)
        if @agent.login? # => OK
          ok = true
          Keystorage.set("unit-hosting",user,password)
          puts "login OK"
        else
          puts "password mismatch"
        end
      end
    end

    def logout
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "Logout from https://cloud.unit-hosting.com ."
      @banner = ""
      return opt if @help
      Keystorage.delete("unit-hosting")
    end

    include UnitHosting::Api
    def update all = false
      opt = OptionParser.new
      opt.on('-a','--all', 'update all cache') { all = true }
      opt.parse!(@command_options)
      @summery = "Update cache."
      @banner = "GID [-a|--all]"
      return opt if @help
      gid = @command_options.shift

      start
      if all
        cache.update_all_groups!(@agent.groups)
      else
        group = ask_group(gid,cache.groups)
        cache.update_group!(group)
      end
    end

    def groups
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "List sever groups."
      @banner = ""
      return opt if @help

      puts cache.groups.tablize
    end

    def group
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "List servers in group."
      @banner = ""
      return opt if @help

      id = @command_options.shift
      group = ask_group(id,cache.groups)
      puts group.tablize if group
    end

    def vif_plug
      
    end

    def vm_create
      # vm:create tumf-sg-1
    end

    private
    def start
      return true if @agent.login?
      user =  Keystorage.list("unit-hosting").shift
      login unless user
      if user
        @agent.login(user,Keystorage.get("unit-hosting",user))
        login unless @agent.login?
      end
    end

    def ask_group(id,gs)
      unless id
        puts gs.extend(Groups).tablize
        id = ask('Enter group id: ',gs.ids) { |q|
          q.validate = /\w+/
          q.readline = true
        }
      end
      group = gs.find { |g| id == g.instance_id  }
      raise ArgumentError,"Group #{id} is not exists." unless group
      group
    end

    def cache_file file = ".unit-hosting.cache"
      File.join ENV['HOME'],file
    end
  end
end
