# frozen_string_literal: true

class PostBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :content, :post_image_url
    association :user, blueprint: UserBlueprint, view: :normal
  end

  view :profile do
    fields :content, :created_at, :post_image_url
    association :pet, blueprint: PetBlueprint, view: :normal
    association :user, blueprint: UserBlueprint, view: :normal
    # association :comments, blueprint: CommentBlueprint, view: :profile
  end
end
