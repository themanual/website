Shipwire.config do |config|
  config.username = ENV['SHIPWIRE_USERNAME']
  config.password = ENV['SHIPWIRE_PASSWORD']

  config.environment = :live
end
