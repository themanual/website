unless Rails.env.development?

  PumaWorkerKiller.config do |config|
    config.ram           = 512 # mb
    config.frequency     = 30    # seconds
    config.percent_usage = 0.90
  end

  PumaWorkerKiller.start

end
