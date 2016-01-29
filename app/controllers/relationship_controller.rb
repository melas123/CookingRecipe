class RelationshipController < ApplicationController

  def follow
    if params[:followed_id] != current_user.id
      Relationship.create follower_id: current_user.id, followed_id: params[:followed_id]
    end
    @user = User.find(params[:followed_id])
    render json: @user
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

  # followers number for current user
  # get 'relationship/nbrFollowers/:user_id'
  def nbrFollowers
    @nbr_followers = User.find( params[:user_id] ).followers.size
    render json: @nbr_followers
  end

  # following number for current user
  # get 'relationship/nbrFollowing/:user_id'
  def nbrFollowing
    @nbr_following = User.find( params[:user_id] ).following.size
    render json: @nbr_following
  end

  #  get 'relationship/isFollowed'
  def isFollowed
    @isFollowed = false
    @follow  = Relationship.where( followed_id: params[:followed_id], follower_id: current_user.id )
    if @follow.present?
      @isFollowed = true
    end
    render json: @isFollowed
  end

end
