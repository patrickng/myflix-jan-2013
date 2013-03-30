def set_current_user(user)
  session[:user_id] = user.id
end

def current_user
  User.find(session[:user_id])
end

def sign_in(user)
  visit login_path
  fill_in "Email Address:", with: user.email_address
  fill_in "Password:", with: user.password
  click_on "Sign in"
end

def pay_with_credit_card(card_number)
  fill_in "Credit Card Number", with: card_number
  fill_in "Security Code", with: "123"
  select "3 - March", from: "date_month"
  select "2017", from: "date_year"
  click_button "Sign Up"
end