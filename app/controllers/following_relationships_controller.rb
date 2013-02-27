class FollowingRelationshipsController < ApplicationController
  def index
    @followed_users = current_user.followed_users
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow!(user)
    
    redirect_to people_path
  end
end
