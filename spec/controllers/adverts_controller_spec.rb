require 'rails_helper'

RSpec.describe AdvertsController, type: :controller do
  let(:user) { create(:user) }
  let(:advert) { create(:advert, user: user) }
  let(:valid_params) { attributes_for(:advert, description: "Some description") }
  let(:invalid_params) { attributes_for(:advert, description: nil) }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #new" do
    it "responds successfully" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "saves the new advert in the database" do
        advert
        expect{ post :create, params: { id: advert, advert: valid_params } }.to change(Advert, :count).by(1)
      end

      it "responds successfully" do
        post :create, params: { id: advert, advert: valid_params }
        expect(response).to be_success
      end
    end

    context "with invalid params" do
      it "does not save the new advert in the database" do
        expect{ post :create, params: { id: advert, advert: invalid_params } }.to change(Advert, :count)
      end

      it "responds successfully" do
        post :create, params: { id: advert, advert: invalid_params }
        expect(response).to be_success
      end
    end
  end

  describe "GET #show" do
    it "responds successfully" do
      get :show, params: { id: advert }
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "responds successfully" do
      get :edit, params: { id: advert, advert: valid_params }
      expect(response).to be_success
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates a advert" do
        patch :update, params: { id: advert, advert: valid_params }
        expect(advert.reload.description).to eq "Some description"
      end

      it "responds successfully" do
        patch :update, params: { id: advert, advert: valid_params }
        expect(response).to be_success
      end
    end

    context "with invalid params" do
      it "responds successfully" do
        patch :update, params: { id: advert, advert: invalid_params }
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the advert" do
      advert
      expect{ delete :destroy, params: { id: advert } }.to change(Advert, :count).by(-1)
    end

    it "redirects to root#index" do
      delete :destroy, params: { id: advert }
      expect(response).to redirect_to(adverts_path)
    end
  end
end