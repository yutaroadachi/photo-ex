FactoryBot.define do
  factory :post do
    title { "post" }
    association :user
  end
end
