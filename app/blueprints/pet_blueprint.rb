# frozen_string_literal: true

class PetBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :name, :species, :breed, :birthday
    association :user, blueprint: UserBlueprint, view: :normal
  end

  view :normal do
    fields :name, :bio, :species, :birthday, :breed, :sex, :is_vaccinated, :is_fixed,
    :avatar_image_url
    association :user, blueprint: UserBlueprint, view: :normal
  end

  view :long do
    fields :name, :bio, :species, :birthday, :breed, :sex, :is_vaccinated, :is_fixed

    association :posts, blueprint: PostBlueprint, view: :normal do |user, options|
      user.posts.order(created_at: :desc).limit(5)
    end
    association :playdates, blueprint: PlaydateBlueprint, view: :profile do |user, options|
      user.playdates.order(start_date_time: :desc).limit(5)
    end
  end

end