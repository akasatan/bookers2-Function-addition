class RelationshipsController < ApplicationController
  
  def follower_index
    @user = User.find(params[:id])
  end
  
  def followed_index
    @user = User.find(params[:id])
  end
  
  def create
    follow = current_user.follower.new(followed_id: params[:user_id])
    follow.save
    redirect_to request.referer
  end

  def destroy
    follow = current_user.follower.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_to request.referer
  end
  
end
