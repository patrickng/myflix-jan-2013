require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    # this doesn't work yet
    
    it "should redirect user to review page of the video" do
      
      user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
      video = Video.create(title: "Cop Out", description: "A comedy movie")

      session[:user_id] = user.id

      post :create, video_id: video.id, review: { user_id: 1, video_id: 1, rating: 5, max_rating: 5, review: "This movie was a great movie!" }

      response.should redirect_to(video_path(video))
    end
  end
end
