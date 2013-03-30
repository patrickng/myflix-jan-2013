require 'spec_helper'

feature "User Invitation", js: true do
  given(:user) { Fabricate(:user) }

  scenario "send invite to user without account, user clicks on registration link, user registers, users follow each other" do

    sign_in(user)

    visit invite_path
    fill_in "Friend's Name", with: "Jane Example"
    fill_in "Friend's Email Address", with: "jane@example.me"
    fill_in "Invitation Message", with: "Check out this site!"
    click_button "Send Invitation"

    # uncomment line below if on a slow computer
    # sleep 4

    last_email.to.should == ["jane@example.me"]
    last_email.body.encoded.should include("Jane Example")
    last_email.body.encoded.should include(register_with_invite_path(Invitation.first.token))

    visit register_with_invite_path(Invitation.first.token)
    page.should have_content "Register"
    find_field('Full Name').value.should == "Jane Example"
    find_field('Email Address').value.should == "jane@example.me"
    fill_in "Password", with: "test"
    pay_with_credit_card("4242424242424242")

    # uncomment line below if on a slow computer
    # sleep 4

    last_email.to.should == ["jane@example.me"]
    last_email.body.encoded.should include("Welcome to MyFlix!")

    visit login_path
    fill_in "Email Address:", with: "jane@example.me"
    fill_in "Password:", with: "test"
    click_on "Sign in"

    visit people_path
    page.should have_content user.full_name

    sign_in(user)
    visit people_path
    page.should have_content "Jane Example"

  end
end