require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  

  it "has name" do
  	#i = Ingredient.new(:name => "IngTest")
  	expect(build :ingredient, :with_name).to be_valid
  	 
  end

  it "has no name" do
  	expect(build :ingredient, :without_name).to_not be_valid
  end

  it "has a duplicate name" do
  	 ing = build :ingredient, :with_name
     i = ing.dup
     ing.save
     i.save
     expect(i).to_not be_valid
   end
end
