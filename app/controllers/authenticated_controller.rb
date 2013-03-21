class AuthenticatedController < ApplicationController
  before_filter :require_user
  helper_method :current_user, :logged_in?

  def require_user
    redirect_to login_path, flash: { info: "Access reserved for members only. Please login or register first." } unless logged_in?
  end

  def current_user
    # session[:user_id] = nil
    User.find(session[:user_id]) if session[:user_id] != nil
  end

  def logged_in?
    !!current_user
  end
end