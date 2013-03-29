class AuthenticatedController < ApplicationController
  before_filter :require_user

  def require_user
    redirect_to login_path, flash: { info: "Access reserved for members only. Please login or register first." } unless logged_in?
  end
end