module ProxmoxRb
  class ClusterResources
    def self.get(ticket)
      http = Net::HTTP.new(ticket.host, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      headers = { 'Cookie' => "PVEAuthCookie=#{ticket.ticket}" }
      cluster_resources = http.get('/api2/json/cluster/resources', headers).body
      nodes = JSON.parse( cluster_resources )['data'][1..-1]
    end
  end
end
