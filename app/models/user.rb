class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validate :validate_username
  validates :email, presence: true, uniqueness: true, length: {minimum: 5, maximum: 255}, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Associations
  has_one :owner

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
