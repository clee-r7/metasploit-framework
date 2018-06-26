require 'sinatra/base'
require 'metasploit/framework/service/http/helper/module/exploit_service'
require 'metasploit/framework/service/http/helper/servlet_helper'

require 'metasploit/framework/service/http/servlet/module/exploit_servlet'

class MsfApp < Sinatra::Base
  helpers ExploitService
  helpers ServletHelper

  register ExploitServlet

  def initialize(app, framework = nil)
    super(app)
    @framework = framework
  end
end