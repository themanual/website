Rake::Task['assets:precompile'].enhance do

  print "\nSaving static error pages\n"

  app = ActionDispatch::Integration::Session.new(Rails.application)

  ['404','500'].each do |code|

    # actual hostname here doesn't matter
    if ENV['HTTP_AUTH']
      creds = ENV['HTTP_AUTH'].split(':')
      auth = ActionController::HttpAuthentication::Basic.encode_credentials(creds[0], creds[1])

      app.get "https://themanual.org/errors/#{code}", nil, 'HTTP_AUTHORIZATION' => auth
    else
      app.get "https://themanual.org/errors/#{code}"
    end

    File.open(Rails.root.join('public',"#{code}.html"), 'w') do |file|
      file.write app.response.body
    end
  end


end
