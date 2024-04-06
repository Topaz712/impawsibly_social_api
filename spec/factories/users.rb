FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier:3..30, separators: %w(. _ -)) }
    email { Faker::Internet.email }
    first_name { Faker::name.first_name }
    last_name { Faker::name.last_name }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
