#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require "mechanize"
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module UnitHosting
  UHURL = "https://cloud.unit-hosting.com"
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

    def page_body
      body = page.body
      body.force_encoding('utf-8') if body.respond_to? :force_encoding
    end

    def login?
      getr("/dashboard")
      /ログアウト/ =~ page_body # => OK
    end

    def logout
      getr("/logout")
    end

    def group(id)
      getr("/my/group/#{id}/info")
      group = Group.new(id)
      group.key  = page.at("span.api-key").text.to_s
      group.name = page.at("span.group-name").text.to_s
      group
    end

    def groups
      getr("/my/group")
      page.search("#server-groups .instance_id a").collect { |a|
        group(a.text.to_s)
      }.extend(Groups)
    end

  end
end
