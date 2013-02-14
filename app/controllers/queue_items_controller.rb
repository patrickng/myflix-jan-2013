class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items.order('position ASC')
  end

  def new
    queue_item = QueueItem.new
  end

  def create
    queue_item = QueueItem.create(user_id: current_user, video_id: params[:video_id], position: current_user.queue_items.count + 1)
    if queue_item.save
      redirect_to my_queue_path
    else
      redirect_to root_path, notice: "Error adding video to your queue."
    end
  end

  def destroy
    queue_item = current_user.queue_items.find(params[:id])
    queue_item.destroy

    redirect_to my_queue_path
  end

  def sort
    sorted = params[:queue_items].sort_by { |key, value| value['position'] }
    sorted.each_with_index do |item, index|
      QueueItem.find(item[0].to_i).update_attributes(position: index + 1)
    end

    redirect_to my_queue_path
  end
end