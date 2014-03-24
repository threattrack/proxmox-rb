require 'spec_helper'

describe ProxmoxRb::ClusterResources do
  context "getting a list of nodes" do
    it "should get nodes given a ticket" do
      resources = get_resources
      resources.count.should eq(304)
    end
  end
end
