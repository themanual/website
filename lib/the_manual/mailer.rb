class TheManual::Mailer < ActionMailer::Base

	default :from => "The Manual <hi@alwaysreadthemanual.com>"
  layout 'email'


  class Interceptor
    def self.delivering_email(mail)

      mail.subject = "[#{Rails.env.upcase}] #{mail.subject}" unless Rails.env.production?

      mail.headers({
		  	'X-MC-Track' => 'opens, clicks',
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