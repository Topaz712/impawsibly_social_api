FactoryBot.define do
  factory :owner do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    contact_information { Faker::PhoneNumber.phone_number }
    user
  end
end
