class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_item = QueueItem.find_all_by_user_id(session[:user_id])
  end

  def new
    queue_item = QueueItem.new
  end

  def create
    queue_item = QueueItem.new
    queue_item.video_id = params[:video_id]
    queue_item.user_id = session[:user_id]
    queue_item.save
    if queue_item.save
      redirect_to my_queue_path
    else
      redirect_to root_path, notice: "Error with adding to your queue."
    end
  end

  def destroy
    queue_item = current_user.queue_items.find(params[:id])
    queue_item.destroy

    redirect_to my_queue_path
  end
end