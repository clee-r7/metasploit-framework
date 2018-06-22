module MSFModuleServlet

  def self.api_path
    '/api/v1/module'
  end

  def self.registered(app)
    app.post MSFModuleServlet.api_path, &do_action
  end

  #######
  private
  #######

  def self.do_action
    lambda {
      begin
        module_action = parse_json_request(request, false)
        sanitized_params = sanitize_params(params)
        data = ModuleHelper.do_module_action(module_action)
        set_json_response(data)
      rescue => e
        set_error_on_response(e)
      end
    }
  end
end