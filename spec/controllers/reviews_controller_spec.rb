require 'spec_helper'

describe ReviewsController do
  let(:video) { Fabricate(:video) }
  let(:user) { Fabricate(:user) }

  before(:each) do
    set_current_user(user)
  end

  describe "POST create" do
    context "validation success" do

      let(:user) { Fabricate(:user) }
      
      before(:each) do
        set_current_user(user)
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5, content: "This movie was a great movie!"}
      end

      it "creates a review for video with the correct inputs" do
        video.reviews.count.should == 1
        video.reviews.first.rating.should == 5
        video.reviews.first.content.should == "This movie was a great movie!"
      end

      it "sets the user to the current user" do
        video.reviews.first.user.should == current_user
      end

      it "should redirect user to review page of the video" do
        response.should redirect_to(video_path(video))
      end
    end

    context "validation error" do

      before(:each) do
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5 }
      end

      it "does not save the review" do
        video.reviews.count.should == 0
      end

      it "renders the video show template" do
        response.should render_template :show
      end
    end
  end
end
