require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validation" do
    it "is valid params" do
      expect(user).to be_valid
    end

    context "with invalid params" do
      it "without email" do
        user = User.new(email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it "without first_name" do
        user = User.new(first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it "without last_name" do
        user = User.new(last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it "without country" do
        user = User.new(country: nil)
        user.valid?
        expect(user.errors[:country]).to include("can't be blank")
      end

      it "without state" do
        user = User.new(state: nil)
        user.valid?
        expect(user.errors[:state]).to include("can't be blank")
      end

      it "without city" do
        user = User.new(city: nil)
        user.valid?
        expect(user.errors[:city]).to include("can't be blank")
      end

      it "without street" do
        user = User.new(street: nil)
        user.valid?
        expect(user.errors[:street]).to include("can't be blank")
      end

      it "without zip" do
        user = User.new(zip: nil)
        user.valid?
        expect(user.errors[:zip]).to include("can't be blank")
      end

      it "without password" do
        user = User.new(password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it "without first_name" do
        user = User.new(first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it "is invalid with a duplicate email" do
        other_user = User.new(email: user.email)
        other_user.valid?
        expect(other_user.errors[:email]).to include("has already been taken")
      end

      it "invalid confirm password" do
        user = User.new(password: "password", password_confirmation: "another_password")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it "invalid password length" do
        user = User.new(password: "12345")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end
  end

  describe ".address" do
    it "return a full address" do
      user = User.new(street: "Bandera", city: "Lviv", state: "Lvivska", country: "Ukraine")
      expect(user.address).to eq "Bandera, Lviv, Lvivska, Ukraine"
    end
  end
end
