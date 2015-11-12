# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jpcalendar/version"

Gem::Specification.new do |s|
  s.name        = "jpcalendar"
  s.version     = Jpcalendar::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["yoshitsugu fujii"]
  s.email       = ["ishikurasakura@gmail.com"]
  s.homepage    = "https://github.com/YoshitsuguFujii/jpcalendar"
  s.summary     = %q{japanese calendar}
  s.description = %q{日本の祝祭日に対応したカレンダー}

  s.rubyforge_project = "jpcalendar"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "holiday_jp"
end
