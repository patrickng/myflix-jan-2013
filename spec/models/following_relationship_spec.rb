require 'spec_helper'

describe FollowingRelationship do
  let(:follower) { Fabricate(:user) }
  let(:followed) { Fabricate(:user) }
  let(:relationship) { follower.following_relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should == follower }
    its(:followed) { should == followed }
  end
end
