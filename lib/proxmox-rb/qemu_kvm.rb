module ProxmoxRb
  class QemuKvm
    def initialize(ticket, node, id)
      @node = node
      @csrf = ticket.csrf
      @id = id
      @ip = ticket.host
      @ticket = ticket.ticket
      @headers = { 'Cookie' => "PVEAuthCookie=#{@ticket}", "CSRFPreventionToken" => @csrf }
    end

    def config
      http = Net::HTTP.new(@ip, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @qemu ||= http.get('/api2/json/nodes/' + @node + '/' + @id + '/config', @headers).body
      JSON.parse( @qemu )['data']
    end

    def node
      @node
    end

    def name
      config['name'] rescue nil
    end

    def mac
      begin
        config['net0'].split('=')[1].split(',')[0]
      rescue
        ''
      end
    end

    def delete
      puts "[unlinking] #{@id}"
      http = Net::HTTP.new(@ip, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Delete.new('/api2/json/nodes/' + @node + '/' + @id, @headers)
      resp = http.request(req)
      puts resp.body
    end

    def shutdown
      puts "[stopping] #{@id}"
      http = Net::HTTP.new(@ip, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      resp = http.post('/api2/json/nodes/' + @node + '/' + @id + '/status/shutdown', nil, @headers)
    end

    def stop
      puts "[stopping] #{@id}"
      http = Net::HTTP.new(@ip, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      resp = http.post('/api2/json/nodes/' + @node + '/' + @id + '/status/stop', nil, @headers)
    end


    def snapshot(name)
      puts "[snapshotting] #{@id}"
      params = { snapname: name, vmstate: 1 }
      http = Net::HTTP.new(@ip, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new('/api2/json/nodes/' + @node + '/' + @id + '/snapshot')
      request.add_field("Cookie", "PVEAuthCookie=#{@ticket}")
      request.add_field("CSRFPreventionToken", @csrf)
      request.set_form_data(params)
      resp = http.request(request)
      puts resp
    end

    def delete_snapshot(name)
      puts "[deleting snapshot #{name}] #{@id}"
      begin
        params = { snapname: name }
        http = Net::HTTP.new(@ip, '8006')
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Delete.new('/api2/json/nodes/' + @node + '/' + @id + '/snapshot/' + name, @headers)
        resp = http.request(request)
        puts resp
      rescue => e
        puts "retrying #{e}"
        sleep 1
        retry
      end
    end


    def start
      puts "[starting] #{@id}"
      http = Net::HTTP.new(@ip, '8006')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      resp = http.post('/api2/json/nodes/' + @node + '/' + @id + '/status/start', nil, @headers)
    end
  end
end
