class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    @current_user = session[:user]
  end

  def require_user
    unless current_user
      redirect_to login_path, flash: { info: "Access reserved for members only. Please login or register first." }
    end
  end
end
