FactoryGirl.define do
  
  factory :user do
    sequence(:first_name)  { |n| "first_name #{n}" }
    sequence(:last_name)  { |n| "last_name #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

    trait :with_stickers do
      after(:create) do |u|
        u.stickers.create! name: "Sample sticker"
        u.stickers.last.locations.create! latitude: 1, longitude: 12
      end
    end
  end

  factory :sticker do
    name    "Sample sticker"
    user_id 1
  end

  factory :location do
    latitude 1
    longitude 12
    sticker_id 1
  end
end
