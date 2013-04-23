class InvitationMailer < ActionMailer::Base
  default from: "mailer@myflix.tv"

  def registration_email(invitation_id, register_url)
    @invitation = Invitation.find(invitation_id)
    mail to: @invitation.recipient_email_address, subject: "You've been invited to join MyFlix!"
  end
end