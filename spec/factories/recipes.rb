# spec/factories/recipes.rb
FactoryGirl.define do
  factory :recipe do
    sequence( :title ) { |n| "Test recipe #{n}" }
    sequence( :description ) { |n| "description #{n}" }
  end
end
