require 'rails_helper'

RSpec.feature "Comments", type: :system do
  let(:user) { create(:user) }
  let(:advert) { create(:advert, user: user) }

  before do
    login_as(user)
  end

  scenario "create comment" do
    visit "/adverts/#{advert.id}"
    expect {
      fill_in "comment[content]", with: "Some comment"
      click_button "Create Comment"

      expect(page).to have_content("Some comment")
    }.to change(advert.comments, :count).by(1)
  end

  describe "when comment created" do
    let!(:comment) { create(:comment, user: user, advert: advert) }

    scenario "edit comment" do
      visit "/adverts/#{advert.id}"
      click_link "Edit Comment"
      fill_in "comment[content]", with: "New comment"
      click_button "Update Comment"

      expect(page).to have_content("Comment was updated")
      expect(page).to have_content("New comment")
      expect(current_path).to eq "/adverts/#{advert.id}"
    end

    scenario "delete comment" do
      expect {
        visit "/adverts/#{advert.id}"
        click_link "Delete Comment"
        page.driver.browser.switch_to.alert.accept
      }.to change(advert.comments, :count).by(0)
    end
  end
end
