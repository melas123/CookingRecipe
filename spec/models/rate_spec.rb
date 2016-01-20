require 'rails_helper'

RSpec.describe Rate, type: :model do
  it "is a valid rate" do
    expect(build :rate, :valid).to be_valid
  end

  it "has a value > 5" do
    expect(build :rate, :gt_then_five).to_not be_valid
  end

  it "has a value < 0" do
    expect(build :rate, :lt_then_oh).to_not be_valid
  end

  it "has no value" do
    expect(build :rate, :nil_value).to_not be_valid
  end

  it "has no recipe" do
    expect(build :rate, :nil_recipe).to_not be_valid
  end

  it "has no user" do
    expect(build :rate, :nil_user).to_not  be_valid
  end

  it "user rate a recipe ones " do
    user = create(:user)
    recipe = create(:recipe)
    rate1 =  create(:rate, user_id: user.id, recipe_id: recipe.id, value: 5)
    rate2 =  build(:rate, user_id: user.id, recipe_id: recipe.id, value: 3)
    expect(rate2).to_not  be_valid
  end
end
