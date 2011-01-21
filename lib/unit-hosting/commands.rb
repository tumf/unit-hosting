#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require "rubygems"
require "highline/import"

require "keystorage"

require "unit-hosting"
require "unit-hosting/api"
require "unit-hosting/agent"
require "unit-hosting/cache"
#require "unit-hosting/api"

module UnitHosting
  COMMANDS = ["help","login","logout","update"]
  class Commands

    def initialize(cmd_options,options)
      @options = options
      @command_options = cmd_options
      @help = false
      @agent = Agent.new
      @cache_file =  ENV['HOME']+"/.unit-hosting.cache"
      @cache = Cache.new(@cache_file)

      @summery = ""
      @banner = ""
    end

    def help
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "Show command helps."
      @banner = "command"
      return opt if @help
      @help = true
      command = @command_options.shift
      raise "Unknown command: " + command unless COMMANDS.include?(command)
      opt = send(command)
      puts "Summery: #{@summery}"
      opt.banner="Usage: unit-hosting [options] #{command} #{@banner}"
      puts opt
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
      Keystorage.delete("bookscan")
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
