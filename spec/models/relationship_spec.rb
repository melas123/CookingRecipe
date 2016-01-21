require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it "adds a follower" do
    follower = create(:user)
    followed = create(:user)
    
    expect{
      relaationship = create(:relationship, follower: follower, followed: followed)
    }.to change{ followed.followers.count }.by(1)
  end

  it "adds a followed" do
    follower = create(:user)
    followed = create(:user)
    
    expect{
      relaationship = create(:relationship, follower: follower, followed: followed)
    }.to change{ follower.following.count }.by(1)
  end

  it "is a duplicate Relationship" do
    follower = create(:user)
    followed = create(:user)
    # Already have a realtion
    relaationship = create(:relationship, follower: follower, followed: followed)

    #Trying to follow again
    expect{
      relaationship = create(:relationship, follower: follower, followed: followed)
    }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
