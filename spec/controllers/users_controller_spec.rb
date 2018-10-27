require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:user, first_name: "New name") }
  let(:invalid_params) { attributes_for(:user, email: nil) }

  describe "GET #index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    it "responds successfully" do
      get :show, params: { id: user }
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "responds successfully" do
      get :edit, params: { id: user }
      expect(response).to be_success
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates a user" do
        patch :update, params: { id: user, user: valid_params }
        expect(user.reload.first_name).to eq "New name"
      end

      it "redirects to the user" do
        patch :update, params: { id: user, user: valid_params }
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end

    context "with invalid params" do
      it "returns a 200 response" do
        patch :update, params: { id: user, user: invalid_params }
        expect(response).to have_http_status "200"
      end
    end
  end
end