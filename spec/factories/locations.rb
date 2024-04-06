FactoryBot.define do
  factory :location do
    locationable 
    zip_code { "MyString" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
    address { "MyString" }
  end
end
