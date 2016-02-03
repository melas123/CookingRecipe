# spec/factories/recipes.rb
FactoryGirl.define do
  factory :recipe do
    sequence( :title ) { |n| "Test recipe #{n}" }
    sequence( :description ) { |n| "description #{n}" }

    trait :with_ingredients do
      after( :create ) do |recipe|
        recipe.ingredient_recipes.create(ingredient: FactoryGirl.create( :ingredient, :with_name ), quantity: 2 )
      end
    end

  end
end
