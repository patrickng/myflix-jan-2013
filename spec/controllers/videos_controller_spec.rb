require 'spec_helper'

describe VideosController do

  before(:each) do
    user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
    session[:user] = user
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
    end

    it "assigns the requested video to @video" do
      get :show, id: @video.id
      assigns(:video).should eq(@video)
    end

    it "renders the video template" do
      get :show, id: @video.id
      response.should render_template :show
    end
  end

  describe "POST search" do
    before(:each) do
      @video1 = Video.create(title: "Cop Out", description: "A comedy movie")
      @video2 = Video.create(title: "Cop Land", description: "A thriller movie")
    end

    it "assigns the requested results to @results" do
      post :search, search: "cop"
      assigns(:results).should include(@video1, @video2)
    end

    it "renders the search template" do
      get :search, search: "cop"
      response.should render_template :search
    end
  end
end