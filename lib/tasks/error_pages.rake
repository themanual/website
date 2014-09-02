Rake::Task['assets:precompile'].enhance do

  print "\nSaving static error pages\n"

  app = ActionDispatch::Integration::Session.new(Rails.application)

  ['404'].each do |code|

    # actual hostname here doesn't matter
    app.get "https://themanual.org/errors/#{code}"

    File.open(Rails.root.join('public',"#{code}.html"), 'w') do |file|
      file.write app.response.body
    end
  end


end
