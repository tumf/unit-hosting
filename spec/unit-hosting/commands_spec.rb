# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/commands'
describe UnitHosting::Commands do
  before {
    @endpoint = "https://example.net"
    @commands = UnitHosting::Commands.new(@endpoint)
    @commands.keyname = "rspec-unit-hosting-test"
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
    before{
      @cache_file = Tempfile.new('cache')
      @cache_file.close
      @commands.stub(:cache_file).and_return(@cache_file.path)
      @commands.stub(:start).and_return true
    }
    after {
      @cache_file.unlink
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

  describe "#start" do
    context "when still logged in" do
      before{
        @commands.agent.stub(:login?).and_return(true)
      }
      it "returns true" do
        expect(@commands.send(:start)).to be_true
      end
    end
    context "failed login" do
      before{
        @commands.agent.stub(:login?).and_return(false)
        @commands.agent.stub(:login).and_return()
        expect(@commands).to receive(:login)
      }
      it "raises LoginError exception." do
        expect{
          @commands.send(:start)
        }.to raise_error(UnitHosting::Commands::LoginError)
      end
    end
    context "when not logged in" do
      before{
        @commands.agent.stub(:login?).and_return(false,true)
      }
      context "when there is a user-entry in keystorage" do
        before {
          Keystorage.stub(:list).and_return(["test-user-1"])
          Keystorage.stub(:get).with(@commands.keyname,"test-user-1").and_return("test-password-1")
        }
        it "try to login by using username" do
          expect(@commands.agent).to receive(:login).with("test-user-1","test-password-1").once
          @commands.send(:start)
        end
      end
      context "when there is no user-entry in keystorage" do
        before {
          Keystorage.stub(:list).and_return([])
        }
        it "asks username" do
          expect(@commands).to receive(:login)
          @commands.send(:start)
        end
      end
      #it "returns true" do
      #   expect(@commands.send(:start)).to be_true
      #end
    end
  end
  describe "#ask_group" do
    before{
      @groups = ['test-sg-1','test-sg-2','test-sg-3','test-123'].extend(UnitHosting::Groups)
      @groups = ['test-sg-1','test-sg-2','test-sg-3','test-123'].extend(UnitHosting::Groups)
      class HighLine
        def ask( question, answer_type = String, &details ) # :yields: question
          @question ||= Question.new(question, answer_type, &details)
          "test-sg-2"
       end
     end
    }
    context "when group_id is not given" do
      it "asks group_id" do
        expect($stdout).to receive(:puts)
        groups = [UnitHosting::Group.new('test-sg-1'),
                  UnitHosting::Group.new('test-sg-2'),
                  UnitHosting::Group.new('test-sg-3')].extend(UnitHosting::Groups)
        expect(@commands.send(:ask_group,nil,groups).instance_id).to eq "test-sg-2"
      end
    end
  end
  describe "#cache_file" do
    it "returns cache file path" do
      expect(@commands.send(:cache_file,"foo.cache")).to match /foo\.cache$/
    end
  end
  
end
