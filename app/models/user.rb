class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Associations
  has_one :owner

  before_create :downcase_email

  private 

  def downcase_email
    self.email = email.downcase
  end
end
