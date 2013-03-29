class QueueItemsController < AuthenticatedController
  def index
    @queue_items = current_user.queue_items.order('position ASC')
  end

  def new
    queue_item = QueueItem.new
  end

  def create
    queue_item = QueueItem.create(user_id: session[:user_id], video_id: params[:video_id], position: current_user.queue_items.count + 1)
    if queue_item.save
      redirect_to my_queue_path
    else
      redirect_to root_path, notice: "Error adding video to your queue."
    end
  end

  def update
    if QueueItem.update_fields(params[:queue_items])
      redirect_to my_queue_path
    else
      redirect_to home_path, flash: { error: "You have no videos in your queue." }
    end
  end

  def destroy
    queue_item = current_user.queue_items.find(params[:id])
    queue_item.destroy

    redirect_to my_queue_path
  end
end