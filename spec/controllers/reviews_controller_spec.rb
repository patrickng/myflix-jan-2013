require 'spec_helper'

describe ReviewsController do
  let(:video) { Fabricate(:video) }

  before(:each) do
    set_current_user
  end

  describe "POST create" do
    context "validation success" do
      before(:each) do
        
      end

      it "creates a review for video with the correct inputs" do
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5, review: "This movie was a great movie!"}
        video.reviews.count.should == 1
        video.reviews.first.rating.should == 5
        video.reviews.first.review.should == "This movie was a great movie!"
      end

      it "sets the user to the current user" do
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5, review: "This movie was a great movie!"}
        video.reviews.first.user.should == current_user
      end

      # it "should redirect user to review page of the video" do
      #   response.should redirect_to(video_path(video))
      # end

      it_behaves_like "redirect_to" do
        let(:action) { post :create, video_id: video.id, review: { rating: 5, max_rating: 5, review: "This movie was a great movie!"} }
        let(:path) { video_path(video) }
      end
    end

    context "validation error" do
      it "does not save the review" do
        post :create, video_id: video.id, review: { rating: 5, max_rating: 5 }
        video.reviews.count.should == 0
      end

      # it "renders the video show template" do
      #   response.should render_template :show
      # end

      it_behaves_like "render_template" do
        let(:action) { post :create, video_id: video.id, review: { rating: 5, max_rating: 5 } }
        let(:template) { :show }
      end
    end
  end
end
