class Pet < ApplicationRecord
  validates :name, :species, :breed, :sex, :birthday, :is_vaccinated, :is_fixed, presence: true

  belongs_to :owner
end
