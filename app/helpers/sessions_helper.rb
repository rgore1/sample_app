module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
  !@current_user.nil?
  end


  def current user=(user)
    @current_user = user
  end

end