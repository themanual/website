# Based on production defaults
require Rails.root.join("config/environments/production")

TheManual::Application.configure do

  config.action_mailer.default_url_options = {
    :host => 'beta.alwaysreadthemanual.com'
  }

end
