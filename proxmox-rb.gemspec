Gem::Specification.new do |s|
  s.name        = 'proxmox-rb'
  s.version     = '0.0.4'
  s.date        = '2014-03-24'
  s.summary     = "A library to interact with proxmox 3.x"
  s.description = "A library to interact with proxmox 3.x"
  s.authors     = ["Josh Rendek"]
  s.email       = 'joshua.rendek@threattrack.com'
  s.files        = `git ls-files`.split("\n")
  s.homepage    = 'http://github.com/threattrack/proxmox-rb'
  s.license       = 'MIT'


  s.add_development_dependency('pry')
  s.add_development_dependency('rspec')
  s.add_development_dependency('vcr')
  s.add_development_dependency('webmock')
  s.add_dependency('json')
  s.add_dependency('rest-client')

end
