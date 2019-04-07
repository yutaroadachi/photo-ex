FactoryBot.define do
  factory :comment do
    content { "comment" }
    association :post
    user { post.user }
  end
end
