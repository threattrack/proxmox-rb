module ProxmoxRb
  class Auth
    Ticket = Struct.new(:host, :ticket, :csrf)
    def self.get_ticket(host, username, password)
      retry_count = 0
      auth = nil
      begin
        auth = JSON.parse(RestClient.post 'https://' + host + ':8006/api2/json/access/ticket',
                          { username: username, password: password })
      rescue => e
        retry_count += 1
        retry if retry_count < 5
      end
      ticket = auth['data']['ticket']
      csrf = auth['data']['CSRFPreventionToken']
      tick = Ticket.new(host, ticket, csrf)
    end
  end
end
