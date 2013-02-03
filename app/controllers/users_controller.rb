class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.password_confirmation = nil
    
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end
end