class Playdate < ApplicationRecord
  include Rails.application.routes.url_helpers

  # active storage
  has_one_attached :cover_image

  # validations
  validates :species_specific, inclusion: { in: [ true, false ] }
  validates :title, :content, :pet_limit, :start_date_time, :end_date_time, presence: true

  # associations
  belongs_to :owner
  belongs_to :pet
  has_one :location, as: :locationable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :playdate_participants
  has_many :owners, through: :playdate_participants
  has_many :pets, through: :playdate_participants

  def start_date_time_cannot_be_in_past
    if start_date_time.present? && start_date_time < DateTime.now
      errors.add(:start_date_time, "The start date cannot be in the past")
    end
  end

  def end_date_time_cannot_be_before_start_date_time
    if end_date_time < start_date_time
      errors.add(:end_date_time, "The end date time cannot be before the start date")
    end
  end

  def cover_image_url
    # url helpers
    rails_blob_url(self.cover_image, only_path: false) if self.cover_image.attached?
  end
end
