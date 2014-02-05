#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'pstore'
require 'unit-hosting/group'

module UnitHosting
  class Cache < PStore
    def groups
      transaction { |ps|
        ps["groups"] ||= [].extend(UnitHosting::Groups)
      }
    end
    
    def update_all_groups! gs
      transaction { |ps|
        ps["groups"] = gs.update
      }
    end

    def update_group! group
      transaction { |ps|
        groups = ps["groups"].reject { |g|
          g.instance_id == group.instance_id
        }
        groups << group.update
        ps["groups"] = groups
      }
    end

  end
end
