module SessionsHelper
  def login_and_return_path
    login_path(next: request.env['PATH_INFO'])
  end
end