class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  def current_user
    # session[:user_id] = nil
    User.find(session[:user_id]) if session[:user_id] != nil
  end

  def logged_in?
    !!current_user
  end
end
