class Owner < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :contact_information, presence: true

  belongs_to :user
  has_many :pets
end
