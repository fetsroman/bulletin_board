require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:user) }

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  controller do
      def after_update_path_for(resource)
        super resource
      end
  end

  describe ".after_update_path_for" do
    it "responds successfully" do
      patch :update, params: {id: user, user: valid_params }
      expect(response).to be_success
    end

    it "redirects to the user" do
      patch :update, params: {id: user, user: valid_params }
      expect(controller.after_update_path_for(user)).respond_to?("/users/#{user.id}")
    end
  end
end
