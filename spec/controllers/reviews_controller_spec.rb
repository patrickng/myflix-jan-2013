require 'spec_helper'

describe ReviewsController do
  let(:user) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  before(:each) do
    session[:user_id] = user.id
  end

  describe "POST create" do
    context "validation success" do
      before(:each) do
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5, review: "This movie was a great movie!"}
      end

      it "creates a review for video with the correct inputs" do
        video.reviews.count.should == 1
        video.reviews.first.rating.should == 5
        video.reviews.first.review.should == "This movie was a great movie!"
      end

      it "sets the user to the current user" do
        video.reviews.first.user.should == user
      end

      it "should redirect user to review page of the video" do
        response.should redirect_to(video_path(video))
      end
    end

    context "validation error" do
      before(:each) do
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5}
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
