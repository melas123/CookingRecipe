require 'rails_helper'

RSpec.describe Recipe, type: :model do
 
  it "should store into db", :focus do
    expect(create(:recipe)).to_not be_nil
  end
  #
  it "should invalid without a title" do
    expect(build(:recipe, title: '')).to_not be_valid
  end
  #
  it "should invalid without a description" do
    expect(build(:recipe, description: '')).to_not be_valid
  end

end
