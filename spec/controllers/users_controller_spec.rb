require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    before(:each) do
      set_current_user(user)
      get :show, id: user.id
    end

    it "sets the @user variable" do
      assigns(:user).should == user
    end

    it "sets the @queue_items variable" do
      assigns(:queue_items).should == user.queue_items
    end

    it "sets the @reviews variable" do
      assigns(:reviews).should == user.reviews
    end

    it "renders the show template" do
      response.should render_template :show
    end
  end

  describe "POST create" do
    before(:each) do
      post :create, user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
    end

    context "user is saved" do
      it "creates the user successfully" do
        User.last.email_address.should == "test@test.com"
        User.last.full_name.should == "test tester"
        User.last.authenticate('test').should be_true
      end

      it "redirects user to root" do
        response.should redirect_to root_path
      end
    end
  end

  context "user is not saved" do
    it "does not create the account" do
      count = User.all.count
      post :create, user: { email_address: "test@test.com" }
      User.all.count.should == count
    end

    it "renders new template when user is not created" do
      post :create, user: { email_address: "", full_name: "", password: "" }
      response.should render_template :new
    end
  end
end
