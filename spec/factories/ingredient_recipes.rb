FactoryGirl.define do
  factory :ingredient_recipe do
    trait :valid do
      ingredient { create :ingredient, :with_name }
      recipe
      quantity 5
    end

    trait :with_no_recipe do
      ingredient { create :ingredient, :with_name }
      recipe nil
      quantity 5
    end

    trait :with_no_ingredient do
      ingredient nil
      recipe
      quantity 5
    end
  end
end
