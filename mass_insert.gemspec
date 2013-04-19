# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mass_insert/version'

Gem::Specification.new do |spec|
  spec.name          = "mass_insert"
  spec.version       = MassInsert::VERSION
  spec.authors       = ["Alejandro Gutiérrez"]
  spec.email         = ["alejandrodevs@gmail.com"]
  spec.description   = "Mass database insertion in Rails"
  spec.summary       = "This gem aims to provide an easy and faster way to do single database insertions in Rails."
  spec.homepage      = "https://github.com/alejandrogutierrez/mass_insert"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
