class Comment < ApplicationRecord
  belongs_to :pet
  belongs_to :commentable, polymorphic: true
end
