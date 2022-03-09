class App

  def call(env)
     if env['REQUEST_PATH'] == "/time" && env['REQUEST_METHOD'] == "GET"
       acceptable_url(env)
    else
      response(404, "invalid_path")
    end
  end

  private

  def acceptable_url(env)
    request = Rack::Request.new(env)
    date_object = TimeFormatter.new
    date_object.call(request.params['format'].split(","))
    if date_object.success?
      response(200, date_object.response_time)
    else
      response(404, 'Unknown time format' + ' ' + date_object.invalid_string.join(', '))
    end
  end

  def response(status, body_date_object)
    Rack::Response.new(body_date_object, status, { 'Content-Type' => 'text/plain' }).finish
  end
end