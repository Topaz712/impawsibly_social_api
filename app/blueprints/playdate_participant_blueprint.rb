# frozen_string_literal: true

class PlaydateParticipantBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :rating
    association :user, blueprint: UserBlueprint, view: :normal
    association :pet, blueprint: PetBlueprint, view: :short
    association :playdate, blueprint: PlaydateBlueprint, view: :short
  end
end
