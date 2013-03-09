require 'spec_helper'

describe InvitationsController do
  let(:user) { Fabricate(:user) }

  before(:each) do
    set_current_user(user)
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "invitation is saved" do
      before(:each) do
        post :create, invitation: { recipient_full_name: "Jack Example", recipient_email_address: "jack@example.me", recipient_message: "Check out this site!" }
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "creates the invitation" do
        Invitation.last.recipient_full_name.should == "Jack Example"
        Invitation.last.recipient_email_address.should == "jack@example.me"
        Invitation.last.recipient_message.should == "Check out this site!"
      end

      it "should have a token" do
        Invitation.last.token.should_not be_nil
      end

      it "redirects user to new_invitation_path" do
        response.should redirect_to new_invitation_path
      end
    end

    context "sending email" do
      before(:each) do
        post :create, invitation: { recipient_full_name: "Jack Example", recipient_email_address: "jack@example.me", recipient_message: "Check out this site!" }
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "sends out the email" do
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it "sends the email to the right recipient" do
        last_email.to.should == ['jack@example.me']
      end

      it "has the right invitee name" do
        last_email.body.should include("Jack Example")
      end

      it "has body content" do
        last_email.body.should_not be_nil
      end
    end

    context "invitation is not saved" do
      before(:each) do
        post :create, invitation: { recipient_full_name: "", recipient_email_address: "", recipient_message: "" }
      end

      it "does not create the invitation" do
        Invitation.all.count.should == 0
      end
      
      it "renders the new template" do
        response.should render_template :new
      end
    end
  end
end
