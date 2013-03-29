require 'spec_helper'

describe UsersController do
  describe "GET new" do
    context "without invitation token" do
      it "sets the @user variable" do
        get :new
        assigns(:user).should be_new_record
        assigns(:user).should be_instance_of(User)
      end
    end

    context "with invitation token" do
      let(:user1) { Fabricate(:user) }
      let(:user2) { Fabricate(:user) }
      let(:user3) { Fabricate(:user, invitation_id: invitation1.id) }
      let(:invitation1) { Fabricate(:invitation, sender: user1) }
      let(:invitation2) { Fabricate(:invitation, sender: user1) }

      it "has not been used" do
        get :new
        User.find_by_invitation_id(Invitation.find_by_token(invitation2.token)).should be_nil
      end

      it "has been used" do
        get :new
        user3.invitation.token.should_not be_nil
      end
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
    after do
      ActionMailer::Base.deliveries.clear
    end

    context "user is not saved" do
      before do
        StripeGateway::Charge.stub(:create).and_return(nil)
        post :create, token: "123", user: { email_address: "", full_name: "", password: "" }
      end

      it "does not create the account" do
        User.all.count.should == 0
      end

      it "renders new template when user is not created" do
        response.should render_template :new
      end

      it "does not charge the user" do
        StripeGateway::Charge.stub(:new).and_return(nil)
        charge = StripeGateway::Charge.new
        charge.should be_nil
      end
    end

    context "with a successful charge" do
      before do
        charge = double('charge')
        charge.stub(:successful?).and_return(true)
        StripeGateway::Charge.stub(:create).and_return(charge)
      end

      it "sets flash[:success]" do
        post :create, token: "123", user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
        flash[:success].should == "Thank you for your payment."
      end

      context "user is saved" do
        before(:each) do
          post :create, token: "123", user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
        end

        it "creates the user successfully" do
          User.last.email_address.should == "test@test.com"
          User.last.full_name.should == "test tester"
          User.last.authenticate('test').should be_true
        end

        it "redirects user to login_path" do
          response.should redirect_to login_path
        end
      end

      context "sending email" do
        before(:each) do
          post :create, token: "123", user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
        end

        it "sends out the email" do
          ActionMailer::Base.deliveries.should_not be_empty
        end

        it "sends the email to the right recipient" do
          last_email.to.should == ['test@test.com']
        end

        it "has the right content" do
          last_email.body.should include('Welcome to MyFlix!')
        end
      end

      context "with invitation token" do
        let(:invitation) { Fabricate(:invitation) }
        let(:user) { Fabricate(:user) }

        before do
          post :create, token: "123", user: { email_address: "test@test.com", full_name: "test tester", password: "test", invitation_token: invitation.token }
        end

        it "should follow users in both directions" do
          user2 = User.where(email_address: 'test@test.com').first
          user = invitation.sender
          
          user2.following?(user).should be_true
          user.following?(user2).should be_true
        end

        it "should have invitation token" do
          user2 = User.where(email_address: 'test@test.com').first
          user2.invitation = invitation
          user = invitation.sender

          user2.invitation.token.should_not be_nil
        end
      end
    end

    context "with an error charge" do
      before do
        charge = double('charge')
        charge.stub(:successful?).and_return(false)
        charge.stub(:error_message).and_return('Your card was declined')
        StripeGateway::Charge.stub(:create).and_return(charge)
        post :create, token: "123", user: { email_address: "test@test.com", full_name: "test tester", password: "test" }
      end

      it "sets flash[:error]" do
        flash[:error].should == 'Your card was declined'
      end

      it "renders the new template" do
        response.should render_template :new
      end

      it "does not save the user" do
        User.all.count.should == 0
      end
    end
  end
end
