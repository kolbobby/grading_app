# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "MyString"
    grade_level 1
    period 1
    sign_in_teacher "MyString"
  end
end
