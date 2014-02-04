# -*- coding: utf-8 -*-
require 'spec_helper'
require 'unit-hosting/api/vm_recipe'

describe UnitHosting::Api::VmRecipe do
  before {
    @recipe = UnitHosting::Api::VmRecipe.new
  }
  describe "#load_ssh_key" do
    before {
      @ssh_key_file = Tempfile.new('ssh_key')
      @ssh_key_file.puts(<<"KEY")
dummy
ssh-key
file
KEY
      @ssh_key_file.close
    }
    after {
      @ssh_key_file.unlink
    }
    it "loads ssh key file " do
      @recipe.load_ssh_key(@ssh_key_file.path)
      expect(@recipe.ssh_key).to match /ssh-key/
    end
  end
end
