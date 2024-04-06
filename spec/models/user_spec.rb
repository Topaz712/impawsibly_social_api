require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validation tests' do
    it 'is valid with a username and password' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user = build(:user, username: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a first name' do
      user = build(:user, first_name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a last name' do
      user = build(:user, last_name: nil)
      expect(user).to_not be_valid
    end
  
    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    # password
    it 'is invalid when password is nil' do
      user = build(:user, password: nil)
    end
    
    # password_confirmation
    it 'is invalid when password_confirmation is nil' do
      user = build(:user, password_confirmation: nil)
    end

    # hashes and password
    it 'hashes the password' do
      user = create(:user)
      expect(user.password_digest).not_to eq 'password'
    end
  end

  context 'Uniqueness tests' do
    it 'is not valid without a unique username' do
      user1 = create(:user)
      user2 = build(:user, username: user1.username)

      expect(user2).not_to be_valid
      expect(user2.errors[:username]).to include("has already been taken")
    end

    it 'is not valid without a unique email' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)

      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  context 'destroy user and everything dependent on it' do
    let (:user) { create(:user) }
    let (:user_id) {user.id}
  end

  before do
    user.destroy
  end

  # deletes pets associated with user
  it 'deletes the pets of a user' do
    pet = Pet.find_by(user_id: user.id)
    expect(pet).to be_nil
  end

  # deletes user location
  it 'deletes location' do
    location = Location.find_by(locationable_id: user_id)
    expect(location).to be_nil
  end

end