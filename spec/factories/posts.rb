FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "post-#{n}" }
    association :user
  end
end
