class UserMailer < ActionMailer::Base
  default from: "mailer@myflix.tv"

  def welcome_email(user)
    @user = user
    mail to: user.email_address, subject: "Welcome to MyFlix!"
  end
end