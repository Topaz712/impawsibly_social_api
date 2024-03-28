# frozen_string_literal: true

class PlaydateBlueprint < Blueprinter::Base
  identifier :id

  view :profile do
    fields  :title, :content, :start_date_time, :end_date_time, :pet_limit, :species_specific
  end

  view :short do
    fields :title, :pet_limit, :start_date_time, :end_date_time
    association :creator, blueprint: OwnerBlueprint, view: :normal
  end

  view :long do
    include_view :short
    fields :content, :species_specific
    association :human_participants, blueprint: OwnerBlueprint, view: :normal
    association :pet_participants, blueprint: PetBlueprint, view: :short
    association :creator, blueprint: OwnerBlueprint, view: :normal
    association :location, blueprint: LocationBlueprint
    field :has_joined do |playdate, options|
      playdate.has_joined?(options[:current_user])
  end
end
