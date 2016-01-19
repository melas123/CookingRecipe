FactoryGirl.define do 
	factory :ingredient do 
		trait :withname do 
			name "i,g"
		end
		trait :withoutname do
		    name nil
		end
	end	

end	     