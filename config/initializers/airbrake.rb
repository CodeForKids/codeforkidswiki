Airbrake.configure do |config|
  config.api_key = ENV["AIRBRAKE_TOKEN"]
  config.host    = 'exceptions.codeforkids.ca'
  config.port    = 80
  config.secure  = config.port == 443
end
