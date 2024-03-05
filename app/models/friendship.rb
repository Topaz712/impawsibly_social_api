class Friendship < ApplicationRecord
  belongs_to :pet

  belongs_to :friend, class_name: 'Pet'
end