# frozen_string_literal: true

class PostBlueprint < Blueprinter::Base
  identifier :id

  view :profile do
    fields :content, :created_at, :post_image_url
    association :pet, blueprint: PetBlueprint, view: :profile
    association :comments, blueprint: CommentBlueprint, view: :profile
  end
end
