FactoryBot.define do
  factory :comment do
    pet { nil }
    commentable { nil }
    content { "MyText" }
  end
end
