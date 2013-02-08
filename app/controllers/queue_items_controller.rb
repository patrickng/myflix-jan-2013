class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue = QueueItem.find_all_by_user_id(session[:user_id])
  end

  def create

  end
end