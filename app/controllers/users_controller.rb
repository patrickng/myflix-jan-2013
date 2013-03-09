class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    if params[:invitation_token]
      if User.find_by_invitation_id(Invitation.find_by_token(params[:invitation_token]).id)
        redirect_to root_path, flash: { error: "Invitation already used." }
      else
        @user = User.new(:invitation_token => params[:invitation_token])
        @invitation = @user.invitation
      end
    else
      @user = User.new
    end
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
      if @user.invitation
        @user.follow!(@user.invitation.sender)
        @user.invitation.sender.follow!(@user)
      end
      redirect_to root_path
    else
      render 'new'
    end
  end
end