require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    before(:each) do
      @user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
    end

    context "successful login" do
      before(:each) do
        post :create, { email_address: "test@test.com", password: "test" }
      end

      it "sets the session user" do
        session[:user].should == @user
      end

      it "redirects to home path" do
        response.should redirect_to home_path
      end
    end

    context "unsuccessful login" do
      it "redirects to login path" do
        post :create, { email_address: "test@test.com", password: "testing" }
        response.should redirect_to login_path
      end
    end
  end

  describe "GET destroy" do
    before(:each) do
      @user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
      post :create, { email_address: "test@test.com", password: "test" }
      get :destroy
    end

    it "empties the session when user logs out" do
      session[:user].should == nil
    end

    it "redirects to root path when user logs out" do
      response.should redirect_to root_path
    end
  end
end
