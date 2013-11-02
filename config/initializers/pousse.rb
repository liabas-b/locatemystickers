Pousse::configure do |config|
  config.server = ENV["POUSSE_URL"]
  config.secret = ENV["POUSSE_SECRET"]
  if ENV['POUSSE_REDIS'].present?
    uri = URI.parse(ENV["POUSSE_REDIS"])
    config.redis = {
      host: uri.host,
      port: uri.port,
      password: uri.password,
      thread_safe: true
    }
  end
  # config.server = "http://pousse-lms.herokuapp.com/" # Warning: You must specify the port in development mode (eg: http://mypousssette.herokuapp.com:80)
  # config.secret = "f6d25e25316f21b0e23d7d22844330e7"
  # uri = URI.parse("redis://redistogo:f6d25e25316f21b0e23d7d22844330e7@tarpon.redistogo.com:10092/")
  # config.redis = { host: uri.host, port: uri.port, password: uri.password }
end
