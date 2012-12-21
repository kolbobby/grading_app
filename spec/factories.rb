FactoryGirl.define do
	factory :user do
		name "Test User"
		uname "tuser"
		password "foobar"
		password_confirmation "foobar"
	end
end