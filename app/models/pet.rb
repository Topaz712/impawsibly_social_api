class Pet < ApplicationRecord
  validates :name, presence: true
  validates :species, presence: true
  validates :breed, presence: true
  validates :sex, presence: true
  validates :birthday, presence: true
  validates :is_vaccinated, presence: true

  belongs_to :owner
end
