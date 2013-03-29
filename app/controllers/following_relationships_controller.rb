class FollowingRelationshipsController < AuthenticatedController
  def index
    @followed_users = current_user.followed_users
  end

  def create
    user = User.find(params[:id])
    current_user.follow!(user)

    redirect_to people_path
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow!(user)

    redirect_to people_path
  end
end
