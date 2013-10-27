Pousse::configure do |config|
  config.server = "http://pousse-lms.herokuapp.com:10092/" # Warning: You must specify the port in development mode (eg: http://mypousssette.herokuapp.com:80)
  config.secret = "f6d25e25316f21b0e23d7d22844330e7"
  if ENV['REDISTOGO_URL'].present?
    uri = URI.parse(ENV['REDISTOGO_URL'])
    config.redis = { host: uri.host, port: uri.port, password: uri.password }
  end
end
