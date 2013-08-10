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
    result = UserRegistration.new(@user).process(@user.invitation, token)

    if result.invalid_user?
      flash[:error] = "Invalid user information."
      render :new
    elsif result.successful?
      redirect_to login_path, flash: { notice: "You have successfully signed up. Please sign in." }
    elsif result.stripe_error?
      flash[:error] = result.stripe_error_message
      render :new
    else
      flash[:error] = "Invalid card information."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @queue_items = @user.queue_items
    @reviews = @user.reviews
  end
end