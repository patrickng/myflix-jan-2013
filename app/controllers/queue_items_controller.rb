class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue = QueueItem.find_all_by_user_id(session[:user_id])
  end

  def new
    @queue = QueueItem.new
  end

  def create
    @queue = QueueItem.new
    @queue.video_id = params[:video_id]
    @queue.user_id = session[:user_id]
    @queue.save
    if @queue.save
      redirect_to my_queue_path
    else
      redirect_to root_path, notice: "Error with adding to your queue."
    end
  end
end