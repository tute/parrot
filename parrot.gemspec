$:.push File.expand_path("../lib", __FILE__)

require "parrot/version"

Gem::Specification.new do |s|
  s.name        = "parrot"
  s.version     = Parrot::VERSION
  s.authors     = ["Tute Costa"]
  s.email       = "tutecosta@gmail.com"
  s.homepage    = "http://github.com/tute/parrot"
  s.summary     = %q{Simple commenting Rails Engine. Adds commentable behavior to any model easily.}
  s.description = %q{Add simple comments to any Rails resource.}

  s.files         = `git ls-files`.split("\n").reject{|f| f =~ /^\./ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency 'rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'devise'
end
