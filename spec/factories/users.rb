FactoryBot.define do
  factory :user do
    username { "TestUser" }
    email { "test@example.com" }
    password { "test123" }
  end
end
