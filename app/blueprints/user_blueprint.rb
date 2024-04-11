# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  view :me do
    fields :first_name, :last_name, :username, :email
  end

  view :normal do
    fields :username
  end

  view :profile do
    association :pets, blueprint:PetBlueprint, view: :long
    association :location, blueprint: LocationBlueprint
    association :comments, blueprint: CommentBlueprint, view: :profile
    association :playdates, blueprint: PlaydateBlueprint, view: :profile do |user, options|
      user.playdates.order(start_date_time: :desc).limit(5)
    end
  end
end
