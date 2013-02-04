require 'spec_helper'

describe StaticController do
  describe "GET index" do
    it "renders the index static page template" do
      get :index
      response.should render_template :index
    end
    it "redirects the user to home when logged in" do
      user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
      session[:user] = user

      get :index
      response.should redirect_to home_path
    end
  end
end
