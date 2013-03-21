require 'spec_helper'

describe Admin::VideosController do
  describe "GET index" do
  end

  describe "GET new" do
    before(:each) do
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
  end

  describe "GET edit" do
  end

  describe "PUT update" do
  end

  describe "DELETE destroy" do
  end
end
