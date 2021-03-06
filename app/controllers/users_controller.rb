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

    Stripe.api_key = "sk_test_3VfKfliIRsZ6JebIedsMzXUG"

    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(:amount => 999, :currency => "usd", :card => token)
      flash[:success] = "Thank you for your payment."
      if @user.save
        UserMailer.delay.welcome_email(@user.id)
        if @user.invitation
          @user.follow!(@user.invitation.sender)
          @user.invitation.sender.follow!(@user)
        end
        redirect_to login_path, flash: { notice: "You have successfully signed up. Please sign in."}
      else
        render 'new'
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @queue_items = @user.queue_items
    @reviews = @user.reviews
  end
end