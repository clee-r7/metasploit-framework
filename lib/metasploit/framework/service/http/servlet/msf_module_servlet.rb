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
        opts = parse_json_request(request, false)
        sanitized_params = sanitize_params(params)
        data = get_db.hosts(sanitized_params)
        includes = [:loots]
        set_json_response(data, includes)
      rescue => e
        set_error_on_response(e)
      end
    }
  end
end