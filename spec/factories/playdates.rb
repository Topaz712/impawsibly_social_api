FactoryBot.define do
  factory :playdate do
    owner { nil }
    pet { nil }
    title { "MyText" }
    content { "MyText" }
    species_specific { false }
    pet_limit { 1 }
    start_date_time { "2024-03-18 00:38:17" }
    end_date_time { "2024-03-18 00:38:17" }
  end
end
