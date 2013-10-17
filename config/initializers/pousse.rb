Pousse::configure do |config|
  config.server = "http://pousse-lms.herokuapp.com/" # Warning: You must specify the port in development mode (eg: http://mypousssette.herokuapp.com:80)
  config.secret = "yoursecret"
  if ENV['REDISTOGO_URL'].present?
    uri = URI.parse(ENV['REDISTOGO_URL'])
    config.redis = { host: uri.host, port: uri.port, password: uri.password }
  end
end
