require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "Get /posts" do

    let(:post) {create(:post)}

    before do
      # this is creates the post by calling it first
      post
      get "/posts"
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end

    it "returns a response with all the posts" do
      expect(response.body).to eq(Post.all.to_json)
    end
  end

  # show
  describe "GET /post/:id" do
    let(:post) {create(:post)}

    before do
      get "/posts/#{post.id}"
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end

    # responds with the specific post 
    it "returns a response with the correct post" do
      expect(response.body).to eq(post.to_json)
    end
  end

  # create
  describe "POST /posts" do
    # valid params
    context "with valid params" do
      let (:pet) {create(:pet)}

      before do
        post_attributes = attributes_for(:post, pet_id: pet.id)
        post "/posts", params: post_attributes
      end

      # returns a successful response
      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "creates a new post" do
        expect(Post.count).to eq(1)
      end
    end

    # invalid params
    context "with invalid params" do
      before do
        post_attributes = attributes_for(:post, pet_id: nil)
        post "/posts", params: post_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  # update
  describe "PUT /posts/:id" do
    context "with valid params" do
      let(:post) {create(:post)}

      before do
        post_attributes = attributes_for(:post, content: "updated content")
        put "/posts/#{post.id}"
      end

      it "updates a post" do
        post.reload
        expect(post.content).to eq("updated content")
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end

    context "with invalid params" do
      let(:post) {create(:post)}

      before do
        post_attributes = { content: nil }
        put "/post/#{post.id}", params: post_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  # destroy
  describe "DELETE /post/:id" do
    let (:post) {create(:post)}

    before do
      delete "/posts/#{post.id}"
    end

    it "deletes a post" do
      expect(Post.count).to eq(0)
    end

    it "returns a success response" do
      expect(response).to be_successful
    end
  end
end
