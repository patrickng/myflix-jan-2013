class InvitationMailer < ActionMailer::Base
  default from: "mailer@myflix.tv"

  def registration_email(invitation, register_url)
    @invitation = invitation
    mail to: invitation.recipient_email_address, subject: "Invitation"
  end
end