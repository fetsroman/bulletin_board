require 'rails_helper'

RSpec.feature "Users", type: :system do
  include ActiveJob::TestHelper

  scenario "user succesfully signs up" do
    visit root_path
    click_link "Sign up"

    expect {
      fill_in "Email", with: "test@mail.com"
      fill_in "First name", with: "Roman"
      fill_in "Last name", with: "Wolt"
      fill_in "Country", with: "Ukraine"
      fill_in "State", with: "Lvivska"
      fill_in "City", with: "Lviv"
      fill_in "Street", with: "Bandera"
      fill_in "Zip", with: "79000"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Sign up"
    }.to change(User, :count).by(1)

    expect(page).to \
    have_content "Welcome! You have signed up successfully."
    expect(current_path).to eq root_path
  end

  scenario "user signs in" do
    user = create(:user)
    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(current_path).to eq root_path
  end

  describe "when user sign in" do
    let(:user) { create(:user) }

    before do
      login_as(user)
    end

    scenario "user update some params" do
      visit "/users/#{user.id}"
      click_link "Edit"
      fill_in "First name", with: "Alex"
      fill_in "Street", with: "Zelena"
      fill_in "Current password", with: user.password
      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully.")
      expect(current_path).to eq "/users/#{user.id}"
    end

    scenario "user delete his account" do
      visit "/users/#{user.id}"
      expect {
        click_link "Edit"
        click_button "Delete my account"
        page.driver.browser.switch_to.alert.accept
      }.to change(User, :count).by(0)

      expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
      expect(current_path).to eq root_path
    end
  end
end
