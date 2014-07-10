module NetApp
  module Api

    def connect

      if node[:netapp][:url]
        @url = URI.parse(node[:netapp][:url])
        @server ||= NaServer.new(@url.host, 1, 13)
        @server.set_admin_user(@url.user, @url.password)
        @server.set_transport_type(@url.scheme.upcase)
        @server.set_port(@url.port)

        if match = %r{/([^/]+)}.match(@url.path)
          @vfiler = match.captures[0]
          @server.set_vfiler(@vfiler)
        end

        raise ArgumentError, "Invalid scheme #{@url.scheme}. Must be https" unless @url.scheme == 'https' || @url.scheme == 'http'
        raise ArgumentError, "no user specified" unless @url.user
        raise ArgumentError, "no password specified" unless @url.password
      else
        @server ||= NaServer.new(node[:netapp][:fqdn], 1, 13)
        @server.set_admin_user(node[:netapp][user], node[:netapp][:password])

        if node[:netapp][https] == true
          @server.set_transport_type('HTTPS')
          @server.set_port(443)
        else
          @server.set_transport_type('HTTP')
          @server.set_port(8080)
        end

        @server.set_vfiler(node[:netapp][:virtual_filer])

        raise ArgumentError, "no user specified" unless node[:netapp][:user]
        raise ArgumentError, "no password specified" unless node[:netapp][:password]
        raise ArgumentError, "no host specified" unless node[:netapp][:fqdn]
        raise ArgumentError, "no virtual file specified" unless node[:netapp][:virtual_filer]
      end
      @server
    end

    def invoke(netapp_api, *args)
      @server = connect
      if args.empty?
        @server.invoke(netapp_api)
      else
        @server.invoke(netapp_api, *args)
      end
    end

    def invoke_elem(request)
      @server = connect
      @server.invoke_elem(request)
    end
  end
end