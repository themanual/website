class TheManual::Mailer < ActionMailer::Base

	default :from => "The Manual <hi@alwaysreadthemanual.com>"
  layout 'email'

  class Interceptor
    def self.delivering_email(mail)

      mail.subject = "[#{Rails.env}] #{mail.subject}" if Rails.env.development?

      mail.headers({
        #  disable click tracking for now
		  	'X-MC-Track' => 'opens',
		  	'X-MC-Autotext' => 'true',
		  	'X-MC-GoogleAnalytics' => 'www.alwaysreadthemanual.com,alwaysreadthemanual.com',
		  	'X-MC-GoogleAnalyticsCampaign' => 'system_email',
		  	'X-MC-Metadata' => {
			  		'environment' => Rails.env
				}.to_json,
				'X-MC-URLStripQS' => 'true'
		  })
    end
  end

end

ActionMailer::Base.register_interceptor(TheManual::Mailer::Interceptor)
