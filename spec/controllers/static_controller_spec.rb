require 'spec_helper'

describe StaticController do
  describe "GET index" do
    let(:user) { Fabricate(:user) }

    before(:each) do
      get :index
    end

    it "renders the index static page template" do
      response.should render_template :index
    end

    it "redirects the user to home when logged in" do
      set_current_user(user)

      get :index
      response.should redirect_to home_path
    end
  end
end
