class Admin::VideosController < AdminController
  def index
    @videos = Video.all
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
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      redirect_to admin_videos_path, flash: { success: "Video updated!" }
    else
      render :edit
    end
  end

  def destroy
    video = Video.find(params[:id])
    video.destroy

    redirect_to admin_videos_path
  end
end
