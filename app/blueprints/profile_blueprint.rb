# frozen_string_literal: true

class ProfileBlueprint < Blueprinter::Base
  identifier :id
  fields :bio

  view :normal do
    association :owner, blueprint: OwnerBlueprint, view: :profile
    association :pet, blueprint: PetBlueprint, view: :profile
  end
end
