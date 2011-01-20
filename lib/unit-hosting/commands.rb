#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require "rubygems"
require "highline/import"

require "keystorage"

require "unit-hosting"
require "unit-hosting/agent"
#require "unit-hosting/api"

module UnitHosting
  COMMANDS = ["help","login","logout"]
  class Commands

    def initialize(cmd_options,options)
      @options = options
      @command_options = cmd_options
      @help = false
      @agent = Agent.new

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


    def update
      start
      groups = @agent.groups
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

  end
end
