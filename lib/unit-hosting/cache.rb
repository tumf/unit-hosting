#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'pstore'
require 'unit-hosting/group'

module UnitHosting
  class Cache < PStore
    def groups
      transaction { |ps|
        ps["groups"] ||= []
      }
    end
    
    def update_all_groups! gs
      transaction { |ps|
        ps["groups"] = gs.update
      }
    end

    def update_group! group
      transaction { |ps|
        g = ps["groups"].find { |g|
          g.instance_id == group.instance_id
        }.try(:update)
        ps["groups"] << group.update  unless g
      }
    end

  end
end
