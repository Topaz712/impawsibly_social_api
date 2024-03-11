class Owner < ApplicationRecord
  validates :first_name, :last_name, :contact_information, presence: true

  belongs_to :user

  has_one :profile, dependent: :destroy
  has_many :pets, dependent: :destroy
  
  after_create :create_profile
end
