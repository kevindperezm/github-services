class Service::CodeClimate < Service::HttpPost
  string :token

  default_events :push, :pull_request

  url "http://codeclimate.com"

  maintained_by :github => "mrb"

  supported_by :web => "https://codeclimate.com/contact",
    :email => "hello@codeclimate.com",
    :twitter => "@codeclimate"

  def receive_push
    token = required_config_value('token')
    http.basic_auth "github", token
    deliver "https://codeclimate.com/github_events", insecure_ssl: true
  end

  def receive_pull_request
    token = required_config_value('token')
    http.basic_auth "github", token
    deliver "http://codeclimate.com/github_events", insecure_ssl: true
  end

  def token
    data["token"].to_s.strip
  end

end
