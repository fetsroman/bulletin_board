require 'rails_helper'

RSpec.describe Advert, type: :model do
  let(:user) { create(:user) }
  let(:advert) { create(:advert, user: user) }

  describe "validation" do
    it "is valid params" do
      expect(advert).to be_valid
    end

    context "with invalid params" do
      it "without description" do
        advert = Advert.new(description: nil)
        advert.valid?
        expect(advert.errors[:description]).to include("can't be blank")
      end

      it "without image" do
        advert = Advert.new(image: nil)
        advert.valid?
        expect(advert.errors[:image]).to include("can't be blank")
      end
    end
  end

  describe ".text_search" do
    let(:user_with_name) { create(:user, first_name: "Roman") }
    let(:user_with_surname) { create(:user, last_name: "Wolt") }
    let!(:advert_1) { create(:advert, description: "Some more text", user: user_with_name) }
    let!(:advert_2) { create(:advert, description: "It's great text", user: user_with_surname) }
    let!(:advert_3) { create(:advert_with_comment, user: user) }

    context "with seach params" do
      it "search by advert description" do
        expect(Advert.text_search("text")).to include(advert_1, advert_2)
        expect(Advert.text_search("text")).to_not include(advert_3)
      end

      it "search by user first_name" do
        expect(Advert.text_search("Roman")).to include(advert_1)
        expect(Advert.text_search("Roman")).to_not include(advert_2, advert_3)
      end

      it "search by user last_name" do
        expect(Advert.text_search("Wolt")).to include(advert_2)
        expect(Advert.text_search("Wolt")).to_not include(advert_1, advert_3)
      end

      it "search by comment content" do
        expect(Advert.text_search("sentence")).to include(advert_3)
        expect(Advert.text_search("sentence")).to_not include(advert_1, advert_2)
      end

      it "when no matche is found" do
        expect(Advert.text_search("message")).to be_empty
        expect(Advert.count).to eq 3
      end
    end

    context "without search params" do
      it "still works if nothing is passed in" do
        expect(Advert.text_search(nil)).not_to be_nil
      end
    end
  end
end
