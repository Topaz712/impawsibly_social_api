require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end
  
  describe 'validations' do
    it 'is not valid without a name' do
      pet = build(:pet, name: nil)
      expect(pet).to_not be_valid
    end

    it 'is not valid without a bio' do
      pet = build(:pet, bio: nil)
      expect(pet).to_not be_valid
    end
    
    it 'is not valid without a species' do
      pet = build(:pet, species: nil)
      expect(pet).to_not be_valid
    end

    it 'is not valid without a breed' do
      pet = build(:pet, breed: nil)
      expect(pet).to_not be_valid
    end

    it 'is not valid without a sex' do
      pet = build(:pet, sex: nil)
      expect(pet).to_not be_valid
    end

    it 'is not valid without a birthday' do
      pet = build(:pet, birthday: nil)
      expect(pet).to_not be_valid
    end

    it 'is not valid without is_vaccinated' do
      pet = build(:pet, is_vaccinated: nil)
      expect(pet).to_not be_valid
    end

    it 'is not valid without is_fixed' do
      pet = build(:pet, is_fixed: nil)
      expect(pet).to_not be_valid
    end

    # destroy
    context 'destroy pet and everything dependent on it' do
      let (:pet) { create(:pet) }
      let (:pet_id) {pet.id}
    end
  
    before do
      pet.destroy
    end

    # deletes pet posts
    it 'deletes the posts of a pet' do
      posts = Post.where(pet_id: pet.id)
      expect(posts).to be_empty
    end

  # deletes pet comments
    it 'deletes the comments of a pet' do
      comments = Comment.where(pet_id: pet.id)
      expect(comments).to be_empty
    end
  end
end

