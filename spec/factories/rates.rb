FactoryGirl.define do
  factory :rate do
    trait :valid do
      value { rand( 6 ) }
      recipe
      user
    end

    trait :gt_then_five do
      value { 6+rand( 10 ) }
      recipe
      user
    end

    trait :lt_then_oh do
      value { -1-rand( 10 ) }
      recipe
      user
    end

    trait :nil_value do
      value nil
      recipe
      user
    end

    trait :nil_recipe do
      value { rand( 6 ) }
      recipe nil
      user
    end

    trait :nil_user do
      value { rand( 6 ) }
      recipe
      user nil
    end
  end
end
