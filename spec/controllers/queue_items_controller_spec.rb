require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }

    before(:each) do
      set_current_user(user)
      get :index
    end

    it "should set the @queue_item variable" do
      queue_item = QueueItem.create(user_id: session[:user_id], video_id: video.id)
      assigns(:queue_items).should == [queue_item]
    end

    it "should render the index template" do
      response.should render_template :index
    end

    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user) }
    let(:video1) { Fabricate(:video) }
    let(:queue_item1) { Fabricate(:queue_item, user: user1, video: video1) }
    let(:queue_item2) { Fabricate(:queue_item, user: user2, video: video1) }

    it "should only show queue items for current user" do
      QueueItem.find_all_by_user_id(session[:user_id]).should_not include(queue_item2)
    end
  end

  describe "POST create" do
    it "should add movie to queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = user.id
      queue_item = QueueItem.create(user_id: user.id, video_id: video.id)
      post :create, { video_id: 1, user_id: 1 }
      QueueItem.all.count.should == 2
    end
  end

  describe "DELETE destroy" do
    context "when user is logged in" do

      let(:user) { Fabricate(:user) }
      let(:queue_item) { Fabricate(:queue_item, user: user) }

      before(:each) do
        set_current_user(user)
        delete :destroy, id: queue_item.id
      end

      it "should not have the queue item" do
        QueueItem.all.should_not include(queue_item)
      end

      it "should redirect to my_queue_path" do
        response.should redirect_to my_queue_path
      end
    end

    context "when user is not logged in" do
      let(:user) { Fabricate(:user) }

      it "should redirect user to login" do
        video = Fabricate(:video)
        queue_item = QueueItem.create(user_id: user.id, video_id: video.id)
        delete :destroy, { id: queue_item.id }
        response.should redirect_to login_path
      end
    end
  end

  describe "POST queue_items#update" do
    let(:user) { Fabricate(:user) }
    let(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1) }
    let(:queue_item2) { Fabricate(:queue_item, user: current_user, position: 2) }
    let(:queue_item3) { Fabricate(:queue_item, user: current_user, position: 3) }

    before(:each) do
      set_current_user(user)
    end

    it "sorts queue items by position" do
      post :update, queue_items: { queue_item1.id => { position: 3 }, queue_item2.id => { position: 1 }, queue_item3.id => { position: 2 } }

      current_user.queue_items.reload.should == [queue_item2, queue_item3, queue_item1]
      current_user.queue_items.reload.map(&:position).should == [1, 2, 3]
    end

    it "sorts queue items by position with decimals" do
      post :update, queue_items: { queue_item1.id => { position: 1.5 }, queue_item2.id => { position: 1 }, queue_item3.id => { position: 2 } }

      current_user.queue_items.reload.should == [queue_item2, queue_item1, queue_item3]
      current_user.queue_items.reload.map(&:position).should == [1, 2, 3]
    end

    it "redirects to my_queue" do
      post :update, queue_items: { queue_item1.id => { position: 1.5 }, queue_item2.id => { position: 1 }, queue_item3.id => { position: 2 } }
      response.should redirect_to my_queue_path
    end

    it "updates existing video rating" do
      video = Fabricate(:video)
      review = Fabricate(:review, video: video, user: current_user)
      post :update, queue_items: { queue_item1.id => { position: 1, rating: 1 } }

      current_user.queue_items.reload.first.video.reviews.where(user_id: current_user.id).first.rating.should == 1
    end

    it "creates new review with rating when rating does not exist" do
      video = Fabricate(:video)
      post :update, queue_items: { queue_item1.id => { position: 1, rating: 2 } }

      Review.where(user_id: current_user.id).count.should == 1
      Review.where(user_id: current_user.id).first.rating.should == 2
    end
  end
end