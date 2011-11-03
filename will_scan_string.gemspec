# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "will_scan_string/version"

Gem::Specification.new do |s|
  s.name        = "will_scan_string"
  s.version     = WillScanString::VERSION
  s.authors     = ["Toby Hinloopen"]
  s.email       = ["toby@kutcomputers.nl"]
  s.homepage    = ""
  s.summary     = %q{Gem for string replacements using multiple regular expressions in a single pass.}
  s.description = %q{Gem for string replacements using multiple regular expressions in a single pass.}

  s.rubyforge_project = "will_scan_string"

	s.add_development_dependency "activesupport", "~> 3.0.9"
	s.add_development_dependency "rspec", "~> 2.6"
	s.add_dependency "i18n", "~> 0.5.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
