FactoryBot.define do
  factory :friendship_request do
    sender { nil }
    recipient { nil }
    friendship { nil }
    status { "MyString" }
  end
end
