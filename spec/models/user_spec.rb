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
end
