class UserRegistration
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def process(invitation, token)
    if user.valid?
      customer = StripeGateway::Customer.create(email_address: 999, plan: "myflix", card: token)

      if customer.subscribed?
        user.save
        Payment.create(user_id: user.id, customer_token: customer.id, amount: customer.invoices.last.amount, reference_id: customer.invoices.last.id)
        UserMailer.delay.welcome_email(user.id)
        handle_invitation(invitation) if invitation
        UserRegistrationResult.new(true, false, nil)
      else
        UserRegistrationResult.new(false, false, charge.error_message)
      end
    else
      UserRegistrationResult.new(false, true, nil)
    end
  end

  private

  def handle_invitation(invitation)
    user.follow!(user.invitation.sender)
    user.invitation.sender.follow!(user)
  end
end

class UserRegistrationResult < Struct.new(:successful, :invalid_user, :stripe_error_message)
  def invalid_user?
    self[:invalid_user]
  end

  def successful?
    self[:successful]
  end
end