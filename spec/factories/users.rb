FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier:3..30, separators: %w(. _ -)) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
