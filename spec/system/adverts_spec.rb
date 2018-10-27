require 'rails_helper'

RSpec.feature "Adverts", type: :system do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  scenario "create a new advert" do
    visit root_path
    expect {
      click_link "New Advert"
      fill_in "Description", with: "Some description"
      attach_file("advert[image]", "#{Rails.root}/spec/fixtures/test_image.jpg")
      click_button "Create Advert"

      aggregate_failures do
        expect(page).to have_content "Advert was saved"
        expect(page).to have_xpath("//img[contains(@src,'large_test_image.jpg')]")
        expect(page).to have_content "#{user.first_name + " " + user.last_name}"
        expect(page).to have_content "Some description"
      end
    }.to change(user.adverts, :count).by(1)
  end

  describe "when advert created" do
    let(:advert) { create(:advert, user: user) }

    scenario "updating advert params" do
      visit "/adverts/#{advert.id}"
      click_link "Edit"
      fill_in "Description", with: "New description"
      attach_file("advert[image]", "#{Rails.root}/spec/fixtures/new_test_image.jpg")
      click_button "Update Advert"

      expect(page).to have_content "Advert was updated"
      expect(page).to have_xpath("//img[contains(@src,'large_new_test_image.jpg')]")
      expect(page).to have_content "#{user.first_name + " " + user.last_name}"
      expect(page).to have_content "New description"
    end

    scenario "delete advert" do
      visit "/adverts/#{advert.id}"
      expect {
        click_link "Delete"
        page.driver.browser.switch_to.alert.accept
      }.to change(user.adverts, :count).by(0)

      expect(page).to have_content("Advert was deleted")
      expect(current_path).to eq adverts_path
    end
  end
end
