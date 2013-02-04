require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST create" do
    it "creates the user when input is valid" do
      post :create, user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
      User.first.email_address.should == "test@test.com"
      User.first.full_name.should == "test tester"
      User.first.authenticate('test').should be_true
    end

    it "redirects user to root when user is saved" do
      post :create, user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
      response.should redirect_to root_path
    end

    it "renders new template when user is not created" do
      post :create, user: { email_address: "", full_name: "", password: "" }
      response.should render_template :new
    end
  end
end
