class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @queue_items = @user.queue_items
    @reviews = @user.reviews
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      UserMailer.welcome_email(@user).deliver
      redirect_to root_path
    else
      render 'new'
    end
  end
end