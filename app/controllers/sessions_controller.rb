class SessionsController < Devise::SessionsController

  skip_before_filter :authenticate_user!

  def new
    render :new
  end

  def create
    if params[:token]
      token = SessionToken.where(token: params[:token]).first
      if token.present? and token.expires_at > Time.now
        sign_in token.email_address.user
        redirect_to account_path
      else
        render :invalid_token
      end
    elsif params[:email]
      # look up email

      email = EmailAddress.where(email: params[:email]).first

      if email.present?

        @token = email.session_tokens.create token: SecureRandom.hex(32), expires_at: SessionToken.login_token_expiry

        SessionsMailer.login_token(email.user, @token).deliver

        render :login_sent

      else
        render :not_found
      end

    else
      render :new
    end
  end

end
