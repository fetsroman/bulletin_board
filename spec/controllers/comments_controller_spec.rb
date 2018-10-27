require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:advert) { create(:advert) }
  let(:comment) { create(:comment, user: user, advert: advert) }
  let(:valid_params) { attributes_for(:comment, content: "New content") }
  let(:invalid_params) { attributes_for(:comment, content: nil) }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "POST #create" do
    context "with valid params" do
      it "saves the new advert in the database" do
        comment
        expect{ post :create, xhr: true, params: { id: comment, comment: valid_params, advert_id: advert.id } }.to change(Comment, :count).by(1)
      end

      it "responds successfully" do
        post :create, xhr: true, params: { id: comment, comment: valid_params, advert_id: advert.id }
        expect(response).to be_success
      end
    end

    context "with invalid params" do
      it "does not save the new advert in the database" do
        expect{ post :create, xhr: true, params: { id: comment, comment: invalid_params, advert_id: advert.id } }.to change(Comment, :count)
      end

      it "responds successfully" do
        post :create, xhr: true, params: { id: comment, comment: invalid_params, advert_id: advert.id }
        expect(response).to be_success
      end
    end
  end

  describe "GET #edit" do
    it "responds successfully" do
      get :edit, params: { id: comment, comment: valid_params, advert_id: advert.id }
      expect(response).to be_success
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates a advert" do
        patch :update, params: { id: comment, comment: valid_params, advert_id: advert.id }
        expect(comment.reload.content).to eq "New content"
      end

      it "redirects to advert path" do
        patch :update, params: { id: comment, comment: valid_params, advert_id: advert.id }
        expect(response).to redirect_to "/adverts/#{advert.id}"
      end
    end

    context "with invalid params" do
      it "responds successfully" do
        patch :update, params: { id: comment, comment: invalid_params, advert_id: advert.id }
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the comment" do
      comment
      expect{ delete :destroy, xhr: true, params: { id: comment, advert_id: advert.id } }.to change(Comment, :count).by(-1)
    end

    it "responds successfully" do
      delete :destroy, xhr: true, params: { id: comment, advert_id: advert.id }
      expect(response).to be_success
    end
  end
end