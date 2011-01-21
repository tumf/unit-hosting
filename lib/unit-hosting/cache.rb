#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'pstore'
require 'unit-hosting/group'

module UnitHosting
  class Cache < PStore
    def groups
      transaction { |ps| ps["groups"] ||=[] }.extend(Groups)
    end
  end
end
