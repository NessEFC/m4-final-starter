require 'rails_helper'

RSpec.feature('Login') do
  context('A currently signed-out user') do
    scenario('can login successfully') do
      user = create(:user)

      visit root_path

      expect(current_path).to eq(login_path)

      fill_in("session[email]", with: user.email)
      fill_in("session[password]", with: user.password)
      click_on('Submit')

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome back, #{user.email}")
      expect(page).to have_link("Signout")
    end

    scenario('cannot login successfully') do
      user = create(:user)

      visit root_path

      expect(current_path).to eq(login_path)

      fill_in("session[email]", with: user.email)
      click_on('Submit')

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Login failed, make sure your email and password are correct.")
    end
  end
end
