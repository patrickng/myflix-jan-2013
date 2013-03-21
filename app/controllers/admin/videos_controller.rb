class Admin::VideosController < AdminController
  def index
  end

  def new
    @categories = Category.all
    @video = Video.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
