class SessionsController < ApplicationController
  def new
  end
  def create
    flash[:error] = "Incorrect email or password. Please try again."
    redirect_to login_path
  end
  def destroy
  end
end
