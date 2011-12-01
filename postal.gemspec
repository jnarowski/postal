# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "postal/version"

Gem::Specification.new do |s|
  s.name        = "postal"
  s.version     = Postal::VERSION
  s.authors     = ["John Paul Narowski"]
  s.email       = ["jp@karmacrm.com"]
  s.homepage    = ""
  s.summary     = %q{Universal IMAP client}
  s.description = %q{Universal IMAP client gem}

  s.rubyforge_project = "postal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_dependency "gmail"
end
