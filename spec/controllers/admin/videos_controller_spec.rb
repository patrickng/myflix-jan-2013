require 'spec_helper'

describe Admin::VideosController do
  describe "GET index" do
    let(:user) { Fabricate(:user, admin: true) }

    before(:each) do
      set_current_user(user)
    end

    it "sets the @videos variable" do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)

      get :index
      assigns(:videos).should == [video1, video2]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET new" do
    let(:user) { Fabricate(:user, admin: true) }

    before(:each) do
      set_current_user(user)
      get :new
    end

    it "sets the @video variable" do
      assigns(:video).should be_new_record
      assigns(:video).should be_instance_of(Video)
    end

    it "renders the new template" do
      response.should render_template :new
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user, admin: true) }
    let(:category) { Fabricate(:category, name: "Test Category") }

    before(:each) do
      set_current_user(user)
    end

    it "creates the video successfully" do
      post :create, category: { id: category.id }, video: { title: "Test Video", description: "Just a test video entry" }

      Video.last.title.should == "Test Video"
      Video.last.description.should == "Just a test video entry"
      Video.last.categories.should == [category]
      response.should redirect_to video_path(Video.last)
    end

    it "fails to create the video" do
      post :create, category: { id: category.id }, video: { title: "", description: "" }

      Video.all.count.should == 0
      response.should render_template :new
    end
  end

  describe "GET edit" do
    let(:user) { Fabricate(:user, admin: true) }
    let(:video) { Fabricate(:video) }

    before(:each) do
      set_current_user(user)
      get :edit, id: video.id
    end

    it "sets the @video variable" do
      assigns(:video).should == video
    end

    it "renders the edit template" do
      response.should render_template :edit
    end
  end

  describe "PUT update" do
    let(:user) { Fabricate(:user, admin: true) }
    let(:video) { Fabricate(:video, title: "Test", description: "test") }
    let(:category) { Fabricate(:category) }

    before(:each) do
      set_current_user(user)
    end

    context "successful update" do

      before(:each) do
        put :update, id: video.id, category: { id: category.id }, video: { title: "Test Video", description: "Just a test video entry" }
      end

      it "should update the video entry" do
        Video.last.title.should == "Test Video"
        Video.last.description.should == "Just a test video entry"
      end

      it "should show success message" do
        flash[:success].should have_content "Video updated!"
      end

      it "should redirect to @video" do
        response.should redirect_to video_path(Video.last)
      end
    end

    context "unsuccessful update" do
      before(:each) do
        put :update, id: video.id, category: { id: category.id }, video: { title: "", description: "" }
      end

      it "should not update the video entry" do
        Video.last.title.should == "Test"
        Video.last.description.should == "test"
      end

      it "should render the new template" do
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let(:user) { Fabricate(:user, admin: true) }
    let(:video) { Fabricate(:video, title: "Test", description: "test") }
    let(:category) { Fabricate(:category) }

    before(:each) do
      set_current_user(user)
      delete :destroy, id: video.id
    end

    it "should delete the video" do
      Video.all.count.should == 0
    end

    it "should redirect to admin_videos_path" do
      response.should redirect_to admin_videos_path
    end

  end
end
