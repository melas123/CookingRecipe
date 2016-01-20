require 'rails_helper'

RSpec.describe Image, type: :model do
  it "has a valide url and title" do
  	expect(build(:image_with_valid_url)).to be_valid
  end

  it "has not a valide url" do
  	expect(build(:image_with_invalid_url)).to_not be_valid
  end

  it "has no recipe" do
  	expect(build(:image_with_no_recipe)).to_not be_valid
  end
end
