# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Users creation
(1..5).each do |i|
  user = User.create(
    username: Faker::Internet.username(specifier: 3..20, separators: %w(_)),
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )

  # Owner profile
  owner = user.create_owner(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    contact_information: Faker::PhoneNumber.phone_number
  )

  # random num of pets for each owner
  rand(1..5).times do
    pet = owner.pets.create(
      name: Faker::Creature::Dog.name,
      species: 'Dog',
      breed: Faker::Creature::Dog.breed,
      sex: Faker::Creature::Dog.gender,
      birthday: Faker::Date.birthday(min_age: 1, max_age: 10),
      is_vaccinated: Faker::Boolean.boolean(true_ratio: 0.8),
      is_fixed: Faker::Boolean.boolean(true_ratio: 0.2)
    )

    # pet profile creation
    pet.create_profile(
      bio: Faker::Lorem.sentence
    )
  end
  profile.save

  # pet posts
  owner.pets.each do |pet|
    rand(1..10).times do
      pet.posts.create(
        content: Faker::Lorem.paragraph
      )
    end
  end

  # create random playdate events
  rand(1..3).times do
    playdate = owner.playdates.create(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      pet_limit: rand(1..7),
      start_date_time: Faker::Time.forward(days: 25, period: :morning),
      end_date_time: Faker::Time.forward(days: 25, period: :morning)
    )

    # create playdate participants
    owner.pets.each do |pet|
      playdate_participants = playdate.playdate_participants.create(
        pet: pet,
        rating: rand(1..5)
      )
    end
  end
end