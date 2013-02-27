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

  describe "DELETE destroy" do
    let(:follower) { Fabricate(:user) }
    let(:followed) { Fabricate(:user) }

    before(:each) do
      set_current_user(follower)
      follower.follow!(followed)
      delete :destroy, id: followed.id
    end

    it "removes the followed from the follower list" do
      current_user.following?(followed).should be_nil
    end

    it "redirects to the people page" do
      response.should redirect_to people_path
    end
  end

  describe "POST create" do
    let(:follower) { Fabricate(:user) }
    let(:followed) { Fabricate(:user) }

    before(:each) do
      set_current_user(follower)
      post :create, id: followed.id
    end

    it "adds the followed to the follower list" do
      current_user.followed_users.should == [followed]
    end

    it "redirects to the people page" do
      response.should redirect_to people_path
    end
  end
end
