require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "belongs to an user and recipe and have rate value" do
    expect(build :comment, :valid).to be_valid  
  end	

  it "has no user" do
    expect(build :comment, :nouser).to_not  be_valid  
  end 

   it "has no recipe" do
    expect(build :comment, :norecipe).to_not be_valid  
  end 

   it "has no text" do
    expect(build :comment, :notext).to_not be_valid  
  end 
end
