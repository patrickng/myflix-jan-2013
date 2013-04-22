require 'spec_helper'

describe Admin::PaymentsController do
  describe "GET index" do
    context "admin" do
      let(:user) { Fabricate(:user, admin: true) }

      before(:each) do
        set_current_user(user)
      end

      it "sets the @payments variable" do
        payment1 = Fabricate(:payment)
        payment2 = Fabricate(:payment)

        get :index
        assigns(:payments).should == [payment1, payment2]
      end

      it "renders the index template" do
        get :index
        response.should render_template :index
      end
    end

    context "non-admin"do
      let(:user) { Fabricate(:user) }

      before(:each) do
        set_current_user(user)
        get :index
      end

      it "redirects to home page" do
        response.should redirect_to home_path
      end

      it "shows an error message" do
        flash[:error].should == "You do not have access to that area."
      end
    end
  end
end
