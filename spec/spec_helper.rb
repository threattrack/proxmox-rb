require 'rspec'
require 'vcr'
require 'webmock'
require 'pry'
require './lib/proxmox-rb'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

def get_ticket
  VCR.use_cassette('ticket_test') do
    ticket = ProxmoxRb::Auth.get_ticket('10.129.4.237',
                                        'testuser@pve', 'test123')
    ticket
  end
end

def get_resources
  VCR.use_cassette('cluster_resources') do
    resources = ProxmoxRb::ClusterResources.get(get_ticket)
  end
end
