# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'erber/version'

Gem::Specification.new do |spec|
  spec.name          = "erber"
  spec.version       = Erber::VERSION
  spec.authors       = ["Ed Ropple"]
  spec.email         = ["ed@edropple.com"]
  spec.summary       = %q{A simple tool for wrangling ERBs and dumb data.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency 'hashie',     '~> 3.3.2'
  spec.add_runtime_dependency 'trollop',    '~> 2.0'
  spec.add_runtime_dependency 'deep_merge', '~> 1.0.1'
end
