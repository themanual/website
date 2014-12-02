# force timeout before heroku drops the connection
Rack::Timeout.timeout = 25  # seconds
