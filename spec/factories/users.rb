FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "example-#{n}" }
    sequence(:email) { |n| "example-#{n}@mail.com" }
    password { "password" }
  end
end
