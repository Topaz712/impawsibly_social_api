class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validate :validate_username
  validates :email, presence: true, uniqueness: true, length: {minimum: 5, maximum: 255}, format: { with: URI::MailTo::EMAIL_REGEXP }

  # associations
  has_many :comments, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_one :location, as: :locationable, dependent: :destroy
  
  # events that the owner has created
  has_many :created_playdates, class_name: 'Playdate', foreign_key: 'user_id'

  # playdate events the user is participating in
  has_many :playdate_participants
  has_many :playdates, through: :playdate_participants

  # when user is created, create pet
  # after_create :create_pet

  before_create :downcase_email

  private 

  def downcase_email
    self.email = email.downcase
  end

  def validate_username
    unless username =~ /\A[a-zA-Z0-9_]+\Z/
      errors.add(:username, "can only contain letters, numbers, and underscores, and must contain atleast one letter or number")
    end
  end
end
