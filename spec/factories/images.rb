FactoryGirl.define do

 	factory :image_with_valid_url,class: Image do
   	title "MyString"
		url Faker::Avatar.image
		recipe
	end
	factory :image_with_invalid_url,class: Image do
		title "MyString"
		url nil
		recipe
	end
	factory :image_with_no_recipe,class: Image do
		title "MyString"
		url Faker::Avatar.image
		recipe nil
	end

end
