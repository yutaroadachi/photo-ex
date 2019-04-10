FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "comment-#{n}" }
    association :post
    association :user
  end
end
