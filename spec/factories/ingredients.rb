FactoryGirl.define do 
  factory :ingredient do
    trait :with_name do 
      name { [ Faker::SlackEmoji.food_and_drink,rand(1000) ].join '-' }
    end
    trait :without_name do
      name nil
    end
  end
end