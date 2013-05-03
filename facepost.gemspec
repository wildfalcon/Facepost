# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "facepost/version"

Gem::Specification.new do |s|
  s.name        = "facepost"
  s.version     = Facepost::VERSION
  s.authors     = ["Laurie Young"]
  s.email       = ["laurie@wildfalcon.com"]
  s.homepage    = ""
  s.summary     = %q{Facebook Posting}
  s.description = %q{Posting Albums and Photos on Facebook}

  s.rubyforge_project = "facepost"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
