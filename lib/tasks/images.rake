namespace :themanual do

  desc "Make square versions of illustrations"
  task :square_illos do

    Dir.glob("#{Rails.root.join('app','assets','images','illustrations','editorial')}/**/*-750w.jpg").each do |file|
      new_file = file.sub('-750w','-square')

      cmd = "convert #{file} \\( +clone -rotate 90 +clone -mosaic +level-colors white \\) +swap -gravity center -composite #{new_file}"

      `#{cmd}`

    end

  end
end
