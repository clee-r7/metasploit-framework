require 'rack'
require 'thin/logging'
require 'metasploit/framework/service/http/msf_app'


class MsfAsAService

  attr_reader :framework

  DEFAULT_OPTS = {
      :interface => '0.0.0.0',
      :port => 8080
  }

  def initialize(framework, opts = {})
    @framework = framework
    @opts = parse_opts(opts)
    @server_handle = nil
  end

  def start
    Thread.new {start_http_server}
  end

  def stop
    @server_handle.stop if !@server_handle.nil?
  end

  def on_ui_stop
    @server_handle.stop if !@server_handle.nil?
  end

  #######
  private
  #######

  def parse_opts(opts)
    return DEFAULT_OPTS if opts.empty?
  end

  def start_http_server

    Thin::Logging.silent = true
    Rack::Handler::Thin.run(MsfApp.new(nil, @framework), @opts) do |server|

      # Prevent accidental shutdown from msfconsole eg: ctrl-c
      [:INT, :TERM].each { |sig|
        trap(sig) {
          server.stop if (sig == :TERM)
        }
      }

      if @opts[:ssl] && @opts[:ssl] = true
        #print_good "SSL Enabled"
        server.ssl = true
        server.ssl_options = opts[:ssl_opts]
      else
        #print_warning 'SSL Disabled'
      end
      server.threaded = true
      @server_handle = server
      register_stop_listener
    end

  end

  def register_stop_listener
    @framework.events.add_ui_subscriber(self)
  end
end