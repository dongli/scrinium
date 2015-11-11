module RespondHelper

  def generate_success_response(response_body, code = 200)
    message = build_response_message_body({}, response_body)
  end

  def generate_error_response(error, code = 500)
    error_data = {
        'error-code'  => error.class.name,
        'message'     => error.message
    }

    Rails.logger.info(error.backtrace.join("\n"))

    message = build_response_message_body(error_data, {})

    build_response(message, code, {'Content-Type' => 'application/json'})

  end


  private

  def request
    @request ||= Grape::Request.new(self.env)
  end

  def build_response(message, status, headers = {})
    Rack::Response.new([message], status, headers).finish
  end


  def request_info

    headers = request.env.select {|k,v| k.start_with? 'HTTP_'}
                  .collect {|pair| [pair[0].sub(/^HTTP_/, ''), pair[1]]}
                  .collect {|pair| pair.join(": ") << "<br>"}
                  .sort

    {
        'href'         => request.url,
        'headers'      =>  headers,
        'query-params' => request.query_string,
        'body'         => request.body.read
    }
  end


  def build_response_message_body(error_data, response_body)
    {
        'meta' => {
            'code' => code,
            'error' => error_data,
            "x-server-current-time" => Time.now
        },
        'request' => request_info,
        'resposne' => response_body
    }
  end

end