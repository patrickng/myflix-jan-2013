require 'spec_helper'

describe VideosController do

  before(:each) do
    user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
    session[:user_id] = user.id
  end

  describe "GET index" do
    it "sets the @categories variable" do
      comedy = Category.create(name: "comedy", description: "comedy genre")
      drama = Category.create(name: "drama", description: "drama genre")

      get :index
      assigns(:categories).should == [comedy, drama]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET show" do
    before(:each) do
      @video = Video.create(title: "Cop Out", description: "A comedy movie")
      @review1 = Review.create(user_id: session[:user_id], video_id: @video.id, max_rating: 5, rating: 5, review: "This movie was a great movie!")
      @review2 = Review.create(user_id: session[:user_id], video_id: @video.id, max_rating: 5, rating: 3, review: "Family Guy's dry humor and flashback scenes are hilarious!")
      get :show, id: @video.id
    end

    it "assigns the requested video to @video" do
      assigns(:video).should eq(@video)
    end

    it "renders the video template" do
      response.should render_template :show
    end

    it "displays reviews in reverse chronological order" do
      Video.first.reviews.should include(@review2, @review1)
    end

    it "displays average rating" do
      Video.first.reviews.average(:rating).should == 4
    end
  end

  describe "POST search" do
    before(:each) do
      @video1 = Video.create(title: "Cop Out", description: "A comedy movie")
      @video2 = Video.create(title: "Cop Land", description: "A thriller movie")
      post :search, search: "cop"
    end

    it "assigns the requested results to @results" do
      assigns(:results).should include(@video1, @video2)
    end

    it "renders the search template" do
      response.should render_template :search
    end
  end
end