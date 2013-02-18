require 'spec_helper'

feature "User log in" do

  background do
    User.create(full_name: "Patrick Example", email_address: "patrick@example.me", password: "test88")
  end

  scenario "with existing username and password" do
    visit login_path
    fill_in "Email Address:", with: "patrick@example.me"
    fill_in "Password", with: "test88"
    click_button "Sign in"
    page.should have_content "Successfully logged in!"
  end
end