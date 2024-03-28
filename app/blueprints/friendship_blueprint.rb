# frozen_string_literal: true

class FriendshipBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :status
    association :pet, blueprint: PetBlueprint, view: :short
    association :friend, blueprint: PetBlueprint, view: :short
  end
end
