class Owner < ApplicationRecord
  validates :first_name, :last_name, :contact_information, presence: true

  belongs_to :user
  has_many :pets
end
