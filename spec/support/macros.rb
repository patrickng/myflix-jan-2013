def set_current_user(user)
  user = Fabricate(:user)
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