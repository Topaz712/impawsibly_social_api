FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    bio { Faker::Lorem.sentence }
    species { 'Dog' }
    breed { Faker::Creature::Dog.breed }
    sex { Faker::Creature::Dog.gender }
    bio { Faker::Lorem.sentence }
    birthday { Faker::Date.birthday(min_age: 1, max_age: 10) }
    is_vaccinated { Faker::Boolean.boolean(true_ratio: 1) }
    is_fixed { Faker::Boolean.boolean(true_ratio: 1) }
    user
  end
end
