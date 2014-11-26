Airbrake.configure do |config|
  config.api_key = '47e58d01758f7e0528b5baf96751a9d1'
  config.host    = 'airbrake.neutroncreations.com'
  config.port    = 80
  config.secure  = config.port == 443
end
