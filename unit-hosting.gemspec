# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: unit-hosting 0.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "unit-hosting"
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yoshihiro TAKAHARA"]
  s.date = "2014-02-08"
  s.description = "This is a command to manage virtual servers on UnitHosting(http://www.unit-hosting.com)."
  s.email = "y.takahara@gmail.com"
  s.executables = ["unit-hosting"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".coveralls.yml",
    ".document",
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/unit-hosting",
    "lib/unit-hosting.rb",
    "lib/unit-hosting/agent.rb",
    "lib/unit-hosting/api.rb",
    "lib/unit-hosting/api/base.rb",
    "lib/unit-hosting/api/vm.rb",
    "lib/unit-hosting/api/vm_group.rb",
    "lib/unit-hosting/api/vm_recipe.rb",
    "lib/unit-hosting/cache.rb",
    "lib/unit-hosting/cli.rb",
    "lib/unit-hosting/commands.rb",
    "lib/unit-hosting/group.rb",
    "spec/spec_helper.rb",
    "spec/unit-hosting/agent_spec.rb",
    "spec/unit-hosting/api/base_spec.rb",
    "spec/unit-hosting/api/vm_group_spec.rb",
    "spec/unit-hosting/api/vm_recipe_spec.rb",
    "spec/unit-hosting/api/vm_spec.rb",
    "spec/unit-hosting/cache_spec.rb",
    "spec/unit-hosting/cli_spec.rb",
    "spec/unit-hosting/commands_spec.rb",
    "spec/unit-hosting/group_spec.rb",
    "unit-hosting.gemspec"
  ]
  s.homepage = "http://github.com/tumf/unit-hosting"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.1"
  s.summary = "unit-hosting command line tool"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mutter>, [">= 0"])
      s.add_runtime_dependency(%q<keystorage>, ["~> 0.4.13"])
      s.add_runtime_dependency(%q<highline>, ["> 1.6"])
      s.add_runtime_dependency(%q<progressbar>, [">= 0.9.0"])
      s.add_runtime_dependency(%q<httpclient>, [">= 2.1.6.1"])
      s.add_runtime_dependency(%q<command-line-utils>, [">= 0.0.1"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.5.9"])
      s.add_runtime_dependency(%q<mechanize>, ["= 2.6.0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<mutter>, [">= 0"])
      s.add_dependency(%q<keystorage>, ["~> 0.4.13"])
      s.add_dependency(%q<highline>, ["> 1.6"])
      s.add_dependency(%q<progressbar>, [">= 0.9.0"])
      s.add_dependency(%q<httpclient>, [">= 2.1.6.1"])
      s.add_dependency(%q<command-line-utils>, [">= 0.0.1"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5.9"])
      s.add_dependency(%q<mechanize>, ["= 2.6.0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<mutter>, [">= 0"])
    s.add_dependency(%q<keystorage>, ["~> 0.4.13"])
    s.add_dependency(%q<highline>, ["> 1.6"])
    s.add_dependency(%q<progressbar>, [">= 0.9.0"])
    s.add_dependency(%q<httpclient>, [">= 2.1.6.1"])
    s.add_dependency(%q<command-line-utils>, [">= 0.0.1"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5.9"])
    s.add_dependency(%q<mechanize>, ["= 2.6.0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end

