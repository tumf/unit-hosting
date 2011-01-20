#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require "rubygems"
require "mechanize"

module UnitHosting
  UHURL = "https://www.unit-hosting.com"
  class Agent < Mechanize
    def initialize
      super
      max_history = 0
    end

    def getr path
      get(UHURL + path)
    end
    
    def login id,password
      getr("/login")
      form = page.forms[0]
      form.fields.find{|f| f.name == "username" }.value = id
      form.fields.find{|f| f.name == "password" }.value = password
      submit(form)
    end

    def login?
      getr("/dashboard")
      /ログアウト/ =~ page.body # => OK
    end

    def logout
      getr("/logout")
    end

    def groups
      getr("/my/group")
      page.search("#server-groups .instance_id a").each { |i|
        puts i.text.to_s
      }
    end
  end
end
