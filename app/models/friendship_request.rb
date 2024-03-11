class FriendshipRequest < ApplicationRecord
  validates :sender_id, recipient_id, presence: true

  belongs_to :friendship

  belongs_to :sender, class_name: 'Pet', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'Pet', foreign_key: 'recipient_id'
end
