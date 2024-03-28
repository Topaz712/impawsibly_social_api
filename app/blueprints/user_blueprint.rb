# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  view :me do
    fields :username, :email
  end

  view :normal do
    fields :username
  end

  view :profile do
    include_view :normal
    association :owner, blueprint: OwnerBlueprint, view: :profile
  end

  view :extended do
    fields :username, :email, :created_at, :updated_at
  end
end
