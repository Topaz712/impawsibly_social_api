class Like < ApplicationRecord
  # uniqueness validation will make sure that a like’s user_id & post_id combination is unique
  validates :user_id, uniqueness: {scope: :post_id}

  belongs_to :user
  belongs_to :post
end
