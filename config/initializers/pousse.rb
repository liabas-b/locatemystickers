Pousse::configure do |config|
  config.server = "http://pousse-lms.herokuapp.com:10092/" # Warning: You must specify the port in development mode (eg: http://mypousssette.herokuapp.com:80)
  config.secret = "f6d25e25316f21b0e23d7d22844330e7"
  uri = URI.parse("redis://redistogo:f6d25e25316f21b0e23d7d22844330e7@tarpon.redistogo.com:10092/")
  config.redis = { host: uri.host, port: uri.port, password: uri.password }
end
