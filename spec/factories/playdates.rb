FactoryBot.define do
  factory :playdate do
    user
    pet 
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    pet_limit { rand(1..7) }
    species_specific { Faker::Boolean.boolean(true_ratio: 1) }
    start_date_time { Faker::Time.forward(days: 25, period: :morning) }
    end_date_time { Faker::Time.forward(days: 25, period: :evening) }
  end
end
