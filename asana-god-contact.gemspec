# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asana-god-contact/version'

Gem::Specification.new do |spec|
  spec.name          = "asana-god-contact"
  spec.version       = AsanaGodContact::VERSION
  spec.authors       = ["Roman Rott"]
  spec.email         = ["roman.rott@gmail.com"]

  spec.summary       = "A God::Contacts class that allows to send notifications to Asana"
  spec.description   = "A God::Contacts class for sending notifications to Asana. God is an easy to configure, easy to extend monitoring framework written in Ruby."
  spec.homepage      = "https://github.com/rrott/asana-god-contact"
  spec.license       = "GPL"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "god", "~> 0.13"
  spec.add_dependency "sys-proctable", "~>0.9"
  spec.add_dependency "json", "~>1.8"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mocha", '~> 1'
  spec.add_development_dependency "minitest", '~> 5.7'

end