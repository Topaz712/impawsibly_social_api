class Owner < ApplicationRecord
  validates :first_name, :last_name, :contact_information, presence: true

  belongs_to :user

  # associations
  has_one :profile, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_one :location, as: :locationable, dependent: :destroy
  
  # events that the owner has created
  has_many :created_playdate, class_name: 'Playdate', foreign_key: 'owner_id'

  # playdate events the owner is participating in
  has_many :playdate_participants
  has_many :playdates, through: :playdate_participants


  
  after_create :create_profile
end
