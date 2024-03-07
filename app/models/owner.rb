class Owner < ApplicationRecord
  validates :first_name, :last_name, :contact_information, presence: true

  belongs_to :user

  has_many :pets
  has_many :profiles, through: :pets
  after_create :create_profile
end
