class RelationshipController < ApplicationController
  def follow
    if params[:followed_id] != current_user.id
      Relationship.create follower_id: current_user.id, followed_id: params[:followed_id]
    end
  end

  def unfollow
    Relationship.where( followed_id: params[:followed_id], follower_id: current_user.id ).first.destroy
  end

  def followers
    @followers = User.find( params[:user_id] ).followers
  end

  def following
    @following = User.find( params[:user_id] ).following
  end
end
