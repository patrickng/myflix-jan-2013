require 'spec_helper'

feature "Password Reset" do
  given(:user) { Fabricate(:user) }

  scenario "send password reset email to user, user clicks on reset password link, user enters password, resets password" do
    
    send_reset_email(user)

    last_email.to.should == [user.email_address]
    last_email.body.encoded.should include(edit_password_reset_path(user.password_reset_token))

    visit edit_password_reset_path(user.password_reset_token)
    fill_in "New Password", with: "test"
    click_button "Reset Password"

    page.should have_content "Password has been reset!"

    fill_in "Email", with: user.email_address
    fill_in "Password", with: "test"
    click_button "Sign in"

    page.should have_content "Successfully logged in!"

  end

  scenario "send password reset email to user, user clicks on reset password link after 15 minutes, error message appears" do

    send_reset_email(user)
    user.update_attribute("password_reset_sent_at", 20.minutes.ago)

    visit edit_password_reset_path(user.password_reset_token)

    page.should have_content "Password reset token is invalid or has expired. Request a new password reset email."

  end
end

def send_reset_email(user)
  visit login_path
  click_link "Forgot your password?"
  fill_in "Email address", with: user.email_address
  click_button "Send Email"
  user.reload
end