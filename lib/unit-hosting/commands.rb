#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#require "rubygems"

require "unit-hosting"
require "unit-hosting/api"
require "unit-hosting/agent"
require "unit-hosting/cache"


module UnitHosting
  class Commands < CommandLineUtils::Commands
    # CommandLineUtils::COMMANDS += 
    def initialize
      super
      @commands += ["login","logout","update","groups","group"]
      @agent = Agent.new
      @cache_file =  ENV['HOME']+"/.unit-hosting.cache"
      @cache = Cache.new(@cache_file)

    end

    def login
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "Login to https://www.unit-hosting.com ."
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
      @summery = "Logout from https://www.unit-hosting.com ."
      @banner = ""
      return opt if @help
      Keystorage.delete("unit-hosting")
    end

    include UnitHosting::Api
    def update
      all = false
      opt = OptionParser.new
      opt.on('-a','--all', 'update all cache') { all = true }
      opt.parse!(@command_options)
      @summery = "Update cache."
      @banner = "GID [-a|--all]"
      return opt if @help
      gid = @command_options.shift


      start
      gs = @agent.groups.collect { |g|
        unless g.key.empty?
          v = @cache.groups.find{ |c| c.instance_id == g.instance_id }
          v.update if v and v.vms == nil
          g.vms = v.vms if v
          g
        end
      }.compact
      @cache.transaction { |ps|
        if all
          ps["groups"] = gs.find_all { |g|
            !g.key.empty?
          }.extend(Groups).update
        else
          group = ask_group(gid,gs)
          ps["groups"] = gs.collect{ |g|
            unless g.key.empty?
              g.update if g.instance_id == group.instance_id
              g
            end
          }.compact.extend(Groups)
        end
      }
    end

    def groups
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "List sever groups."
      @banner = ""
      return opt if @help

      puts @cache.groups.tablize
    end

    def group
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "List servers in group."
      @banner = ""
      return opt if @help

      id = @command_options.shift
      group = ask_group(id,@cache.groups)
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
        id = ask('Enter group id ([q]uit): ',gs.ids << 'q') { |q|
          q.validate = /\w+/
          q.readline = true
        }
      end
      raise SystemExit if id == "q"
      group = gs.find { |g| id == g.instance_id  }
      raise "Group #{id} is not exists." unless group
      group
    end

  end
end
