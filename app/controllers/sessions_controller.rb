class SessionsController < Devise::SessionsController

  skip_before_filter :store_path

  # starts with / but not //
  SAFE_REDIRECT_REGEX = /\A\/[^\/].*\z/

  def new

    if params[:admin_token] && user = User.validate_admin_login_token(params[:admin_token])
      sign_in user
      redirect_to account_path
      return
    end


    if params[:next] && params[:next] =~ SAFE_REDIRECT_REGEX
      session[:return_to] = params[:next]
    end

    render :new
  end

  def create
    if params[:token]
      token = SessionToken.where(token: params[:token]).first
      if token.present? and token.expires_at > Time.now
        sign_in token.email_address.user
        redirect_to ( session.delete(:return_to) || account_path )
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
