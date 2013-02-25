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

    # it "renders the index template" do
    #   get :index
    #   response.should render_template :index
    # end

    it_behaves_like "render_template" do
      let(:action) { get :index }
      let(:template) { :index }
    end

  end

  describe "GET show" do
    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:review1) { Fabricate(:review, video: video, rating: 1, user: user1) }
    let(:review2) { Fabricate(:review, video: video, rating: 2, user: user2) }

    it "assigns the requested video to @video" do
      get :show, id: video.id
      assigns(:video).should == video
    end

    it "displays reviews in reverse chronological order" do
      get :show, id: video.id
      assigns(:reviews).should include(review2, review1)
    end

    # it "renders the video show template" do
    #   response.should render_template :show
    # end

    it_behaves_like "render_template" do
      let(:action) { get :show, id: video.id }
      let(:template) { :show }
    end
  end

  describe "POST search" do
    let(:video1) { Fabricate(:video, title: "The Good Cop") }
    let(:video2) { Fabricate(:video, title: "Cop Out") }

    it "assigns the requested results to @results" do
      post :search, search: "cop"
      assigns(:results).should include(video1, video2)
    end

    # it "renders the search template" do
    #   response.should render_template :search
    # end

    it_behaves_like "render_template" do
      let(:action) { get :search, search: "cop" }
      let(:template) { :search }
    end
  end
end