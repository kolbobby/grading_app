# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    name "MyString"
    coach "MyString"
    marking_period 1
    activity_number 1
  end
end
