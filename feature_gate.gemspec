$:.push File.expand_path('../lib', __FILE__)
require 'feature_gate/version'

Gem::Specification.new do |s|
  s.name        = 'feature_gate'
  s.version     = FeatureGate::VERSION.dup
  s.date        = '2016-05-01'
  s.summary     = 'A gem to toggle feature gates on and off'
  s.description = 'A gem to toggle feature gates on and off'
  s.authors     = ['Tiffany Huang']
  s.email       = 'little.huang@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/tiffling/feature_gate'
  s.license     = 'MIT'
  s.require_paths = ['lib']
  s.executables = ['feature_gate']

  s.add_dependency 'rails', '~> 4.0'
  s.add_development_dependency('sqlite3', '~> 1.3')
  s.add_development_dependency('rspec-rails', '~> 3.1')
  s.add_development_dependency('factory_girl_rails', '~> 4.5')
end
