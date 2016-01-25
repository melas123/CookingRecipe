require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Recipe' do

    it "should store into db" do
      expect(create(:recipe)).to_not be_nil
    end

    it "should invalid without a title" do
      expect(build(:recipe, title: '')).to_not be_valid
    end

    it "should invalid without a description" do
      expect(build(:recipe, description: '')).to_not be_valid
    end

    it "calculates rate" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      recipe = create :recipe
      rate1 = create :rate, user_id: user1.id, recipe: recipe, value: 3
      rate2 = create :rate, user_id: user2.id, recipe: recipe, value: 5
      expect(recipe.calculate_rate_for_recipe).to eq(4)
    end

    it "return 0 for recipe without rating" do
      recipe = create :recipe
      expect(recipe.calculate_rate_for_recipe).to eq(0)
    end
  end

end
