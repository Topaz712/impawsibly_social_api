# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :username
  end

  view :extended do
    fields :username, :email, :created_at, :updated_at
  end
end
