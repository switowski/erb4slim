# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'erb4slim/version'

Gem::Specification.new do |spec|
  spec.name          = 'erb4slim'
  spec.version       = Erb4slim::VERSION
  spec.authors       = ['Sebastian Witowski']
  spec.email         = ['sebastian.witowski@cern.ch']
  spec.summary      = 'ERB to Slim Converter'
  spec.description  = 'Converts single or multiple template files from ERB to Slim'
  spec.homepage      = 'https://github.com/switowski/erb4slim'
  spec.license       = 'beerware license'

  spec.files        = ['bin/erb4slim', 'lib/erb4slim.rb']
  spec.executables  = ['erb4slim']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'

  spec.add_dependency 'html2haml', '~> 2.0'
  spec.add_dependency 'haml2slim'
end
