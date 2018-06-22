require 'sinatra/base'
require 'helper/module_helper'
require 'servlet/msf_module_servlet'

class MsfApp < Sinatra::Base
  helpers ModuleHelper

  register MSFModuleServlet
end