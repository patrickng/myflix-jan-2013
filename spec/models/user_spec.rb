require 'spec_helper'

describe User do

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

  it { should respond_to(:following_relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }

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

end
