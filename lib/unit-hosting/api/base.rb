#!/usr/bin/env ruby
# vim:set fileencoding=utf-8:
require 'unit-hosting'
module UnitHosting
  module Api
    def keypath instance_id
      "%s/.UnitHosting/keys/%s.key" % [ENV['HOME'], instance_id]
    end
    module_function :keypath
    class Base
      attr_reader :instance_id,:api_key
      attr_accessor :server
      def initialize(instance_id=nil,api_key=nil)
        @instance_id = instance_id
        @api_key = api_key
        @server = XMLRPC::Client.
          new_from_uri("https://cloud.unit-hosting.com/xmlrpc",nil,1000)
        @server.instance_variable_get(:@http).
          instance_variable_get(:@ssl_context).
          instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
        yield self if block_given?
        self
      end
      def self.load(instance_id)
        obj = self.new.load(instance_id)
        yield obj if block_given?
        obj
      end
      def load(instance_id)
        load_key(UnitHosting::Api::keypath(instance_id))
      end
      def load_key(file)
        File::open(file) do |f|
          xml = f.read
          doc = REXML::Document.new(xml)
          @instance_id = doc.elements[@instance_id_elm].text
          @api_key = doc.elements[@api_key_elm].text
        end
        self
      end
      def server_call(method,param = {})
        param["instance_id"] = @instance_id
        param["api_key"] = @api_key
        result = @server.call(method,param)
        # puts @server.http_last_response.body
        return result
      end
    end
  end
end
