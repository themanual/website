class LegacyMailer < TheManual::Mailer

  def notification user, preview = false
    @user = user

    if preview
      to = "" # who should be previewing
    else
      to = user.email
    end

    mail to: to, subject: 'Update from The Manual'
  end
end
