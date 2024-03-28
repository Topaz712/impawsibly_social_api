# frozen_string_literal: true

class PlaydateParticipantBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :rating
    association :owner, blueprint: OwnerBlueprint, view: :normal
    association :pet, blueprint: PetBlueprint, view: :short
    association :playdate, blueprint: PlaydateBlueprint, view: :short
  end
end
