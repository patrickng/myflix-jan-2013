class UserMailer < ActionMailer::Base
  default from: "mailer@myflix.tv"

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail to: @user.email_address, subject: "Welcome to MyFlix!"
  end

  def password_reset(user_id)
    @user = User.find(user_id)
    mail to: @user.email_address, subject: "Password Reset"
  end

  def payment_successful(user_id)
    @user = User.find(user_id)
    mail to: @user.email_address, subject: "Payment Successful!"
  end

  def payment_failed(user_id)
    @user = User.find(user_id)
    mail to: @user.email_address, subject: "Payment Unsuccessful"
  end
end