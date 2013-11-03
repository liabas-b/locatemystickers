Pousse::configure do |config|
  config.server = ENV['POUSSE_SERVER'] # Warning: You must specify the port in development mode (eg: http://mypousssette.herokuapp.com:80)
  config.secret = ENV['POUSSE_SECRET']
  puts "ENV['POUSSE_SERVER'] = " + ENV['POUSSE_SERVER']
  puts "ENV['POUSSE_SECRET'] = " + ENV['POUSSE_SECRET']
  if ENV['REDISTOGO_URL'].present?
    uri = URI.parse(ENV['REDISTOGO_URL'])
    config.redis = { host: uri.host, port: uri.port, password: uri.password }
  end
end
