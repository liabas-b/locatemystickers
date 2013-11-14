# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    key "MyString"
    times_used 1
    popularity 1.5
    color "MyString"
    forbidden false
    scope "MyString"
  end
end
