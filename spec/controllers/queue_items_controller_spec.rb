require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "should set the @queue_item variable" do
      user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
      video = Video.create(title: "Cop Out", description: "A comedy movie")
      session[:user_id] = user.id
      queue_item = QueueItem.create(user_id: session[:user_id], video_id: video.id)
      
      get :index
      assigns(:queue_item).should == [queue_item]
    end

    it "should render the index template" do
      user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
      session[:user_id] = user.id

      get :index
      response.should render_template :index
    end

    it "should only show queue items for current user" do
      user1 = User.create(email_address: "test1@test.com", full_name: "test tester 1", password: "test")
      user2 = User.create(email_address: "test2@test.com", full_name: "test tester 2", password: "test")
      video1 = Video.create(title: "Cop Out", description: "A comedy movie")
      queue_item1 = QueueItem.create(user_id: user1.id, video_id: video1.id)
      queue_item2 = QueueItem.create(user_id: user2.id, video_id: video1.id)
      session[:user_id] = user1.id

      get :index
      QueueItem.find_all_by_user_id(session[:user_id]).should_not include(queue_item2)
    end
  end

  describe "POST create" do
    it "should add movie to queue" do
      user = User.create(email_address: "test@test.com", full_name: "test tester", password: "test")
      video = Video.create(title: "Cop Out", description: "A comedy movie")
      session[:user_id] = user.id
      queue_item = QueueItem.create(user_id: user.id, video_id: video.id)

      post :create, { video_id: 1, user_id: 1 }
      QueueItem.all.count.should == 2
    end
  end

  describe "DELETE destroy" do
    context "when user is logged in" do
      let(:user) { Fabricate(:user) }
      let(:queue_item) { Fabricate(:queue_item, user: user ) }

      before(:each) do
        session[:user_id] = user.id
      end

      it "should not have the queue item" do
        delete :destroy, { id: queue_item.id }
        QueueItem.all.should_not include(queue_item)
      end

      it "should redirect to my_queue_path" do
        delete :destroy, { id: queue_item.id }
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
end
