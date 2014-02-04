# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/commands'
describe UnitHosting::Commands do
  before {
    @endpoint = "https://example.net"
    @commands = UnitHosting::Commands.new(@endpoint)
    @commands.keyname = "rspec-unit-hosting-test"
    @cache_file = Tempfile.new('cache')
    @commands.stub(:cache_file).and_return(@cache_file.path)
  }
  after {
    @cache_file.close
    @cache_file.unlink
  }
  describe "#login" do
    before{
      @commands.agent.stub(:login).and_return(nil)
      @user1 = { :username =>"test-user-1", :password =>"correct-for-1", :bad_password =>"bad-for-1"}
      expect(Keystorage).to receive(:set).
      with(@commands.keyname,@user1[:username],@user1[:password]).once
    }
    context "put collect username and password." do
      before {
        @commands.agent.stub(:login?).and_return(true)
      }
      context "answer collect username and password" do
        before {
        }
        it "returns true." do
          expect(@commands).to receive(:ask).
            with("Enter user: ").and_return(@user1[:username]).once
          expect(@commands).to receive(:ask).
            with("Enter your password: ").and_return(@user1[:password]).once
          $stderr.should_receive(:puts).with("login OK").once
          @commands.login
        end
      end
      
    end
    context "put bad pair of username and password." do
      before{
        @commands.agent.stub(:login?).and_return(false,true)
      }
      it "asks username and password again." do
        $stderr.should_receive(:puts).with("login OK").once
        $stderr.should_receive(:puts).with("password mismatch").once
        expect(@commands).to receive(:ask).
          with("Enter user: ").and_return(@user1[:username]).twice
        expect(@commands).to receive(:ask).
          with("Enter your password: ").and_return(@user1[:password]).twice
        @commands.login
      end
    end
  end
  
  describe "#logout" do
    it "removes Keychain entry." do
      expect(Keystorage).to receive(:delete).with(@commands.keyname).once
      @commands.logout
    end
  end
  
  describe "#groups" do
    it "returns groups." do
      expect(@commands.cache).to receive(:groups).with().once
      expect($stdout).to receive(:puts).once
      @commands.groups
    end
  end
  
  describe "#group" do
    it "asks group andreturns group." do
      expect(@commands).to receive(:ask_group).once
      @commands.group
    end
  end
  describe "#update" do
    before {
      # @commands.should_receive(:start)
      @commands.stub(:start).and_return true
    }
    context "when --all is set" do
      before{
        @groups = [].extend(UnitHosting::Groups)
        (1..10).each { |n|
          group = UnitHosting::Group.new("test-sg-#{n}")
          group.key = "dummy-key-#{n}"
          # group.stub(:update).and_return([])
          @groups << group
        }
        @commands.agent.stub(:groups).and_return(@groups)

        # curl -X POST "https://cloud.unit-hosting.com/xmlrpc"
        xml = <<XML
<?xml version="1.0" encoding="UTF-8"?>
 <methodResponse>
  <params>
   <param><value><array><data>
    <value><struct>
     <member><name>instance_id</name><value><string>test-vm-1280</string></value></member>
     <member><name>display_name</name><value><string>test-server-1</string></value></member>
     <member><name>api_key</name><value><string>dummy-api-key-00398342190234</string></value></member>
     <member><name>status</name><value><string>halted</string></value></member>
    </struct></value>
    <value><struct>
     <member><name>instance_id</name><value><string>test-vm-1645</string></value></member>
     <member><name>display_name</name><value><string>test-server-2</string></value></member>
     <member><name>api_key</name><value><string/></value></member>
     <member><name>status</name><value><string>halted</string></value></member>
    </struct></value>
   </data></array></value></param>
  </params>
 </methodResponse>
XML
        stub_request(:post, "https://cloud.unit-hosting.com/xmlrpc").
        to_return(:status =>200, :body => xml, :headers => {:content_type =>'text/xml; charset=utf-8'})
      }
      it "updates all cache" do
        @commands.update(true)
      end
    end
    context "when --all is not set" do
      before {
        @group = UnitHosting::Group.new("test-sg-9")
        @group.key = "dummy-key-9"
        @commands.stub(:ask_group).and_return(@group)
      }
      it "updates cache of specified group" do
        @group.should_receive(:update)
        @commands.update
      end
    end
    
  end
end
