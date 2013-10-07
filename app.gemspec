# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ['Mikael Wikman']
  gem.email         = ['mikael@wikman.me']
  gem.summary       = %q{Monkey-patch MiniTest to run each test within EventMachine reactor}
  gem.description   = %Q{}
  gem.homepage      = "https://github.com/mikaelwikman/em-minitest"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|features)/})
  gem.name          = "em-minitest"
  gem.require_paths = ["lib"]
  gem.version       = '2.0.0'
  gem.add_dependency 'eventmachine'
end
