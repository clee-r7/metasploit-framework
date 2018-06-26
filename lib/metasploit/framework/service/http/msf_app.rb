require 'sinatra/base'
require 'metasploit/framework/service/http/helper/module_helper'
require 'metasploit/framework/service/http/servlet/msf_module_servlet'

class MsfApp < Sinatra::Base
  helpers ModuleHelper

  register MSFModuleServlet
end