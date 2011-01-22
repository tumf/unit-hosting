#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'command-line-utils'
require 'unit-hosting/commands'
module UnitHosting
  class CLI < CommandLineUtils::CLI
    def initialize
      super
      @commands = Commands.new
    end
    def dispatch(cmd,cmd_argv)
      @commands.send(cmd.sub(/:/,"_"))
    end
  end
end
