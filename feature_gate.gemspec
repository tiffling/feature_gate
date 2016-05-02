$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'feature_gate'
  s.version     = '0.0.2'
  s.date        = '2016-05-01'
  s.summary     = 'A gem to toggle feature gates on and off'
  s.description = 'A gem to toggle feature gates on and off'
  s.authors     = ['Tiffany Huang']
  s.email       = 'little.huang@gmail.'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/tiffling/feature_gate'
  s.license     = 'MIT'
end
