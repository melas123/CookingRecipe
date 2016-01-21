FactoryGirl.define do
  factory :user do
    email { rand(1000).to_s + Faker::Internet.email}
    password Faker::Internet.password(10)
  end
end
