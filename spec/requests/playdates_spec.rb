require 'rails_helper'

RSpec.describe "Playdates", type: :request do
  let(:user) { create(:user) }
  let(:pet) { create(:pet) }
  let(:token) { auth_token_for_user(user) }

  # get playdates - index
  describe "GET /playdates" do
    it 'returns a response with all the playdates' do
      let(:playdate) { create(:playdate) }
      get '/playdates', headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(Playdate.all.to_json)
    end
  end

  # get playdate - show
  describe "GET /playdate" do
    let(:playdate) { create(:playdate) }

    it "returns a response with a specified playdate" do
      get "/playdates/#{playdate.id}", headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(playdate.to_json)
    end
  end

  # create playdate - create
  describe "POST /playdates" do
    let(:user) { create(:user) }
    let(:pet) { create(:pet) }
    let(:token) { auth_token_for_user(user) }

    before do
      playdate_attributes = attributes_for(:playdate, user_id: user.id, pet_id: [pet.id])
      post "/playdates", params: playdate_attributes, headers: { Authorization: "Bearer #{token}" }
    end

    it 'creates a new playdate' do
      expect(Playdate.count).to eq(1)
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end
  end

  # update playdate - update
  describe "PUT /playdates/:id" do
    let(:user) { create(:user) }
    let(:pet) { create(:pet) }
    let(:token) { auth_token_for_user(user) }
    let(:playdate) { create(:playdate) }

    before do
      put "/playdates/#{playdate.id}", params: { title: "New Title" }, headers: { Authorization: "Bearer #{token}" }
    end

    it 'updates a playdate' do
      playdate.reload
      expect(playdate.title).to eq("New Title")
    end
  end

  # delete playdate - destroy
  describe "DELETE /playdates/:id" do
    let(:user) { create(:user) }
    let(:pet) { create(:pet) }
    let(:token) { auth_token_for_user(user) }
    let(:playdate) { create(:playdate) }

    before do
      delete "/playdates/#{playdate.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it "deletes a playdate" do
      expect(Playdate.count).to eq(0)
    end

    it "destroys playdate participants" do
      playdate_participants = PlaydateParticipant.where(playdate_id: playdate.id)
      expect(playdate_participants).to be_empty
    end
  end
end
