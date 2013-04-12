class UserRegistration
  attr_accessor :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def process_registration
    UserMailer.delay.welcome_email(user.id)
    handle_invitation if invitation
  end

  private

  def handle_invitation
    user.follow!(user.invitation.sender)
    user.invitation.sender.follow!(user)
  end
end