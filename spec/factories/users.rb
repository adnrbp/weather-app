FactoryBot.define do
  factory :user do
    username { "TestUser" }
    email    { "test@example.com" }
    password { "test123" }

    trait :confirmed do
      confirmed_at  {Time.now}
    end
  end
end
