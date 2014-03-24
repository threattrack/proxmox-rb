require 'spec_helper'

describe ProxmoxRb::Auth do
  context "getting an auth ticket" do
    it "should return an auth object" do
      ticket = get_ticket

      ticket.csrf.should eq("53307060:heYGWCFOff2OgdzJb6xnf+MTKCg")
      ticket.ticket.should eq("PVE:testuser@pve:53307060::PNbY+ku1bx6SP1EMycRm7dRnLKGdzdjrpomJKMz0DidEvtIkV4eR7rqnQa89+DzvdkkhUanib8Jm8/7SuDNEz3obNKTDf2bxLHigACAiy3Ul7MTefLFHqGNUW0cwTreGm/wVXrAYQPHpZYehXw5q5ErPPczbElCYJ9oNVkic9xIdekAb8zE6cHecxi4k+YvDmpEm2ZHy7ZwHLsvliMvd1byvbP+P/GLdT2vDmYGG5fQZBp5mnDq5NSIBw5yrflvdkFrw4OpYccZe/1S+ozjALPlpjkf0ND+1NzK6tyMkv3ARlpvWDIeeZ/loERCPUdC2o8CVBg8nHY783564NPn76Q==")
    end
  end
end
