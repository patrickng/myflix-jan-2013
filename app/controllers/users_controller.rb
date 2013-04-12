class UsersController < AuthenticatedController
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

  def create
    @user = User.new(params[:user])
    token = params[:stripeToken]
    invitation = @user.invitation
    
    UserRegistration.new(@user, invitation, token).process_registration
  end

  def show
    @user = User.find(params[:id])
    @queue_items = @user.queue_items
    @reviews = @user.reviews
  end
end