module NetApp
  module Api

    def connect
      if node[:netapp][:url]
        @url = URI.parse(node[:netapp][:url])
        raise ArgumentError, "Invalid scheme #{@url.scheme}. Must be https/http" unless @url.scheme == 'https' || @url.scheme == 'http'
        raise ArgumentError, "no user specified" unless @url.user
        raise ArgumentError, "no password specified" unless @url.password

        @server = NaServer.new(@url.host, 1, 13)
        @server.set_admin_user(@url.user, @url.password)
        @server.set_transport_type(@url.scheme.upcase)
        @server.set_port(@url.port)

        if match = %r{/([^/]+)}.match(@url.path)
          @vfiler = match.captures[0]
          @server.set_vfiler(@vfiler) if @vfiler
        end

      else
        @server = begin

          raise ArgumentError, "no user specified" unless node[:netapp][:user]
          raise ArgumentError, "no password specified" unless node[:netapp][:password]
          raise ArgumentError, "no host specified" unless node[:netapp][:fqdn]

          NaServer.new(node[:netapp][:fqdn], 1, 13)
          @server.set_admin_user(node[:netapp][user], node[:netapp][:password])

          if node[:netapp][https] == true
            @server.set_transport_type('HTTPS')
            @server.set_port(443)
          else
            @server.set_transport_type('HTTP')
            @server.set_port(8080)
          end

          @server.set_vfiler(node[:netapp][:virtual_filer]) if node[:netapp][:virtual_filer]
        end
      end
      @server
    end

    def invoke_api(request, svm = nil)
      @server = connect

      # The vserver name is set as vfiler in case of a tunneled connection.
      @server.set_vfiler(svm) if svm

      @server.invoke_elem(request)
    end

    def check_result(result, resource, action)
      if result.results_errno != 0
        raise "#{resource} #{action} failed.Error no- #{result.results_errno}. Reason- #{result.results_reason}."
      end
    end

  end
end