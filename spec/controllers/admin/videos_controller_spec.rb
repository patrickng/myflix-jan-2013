require 'spec_helper'

describe Admin::VideosController do
  describe "GET index" do
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
    let(:small_image) { { :small_image => fixture_file_upload('/family_guy.jpg', 'image/jpeg') } }
    let(:large_image) { { :large_image => fixture_file_upload('/family_guy_large.jpg', 'image/jpeg') } }
    let(:category) { Fabricate(:category, name: "Test Category") }

    before(:each) do
      set_current_user(user)
    end

    it "creates the video successfully" do
      post :create, video: { title: "Test Video", category_id: "1", description: "Just a test video entry", large_cover_img: large_image, small_cover_img: small_image }
      Video.last.title.should == "Test Video"
      Video.last.description.should == "Just a test video entry"
      Video.last.large_cover_url.should_not be_nil
      Video.last.small_cover_url.should_not be_nil
    end
  end

  describe "GET edit" do
  end

  describe "PUT update" do
  end

  describe "DELETE destroy" do
  end
end
