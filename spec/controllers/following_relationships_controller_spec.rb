require 'spec_helper'

describe FollowingRelationshipsController do

  describe "GET index" do

    let(:follower) { Fabricate(:user) }
    let(:followed) { Fabricate(:user) }

    before(:each) do
      set_current_user(follower)
      get :index
    end

    it "returns http success" do
      response.should be_success
    end

    it "renders the index template" do
      response.should render_template :index
    end

    before { follower.follow!(followed) }
    
    it "sets the @followed_users variable" do
      assigns(:followed_users).should include(followed)
    end
  end

end
