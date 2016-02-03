require 'rails_helper'

RSpec.describe Image, type: :model do
  it "has a valide avatar and title" do
  	expect(build(:image_with_valid_avatar)).to be_valid
  end

  it "has not a valide avatar" do
  	expect(build(:image_with_invalid_avatar)).to_not be_valid
  end

  it "has no recipe" do
  	expect(build(:image_with_no_recipe)).to_not be_valid
  end
end
