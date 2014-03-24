require 'spec_helper'

describe ProxmoxRb::Auth do
  context "getting an auth ticket" do
    it "should return an auth object" do
      VCR.use_cassette('ticket_test') do
        ticket = ProxmoxRb::Auth.get_ticket('10.129.4.237',
                                          'testuser@pve', 'test123')
        ticket.csrf.should eq("533063D4:bct3sgilbbAJdXjvxWxcbxBmx2Q")
        ticket.ticket.should eq("PVE:testuser@pve:533063D4::Xs8KFLBzQz2T7eV9ioHTEB45PSSF+Yw3qQ/Rvs3X/slKcMxYoCFCqzUAJ1SZcLwLjvxSxrMxpPjk6PvnhHMaLTZkWGccrPFsWK1HIwxAb9AvZ3Odd55p/0xidft+41rYlOXDMHyVY+khwmcuirPocGgk790xWx578bI4j1boWv0rYG+q/RNQfY1rAib+bJZyxRNrmxaCvh+KHvGBUzz0oGoZ+R6elbkmNcc3EGsbKiOTBP+Meb+JL5aOE5EKIDUjMTsz54E/w+OIs+PjZZTlauARh3t5sDE1b6yKmdqyd5tNEu2LKh4VppGpngFEb1lszoo4YCW7Wiem/blM0JvQVw==")
      end
    end
  end
end
