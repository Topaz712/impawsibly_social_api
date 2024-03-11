require 'rails_helper'

RSpec.describe "Owners", type: :request do
  describe "GET /owners" do
    let(:owner) { create(:owner) }
    let(:token) { auth_token_for_user(owner.user) }

    before do
      get "/owners", headers: { Authorization: "Bearer #{token}" }
    end

    it "returns a successful response when fetching all owners" do
      expect(response).to be_successful
    end

    it "returns a response with all the owners' data" do
      expect(response.body).to eq(Owner.all.to_json)
    end
  end

  # show
  describe "GET /owners/:id" do
    let(:owner) { create(:owner) }
    let(:token) { auth_token_for_user(owner.user) }

    before do
      get "/owners/#{owner.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it "returns a successful response when fetching a specific owner" do
      expect(response).to be_successful
    end

    it "returns a response with the correct owner" do
      expect(response.body).to eq(owner.to_json)
    end
  end

  # create 
  describe "POST /owners" do
    context "with valid params" do

      before do
        owner_attributes = attributes_for(:owner, user_id: user.id)
        post "/owners", params: owner_attributes
      end

      it "returns a successful response when creating a new owner" do
        expect(response).to be_successful
      end

      it "creates a new owner with valid params" do
        expect(Owner.count).to eq(1)
      end
    end

    context "with invalid params" do

      before do
        owner_attributes = attributes_for(:owner, first_name: nil, last_name: nil, email: nil, user_id: user.id)
        post "/owners", params: owner_attributes
      end

      it "returns a response with validation errors when creating an owner with invalid params" do
        expect(response.status).to eq(422)
      end
    end
  end

  #update
  describe "PUT /owners/:id" do
    context "with valid params" do
      let(:owner) { create(:owner) }
      let(:token) { auth_token_for_user(owner.user) }

      before do
        owner_attributes = { first_name: "John" }
        put "/owners/#{owner.id}", params: owner_attributes, headers: { Authorization: "Bearer #{token}" }
      end

      it "updates an owner with valid params" do
        owner.reload
        expect(owner.first_name).to eq("John")
      end

      it "returns a success response" do
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      let(:owner) { create(:owner) }
      let(:token) { auth_token_for_user(owner.user) }

      before do
        owner_attributes = { first_name: nil }
        put "/owners/#{owner.id}", params: owner_attributes, headers: { Authorization: "Bearer #{token}" }
      end

      it "returns a response with validation errors when updating an owner with invalid params" do
        expect(response.status).to eq(422)
      end
    end
  end

  # destroy
  describe "DELETE /owners/:id" do
    let(:owner) { create(:owner) }
    let(:token) { auth_token_for_user(owner.user) }

    before do
      delete "/owners/#{owner.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it "deletes a specific owner" do
      expect(Owner.count).to eq(0)
    end

    it "returns a successful response when deleting an owner" do
      expect(response).to be_successful
    end
  end
end