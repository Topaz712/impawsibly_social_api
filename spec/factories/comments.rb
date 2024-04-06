FactoryBot.define do
  factory :comment do
    pet 
    commentable 
    content { "MyText" }
  end
end
