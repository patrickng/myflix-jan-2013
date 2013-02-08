require 'spec_helper'

describe VideosController do

  before(:each) do
    user = Fabricate(:user)
    session[:user_id] = user.id
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
    let(:video) { video = Fabricate(:video) }
    before(:each) do
      @review1 = Fabricate(:review, video: video)
      @review2 = Fabricate(:review, video: video)
      get :show, id: video.id
    end

    it "assigns the requested video to @video" do
      assigns(:video).should == video
    end

    it "renders the video show template" do
      response.should render_template :show
    end

    it "displays reviews in reverse chronological order" do
      assigns(:reviews).should include(@review2, @review1)
    end

    it "displays average rating" do
      assigns(:reviews).average(:rating).to_s.should == ((@review2.rating + @review1.rating) / 2.0).to_s
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