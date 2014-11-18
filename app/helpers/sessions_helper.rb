module SessionsHelper
  def login_and_return_path
    new_user_session_path(next: request.env['PATH_INFO'])
  end
end
