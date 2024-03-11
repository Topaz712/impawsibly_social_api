class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2500}

  belongs_to :pet_profile, class_name: 'Profile'
end
