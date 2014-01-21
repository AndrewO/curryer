# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'curryer/version'

Gem::Specification.new do |spec|
  spec.name          = "curryer"
  spec.version       = Curryer::VERSION
  spec.authors       = ["Andrew O'Brien"]
  spec.email         = ["obrien.andrew@gmail.com"]
  spec.description   = %q{Currying + Delegation = Curryer}
  spec.summary       = %q{Allows you to easily wrap a target object with common arguments.}
  spec.homepage      = "https://github.com/AndrewO/curryer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
