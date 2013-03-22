class Admin::VideosController < AdminController
  def index
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])

    if @video.save
      redirect_to @video, flash: { success: "Video added successfully!" }
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
