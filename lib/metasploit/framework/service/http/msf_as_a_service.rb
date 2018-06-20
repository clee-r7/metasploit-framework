require 'metasploit/framework/service/http/msf_app'

class MsfAsAService

  def initialize(opts)
    @opts = opts
    @server_handle = nil
  end

  def start
    start_http_server
  end

  def stop
    @server_handle.stop if !@server_handle.nil?
  end

  #######
  private
  #######

  def start_http_server

    Rack::Handler::Thin.run(MsfApp, @opts) do |server|

      # Prevent accidental shutdown from msfconsole eg: ctrl-c
      [:INT, :TERM].each { |sig|
        trap(sig) {
          server.stop if sig == :TERM)
        }
      }

      if @opts[:ssl] && @opts[:ssl] = true
        print_good "SSL Enabled"
        server.ssl = true
        server.ssl_options = opts[:ssl_opts]
      else
        print_warning 'SSL Disabled'
      end
      server.threaded = true
      @server_handle = server
    end
  end
end