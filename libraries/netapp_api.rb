module NetApp
  module Api

    def netapp_hash
      Hash.new{|h,k| h[k] = Hash.new(&h.default_proc)}
    end

    def connect
      if node['netapp']['url']
        @url = URI.parse(node['netapp']['url'])
        raise ArgumentError, "Invalid scheme #{@url.scheme}. Must be https/http" unless @url.scheme == 'https' || @url.scheme == 'http'
        raise ArgumentError, "no user specified" unless @url.user
        raise ArgumentError, "no password specified" unless @url.password

        @server = NaServer.new(@url.host, 1, 13)
        @server.set_admin_user(@url.user, @url.password)
        @server.set_transport_type(@url.scheme.upcase)
        @server.set_port(@url.port)
        @server.set_timeout(node['netapp']['api']['timeout']) if node['netapp']['api']['timeout']

        if match = %r{/([^/]+)}.match(@url.path)
          @vfiler = match.captures[0]
          @server.set_vfiler(@vfiler) if @vfiler
        end

      else
        raise ArgumentError, "no user specified" unless node['netapp']['user']
        raise ArgumentError, "no password specified" unless node['netapp']['password']
        raise ArgumentError, "no host specified" unless node['netapp']['fqdn']

        @server = NaServer.new(node['netapp']['fqdn'], 1, 13)
        @server.set_admin_user(node['netapp']['user'], node['netapp']['password'])
        @server.set_timeout(node['netapp']['api']['timeout']) if node['netapp']['api']['timeout']
        @server.set_vfiler(node['netapp']['vserver']) if node['netapp']['vserver']

        if node['netapp']['https'] == true
          @server.set_transport_type('HTTPS')
          @server.set_port(443)
        else
          @server.set_transport_type('HTTP')
          @server.set_port(8080)
        end
      end

      @server
    end

    def invoke(api_hash)
      request = generate_request(api_hash[:api_name], api_hash[:api_attribute])
      if api_hash[:svm].empty?
        response = invoke_api(request)
      else
        response = invoke_api(request, api_hash[:svm])
      end
      check_errors!(response, api_hash[:resource], api_hash[:action])
    end

    def invoke_api(request, svm = nil)
      @server = connect

      # The vserver name is set as vfiler in case of a tunneled connection.
      @server.set_vfiler(svm) if svm
      @server.invoke_elem(request)
    end

    def check_errors!(result, resource, action)
      if result.results_errno == 0  # The Api ran successfully and returned no error.
        return true
      elsif result.results_errno == "17" || result.results_errno == "14922" || result.results_errno == "13130" || result.results_errno ==  "13080" || result.results_errno == "13001" || result.results_errno ==  "15698" || result.results_errno == "15661" || result.results_errno ==  "13040"
        #If the resource already exists, then ignore the error and proceed with the next resource.
        #Do not update resource count.
        return false
      else
        raise "#{resource} #{action} failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
      end
    end

    def generate_request(name, value)
      if value.nil?
        netapp_element = NaElement.new(name)
        return netapp_element

      elsif value.is_a? Hash
        netapp_request = NaElement.new(name)
        value.each do |netapp_input_name, input_value|
          netapp_element = generate_request(netapp_input_name, input_value)

          if netapp_element.is_a? Array
            netapp_element.each do |element|
              netapp_request.child_add(element)
            end
          else
            netapp_request.child_add(netapp_element)
          end
        end
        return netapp_request

      elsif value.is_a? Array
        netapp_elements = []
        value.each do |element_val|
          netapp_element = NaElement.new(name, element_val)
          netapp_elements << netapp_element
        end
        return netapp_elements

      else
        netapp_element = NaElement.new(name,value)
        return netapp_element
      end
    end

  end
end
