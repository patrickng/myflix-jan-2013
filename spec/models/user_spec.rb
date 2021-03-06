require 'spec_helper'

describe User do

  it { should respond_to(:following_relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:generate_and_store_password_token) }
  it { should respond_to(:token_expired?) }
  it { should respond_to(:clear_password_reset_token) }

  describe "validations" do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email_address) }
    it { should validate_uniqueness_of(:email_address) }
    it { should validate_presence_of(:password) }
  end

  describe "has video in the queue?" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }

    subject { user }

    context "video in queue" do
      before { user.queue_items.create(video: video) }
      it { should have_in_queue(video) }
    end

    context "video not in queue" do
      it { should_not have_in_queue(video) }
    end
  end

  describe "follow actions" do
    let(:user) { Fabricate(:user) }    
    let(:other_user) { Fabricate(:user) }

    subject { user }

    before { user.follow!(other_user) }

    context "following" do
      it { should be_following(other_user) }
      its(:followed_users) { should include(other_user) }
    end

    context "unfollowing" do
      before { user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end

  describe "password reset" do
    let(:user) { Fabricate(:user) }

    before(:each) do
      user.generate_and_store_password_token
    end

    it "should generate a unique password token each time" do
      previous_token = user.password_reset_token
      user.generate_and_store_password_token
      user.password_reset_token.should_not == previous_token
    end

    it "should save the time the password was sent" do
      user.reload.password_reset_sent_at.should be_present
    end

    it "checks if token is expired and returns a boolean value" do
      user.token_expired?.should be_false
    end

    it "clears password_reset_token" do
      user.clear_password_reset_token
      user.password_reset_token.should be_nil
    end
  end

end
