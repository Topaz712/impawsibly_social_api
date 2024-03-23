# require 'faker'

# # Users creation
# (1..5).each do |i|
#   user = User.create!(
#     username: Faker::Internet.username(specifier: 3..20, separators: %w(_)),
#     email: Faker::Internet.email,
#     password: 'password',
#     password_confirmation: 'password'
#   )

#   # Owner profile
#   owner = user.create_owner(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     contact_information: Faker::PhoneNumber.phone_number
#   )

#   # random num of pets for each owner
#   rand(1..5).times do
#     pet = owner.pets.create(
#       name: Faker::Creature::Dog.name,
#       species: 'Dog',
#       breed: Faker::Creature::Dog.breed,
#       sex: Faker::Creature::Dog.gender,
#       birthday: Faker::Date.birthday(min_age: 1, max_age: 10),
#       is_vaccinated: Faker::Boolean.boolean(true_ratio: 0.8),
#       is_fixed: Faker::Boolean.boolean(true_ratio: 0.2)
#     )

#     # pet profile creation
#     pet.create_profile(
#       bio: Faker::Lorem.sentence
#     )
#   end

#   # pet posts
#   owner.pets.each do |pet|
#     rand(1..10).times do
#       pet.posts.create(
#         content: Faker::Lorem.paragraph
#       )
#     end
#   end

#   # create random playdate events
#   rand(1..3).times do
#     playdate = owner.playdates.create(
#       title: Faker::Lorem.sentence,
#       content: Faker::Lorem.paragraph,
#       pet_limit: rand(1..7),
#       start_date_time: Faker::Time.forward(days: 25, period: :morning),
#       end_date_time: Faker::Time.forward(days: 25, period: :evening)
#     )

#     # create playdate participants
#     owner.pets.each do |pet|
#       playdate.playdate_participants.create(
#         pet: pet,
#         rating: rand(1..5)
#       )
#     end
#   end
# end

require 'faker'

ActiveRecord::Base.transaction do 
  (1..5).each do |i|
    user = User.create!(
      username: Faker::Internet.username(specifier: 3..20, separators: %w(_)),
      email: Faker::Internet.email,
      password: 'password',
      password_confirmation: 'password'
    )

    owner = Owner.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      contact_information: Faker::PhoneNumber.phone_number,
      user_id: user.id
    )

    rand(1..5).times do
      pet = Pet.create!(
        name: Faker::Creature::Dog.name,
        species: 'Dog',
        breed: Faker::Creature::Dog.breed,
        sex: Faker::Creature::Dog.gender,
        birthday: Faker::Date.birthday(min_age: 1, max_age: 10),
        is_vaccinated: Faker::Boolean.boolean(true_ratio: 1),
        is_fixed: Faker::Boolean.boolean(true_ratio: 1),
        owner_id: owner.id
      )

      Profile.create!(
        bio: Faker::Lorem.sentence,
        pet_id: pet.id,
        owner_id: owner.id
      )

      rand(1..10).times do 
        posts = Post.create!(
          content: Faker::Lorem.paragraph,
          profile_id: pet.profile.id
        )
      end
    end

    rand(1..3).times do 
      playdate = Playdate.create!(
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        pet_limit: rand(1..7),
        start_date_time: Faker::Time.forward(days: 25, period: :morning),
        end_date_time: Faker::Time.forward(days: 25, period: :evening),
        pet_id: owner.pet.id,
        owner_id: owner.id
      )

      owner.pets.each do |pet|
        PlaydateParticipant.create!(
          owner_id: owner.id,
          pet_id: pet.id,
          playdate_id: playdate.id,
          rating: rand(1..5)
        )
      end
    end
  end
end