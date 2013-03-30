require 'spec_helper'

feature "New user registration and payment", js: true do
  scenario "New user fills out form, credit card accepted" do
    sign_up("Test Example", "test@example.me", "testing")
    pay_with_credit_card("4242424242424242")
    page.should have_content "Thank you for your payment."
    page.should have_content "You have successfully signed up. Please sign in."
  end

  scenario "New user fills out form, credit card declined" do
    sign_up("Test Example", "test@example.me", "testing")
    pay_with_credit_card("4000000000000002")
    page.should have_content "Your card was declined"
  end

  scenario "New user fills out form, invalid card" do
    sign_up("Test Example", "test@example.me", "testing")
    pay_with_credit_card("4000000000000069")
    page.should have_content "Your card's expiration date is incorrect"
  end

  scenario "New user fills out form, invalid user data" do
    sign_up("", "", "")
    pay_with_credit_card("4242424242424242")
    page.should have_content "Please check your input below."
  end
end

def sign_up(name, email_address, password)
  visit register_path
  fill_in "Full Name", with: name
  fill_in "Email Address", with: email_address
  fill_in "Password", with: password
end