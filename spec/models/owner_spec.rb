require 'rails_helper'

RSpec.describe Owner, type: :model do
  context 'Validation tests' do
    it 'is not valid without a first name' do
      owner = build(:owner, first_name: nil)
      expect(owner).not_to be_valid
    end

    it 'is not valid without a last name' do
      owner = build(:owner, last_name: nil)
      expect(owner).not_to be_valid
    end
  
    it 'is not valid without contact information' do
      owner = build(:owner, contact_information: nil)
      expect(owner).not_to be_valid
    end

    it 'is not valid without a user' do
      owner = build(:owner, user: nil)
      expect(owner).not_to be_valid
    end
  end

  context 'Associations tests' do
    it 'belongs to a user' do
      owner = build(:owner)
      expect(owner).to respond_to(:user)
    end
  end

end