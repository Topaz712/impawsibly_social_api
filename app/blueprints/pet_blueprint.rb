# frozen_string_literal: true

class PetBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :name, :species, :birthday
    association :owner, blueprint: OwnerBlueprint, view: :short
    association :profile, blueprint: ProfileBlueprint, view: :short
  end

  view :long do
    include_view :short, fields: [:breed, :sex, :is_vaccinated, :is_fixed]
    association :posts, blueprint: PostBlueprint, view: :profile
    association :comments, blueprint: CommentBlueprint, view: :profile
    association :playdates, blueprint: PlaydateBlueprint, view: :profile
    association :sent_friend_requests, blueprint: FriendshipRequestBlueprint, view: :short
    association :received_friend_requests, blueprint: FriendshipRequestBlueprint, view: :short
    association :friends, blueprint: FriendshipBlueprint, view: :short
  end

  view :profile do
    include_view :short
    include_view :long
  end
end