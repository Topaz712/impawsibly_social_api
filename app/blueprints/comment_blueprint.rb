# frozen_string_literal: true

class CommentBlueprint < Blueprinter::Base
  identifier :id

  view :profile do
    fields :content
    association :pet, blueprint: PetBlueprint, view: :short
  end
end
