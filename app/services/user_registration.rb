class UserRegistration
  include AbstractController::Rendering
  attr_reader :invitation, :token
  attr_accessor :user

  def initialize(user, invitation, token)
    @user = user
    @invitation = invitation
  end

  def process_registration
    if user.valid?
      charge = StripeGateway::Charge.create(amount: 999, card: token)
      if charge.successful?
        flash[:success] = "Thank you for your payment."
        if user.save
          # UserRegistration.new(@user, @user.invitation).process_registration
          UserMailer.delay.welcome_email(user.id)
    handle_invitation if invitation
          redirect_to login_path, flash: { notice: "You have successfully signed up. Please sign in." }
        else
          render 'new'
        end
      else
        flash[:error] = charge.error_message
        render 'new'
      end
    else
      render 'new'
    end
  end

  private

  def handle_invitation
    user.follow!(user.invitation.sender)
    user.invitation.sender.follow!(user)
  end
end