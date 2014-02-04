#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'unit-hosting/commands'
module UnitHosting
  class CLI < CommandLineUtils::CLI
    attr_accessor :commands
    def initialize
      super
      @commands = Commands.new
    end
    def version
      File.open(File.join(File.dirname(__FILE__) ,
                          "..","..","VERSION"),"r") { |file|
        puts file.gets
      }
    end
    def dispatch(cmd,cmd_argv)
      @commands.send(cmd.sub(/:/,"_"))
    end
  end
end
