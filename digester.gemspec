# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'digester/version'

Gem::Specification.new do |spec|
  spec.name          = "digester"
  spec.version       = Digester::VERSION
  spec.authors       = ["Simeon Simeonov"]
  spec.email         = ["sim@swoop_dot_com"]
  spec.summary       = %q{Digester builds consistent MD5 signatures for arbitrary Ruby data structures.}
  spec.homepage      = "https://github.com/swoop-inc/digester"
  spec.license       = "MIT"

  spec.rubyforge_project = "digester"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
end
