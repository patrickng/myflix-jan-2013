require 'spec_helper'

describe PasswordResetController do

  describe "GET index" do
    it "renders the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }

    context "when a user is not found" do
      before(:each) do
        post :create, email_address: "user@doesnotexist.com"
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "should not send the email" do
        ActionMailer::Base.deliveries.should be_empty
      end

      it "should redirect to root_path" do
        response.should redirect_to root_path
      end

      it "should show error message" do
        flash[:error].should have_content "No such email."
      end
    end

    context "when a user is found" do
      before(:each) do
        post :create, email_address: user.email_address
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "should send the email" do
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it "should redirect to root_path" do
        response.should redirect_to root_path
      end

      it "should show notice message" do
        flash[:notice].should have_content "Email sent with instructions to reset your password."
      end
    end
  end

  describe "GET edit" do
    let(:user) { Fabricate(:user) }

    before(:each) do
      post :create, email_address: user.email_address
      user.reload
      get :edit, token: user.password_reset_token
    end

    it "should set the @user variable" do
      assigns(:user).should == user
    end

    it "should render template" do
      response.should render_template :edit
    end

    context "when token is expired" do
      before(:each) do
        user.generate_and_store_password_token
        user.update_attribute("password_reset_sent_at", 20.minutes.ago)
        user.reload
        get :edit, token: user.password_reset_token
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "should redirect to password_reset_path" do
        response.should redirect_to password_reset_path
      end

      it "should show error message" do
        flash[:error].should have_content "Password reset token is invalid or has expired. Request a new password reset email."
      end
    end
  end

  describe "PUT update" do
    let(:user) { Fabricate(:user) }

    context "when token is valid" do
      before(:each) do
        user.generate_and_store_password_token
        put :update, token: user.password_reset_token, password: "test"
        user.reload
      end

      it "should redirect to login_path" do
        response.should redirect_to login_path
      end

      it "should show success message" do
        flash[:success].should have_content "Password has been reset!"
      end

      it "should change the password" do
        user.authenticate("test").should be_true
      end

      it "should unset password_reset_token" do
        user.clear_password_reset_token
        user.password_reset_token.should be_nil
      end
    end
  end

end
