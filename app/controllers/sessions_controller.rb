class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email_address(params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user] = user
      redirect_to home_path, flash: { success: "Successfully logged in!" }
    else
      redirect_to login_path, flash: { error: "Invalid email or password. Please try again." }
    end
  end
  def destroy
    session[:user] = nil
    redirect_to root_path, flash: { success: "Successfully logged out." }
  end
end
