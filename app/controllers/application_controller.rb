class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id] != nil
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      redirect_to login_path, flash: { info: "Access reserved for members only. Please login or register first." }
    end
  end
end
