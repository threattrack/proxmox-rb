require 'spec_helper'

describe ProxmoxRb::QemuKvm do
  context "getting a node" do
    it "should get the mac for a ndoe" do
      ticket = get_ticket
      resources = get_resources
      test_vm_info = resources.select {|x| x['id'] == 'qemu/113' }.first
      VCR.use_cassette('vm_config') do
        vm = ProxmoxRb::QemuKvm.new(ticket, test_vm_info['node'], test_vm_info['id'])
        mac = vm.mac
        mac.should eq("CA:EB:CB:18:AF:75")
      end
    end
  end
end
