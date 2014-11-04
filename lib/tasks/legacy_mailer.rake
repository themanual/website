namespace :themanual do

  desc 'Send mails to legacy subscribers'
  task :legacy_email => :environment do

    users = User.where(access_level: 0, backer_id: nil)

    if ENV['PREVIEW'].present?
      # pick a ranodm user to use
      users = [users.to_a.sample]
    end

    users.each do |user|

      LegacyMailer.notification(user, ENV['PREVIEW'].present?).deliver

    end

  end

end
