class Playdate < ApplicationRecord
  validates :species_specific, inclusion: { in: [ true, false ] }
  validates :title, :content, :pet_limit, :start_date_time, :end_date_time, presence: true

  # associations
  belongs_to :owner
  belongs_to :pet
  has_one :location, as :locationable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
