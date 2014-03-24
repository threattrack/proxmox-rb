require 'rspec'
require 'vcr'
require 'webmock'
require 'pry'
require './lib/proxmox-rb'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
