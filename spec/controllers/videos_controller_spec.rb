require 'spec_helper'

describe VideosController do
  let(:user) { Fabricate(:user) }
  
  before(:each) do
    set_current_user(user)
  end

  describe "GET index" do
    it "sets the @categories variable" do
      comedy = Fabricate(:category)
      drama = Fabricate(:category)

      get :index
      assigns(:categories).should == [comedy, drama]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end

  end

  describe "GET show" do
    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:review1) { Fabricate(:review, video: video, rating: 1, user: user1) }
    let(:review2) { Fabricate(:review, video: video, rating: 2, user: user2) }

    before(:each) do
      get :show, id: video.id
    end

    it "assigns the requested video to @video" do
      assigns(:video).should == video
    end

    it "displays reviews in reverse chronological order" do
      assigns(:reviews).should include(review2, review1)
    end

    it "renders the video show template" do
      response.should render_template :show
    end
  end

  describe "POST search" do
    let(:video1) { Fabricate(:video, title: "The Good Cop") }
    let(:video2) { Fabricate(:video, title: "Cop Out") }

    before(:each) do
      post :search, search: "cop"
    end

    it "assigns the requested results to @results" do
      assigns(:results).should include(video1, video2)
    end

    it "renders the search template" do
      response.should render_template :search
    end
  end
end