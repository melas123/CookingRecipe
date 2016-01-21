FactoryGirl.define do
  factory :comment do
  	trait :valid do 
  		recipe
  		user
  		text Faker::Lorem::paragraph
  	end	

  	trait :nouser do 
  		recipe
  		user nil
  		text Faker::Lorem::paragraph
  	end	

  	trait :norecipe do 
  		recipe nil
  		user
  		text Faker::Lorem::paragraph
  	end	

  	trait :notext do 
  		recipe
  		user
  	end	
  end
end
