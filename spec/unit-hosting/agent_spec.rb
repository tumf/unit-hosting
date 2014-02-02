# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/agent'

describe UnitHosting::Agent do
  ENDPOINT= "https://example.com/t/es/t"
  describe "#initialize" do
    it "initialize new UnitHosting::Agent class" do
      expect(UnitHosting::Agent.new).to be_a UnitHosting::Agent
    end
  end
  before {
    @endpoint = "https://example.net"
    @agent = UnitHosting::Agent.new(@endpoint)
  }
  describe "#login" do
    before {
      stub_request(:get, @endpoint + '/login').
      to_return(:status =>200, :headers =>{content_type: 'text/html; charset=utf-8'},
                :body => <<HTML)
<form action="/login" method="post">
 <input type="hidden" name="_csrf_token" value="" />
 <input type="text" name="username" id="username" value="" />
 <input type="password" name="password" id="password" value="" class="w100" />
 <input type="submit" name="commit" value="" /></div>
</form>
HTML
    }
    context "success login" do
      before {
        stub_request(:post, @endpoint + "/login").
        with(:body => {"_csrf_token"=>"", "password"=>"test-password", "username"=>"test-username"}).
        to_return(:status =>200, :body => "OK", :headers => {content_type: 'text/html; charset=utf-8'})
      }
      it "start API session" do
        page = @agent.login("test-username","test-password")
        expect(page).to be_a Mechanize::Page
        expect(page.body).to eq "OK"
      end
    end
  end

  describe "#groups" do
    context "when there are three groups." do
      before {
        html = <<HTML
<table id="server-groups">
 <tr><td><span class="instance_id"><a href="/my/group/test-sg-1">test-sg-1</a></span></td></tr>
 <tr><td><span class="instance_id"><a href="/my/group/test-sg-2">test-sg-2</a></span></td></tr>
 <tr><td><span class="instance_id"><a href="/my/group/test-sg-3">test-sg-3</a></span></td></tr>
</table>
HTML
        stub_request(:get, @endpoint + "/my/group").
        to_return(:status =>200, :body => html, :headers => {content_type: 'text/html; charset=utf-8'})

        (1..3).each { |n|
          html = <<HTML
<span class="group-name">test-sg-#{n}</span>
<span class="api-key">#{n}dummyapikey1234567890</span>
HTML
          stub_request(:get, @endpoint + "/my/group/test-sg-#{n}/info").
          to_return(:status =>200, :body => html, :headers => {content_type: 'text/html; charset=utf-8'})
        }
      }
      it "returns list of groups" do
        expect(@agent.groups.count).to be 3
        expect(@agent.groups.first.name).to eq "test-sg-1"
      end
        
    end
  end
  
end




