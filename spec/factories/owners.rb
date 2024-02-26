FactoryBot.define do
  factory :owner do
    first_name { "MyString" }
    last_name { "MyString" }
    contact_information { "MyString" }
    user { nil }
  end
end
