class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:follower_id])
    follower = current_user.follow(@other_user)
      if follower.save
        redirect_to users_path(@other_user), notice: 'ユーザーをフォローしました'
      else
        redirect_to users_path(@other_user), notice: 'ユーザーのフォローに失敗しました'
      end
  end

  def destroy
    @user = current_user.relationships.find(params[:follower_id]).follower
    current_user.unfollow(params[:id])
  end
end
