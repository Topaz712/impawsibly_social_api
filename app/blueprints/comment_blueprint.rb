# frozen_string_literal: true

class CommentBlueprint < Blueprinter::Base
  identifier :id

  view :profile do
    fields :content
    association :user, blueprint: UserBlueprint, view: :short
  end
end
