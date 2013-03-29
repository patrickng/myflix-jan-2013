require 'spec_helper'

describe CategoriesController do
  describe "GET index" do
    let(:user) { Fabricate(:user) }

    before(:each) do
      set_current_user(user)
    end

    it "assigns the @categories variable" do
      comedy = Fabricate(:category)
      drama = Fabricate(:category)

      get :index
      assigns(:categories).should == [comedy, drama]
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }
    let(:category) { Fabricate(:category) }

    before(:each) do
      set_current_user(user)
    end

    it "assigns the @category variable" do
      get :show, id: category.id
      assigns(:category).should == category
    end
  end
end