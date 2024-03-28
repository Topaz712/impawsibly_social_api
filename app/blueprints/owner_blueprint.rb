# frozen_string_literal: true

class OwnerBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :first_name, :last_name
  end

  view :long do
    include_view :normal
    field :contact_information
    association :profile, blueprint: ProfileBlueprint, view: :normal
    association :pets, blueprint: PetBlueprint, view: [:short, :long]
    association :location, blueprint: LocationBlueprint
  end

  view :profile do
    include_view :normal
    include_view :long
  end
end
