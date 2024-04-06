require 'rails_helper'

RSpec.describe Playdate, type: :model do
  context "validations" do
    it 'is not valid without a user and pet' do
      playdate = build(:playdate, user:nil, pet:nil)
      expect(playdate).not_to be_valid
    end

    it 'is not valid without a title' do
      playdate = build(:playdate, title: nil)
      expect(playdate).not_to be_valid
    end

    it 'is not valid without content' do
      playdate = build(:playdate, content: nil)
      expect(playdate).not_to be_valid
    end

    it 'is not valid with start_date_time to be before current_time' do
      playdate = build(:playdate, start_date_time: DateTime.now - 1)
      expect(playdate).not_to be_valid
    end

    it 'is not valid with start_date_time to be after end_date_time' do
      playdate = build(:playdate, start_date_time: DateTime.now + 1, end_date_time: DateTime.now)
      expect(playdate).not_to be_valid
    end
  end

  context "associations" do
    it 'belongs to a user' do
      playdate = build(:playdate)
      expect(playdate.user).to be_present
    end

    it 'belongs to a pet' do
      playdate = build(:playdate)
      expect(playdate.pet).to be_present
    end

    it 'has many comments' do
      playdate = create(:playdate)
      create_list(:comment, 3, commentable: playdate)

      playdate.reload
      expect(playdate.comments.count).to eq(3)
    end
  end

  context "destroy related associations" do
    it "destroy playdate participants" do
      playdate = create(:playdate)
      playdate_id = playdate.id
      playdate.destroy
      playdate_participants = PlaydateParticipant.where(playdate_id: playdate.id)
      expect(playdate_participants).to be_empty
    end
  end
end
