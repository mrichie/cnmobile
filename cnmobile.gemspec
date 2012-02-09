# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cnmobile"
  s.version     = "0.0.1"
  s.authors     = ["Richie Min"]
  s.email       = ["minruiqi@gmail.com"]
  s.homepage    = "https://github.com/mrichie/cnmobile"
  s.summary     = %q{Mobile for Rails}
  s.description = %q{Mobile for Rails}

  s.rubyforge_project = "cnmobile"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
