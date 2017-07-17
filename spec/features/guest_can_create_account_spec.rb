require 'rails_helper'

RSpec.feature('Sign-up') do
  context('As an unauthenticated user') do
    scenario('they can sign-up') do
      visit root_path

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Login')
      click_on('Sign Up by clicking here')

      expect(current_path).to eq(new_user_path)
      fill_in("user[email]", with: 'craig@example.com')
      fill_in("user[password]", with: 'password')
      fill_in("user[password_confirmation]", with: 'password')
      click_on "Submit"

      expect(current_path).to eq(root_path)

      user = User.last
      expect(user.email).to eq('craig@example.com')
      expect(user.password_digest).not_to be_empty
      expect(page).to have_content("Welcome: #{user.email}")
      expect(page).to have_link('Signout')
    end

    scenario('email is not unique') do
      user = create(:user, email: 'craig@example.com')

      visit new_user_path

      fill_in("user[email]", with: 'craig@example.com')
      fill_in("user[password]", with: 'password')
      fill_in("user[password_confirmation]", with: 'password')
      click_on "Submit"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("An account is already associated with this email address")
    end

    scenario('password confirmation can\'t be blank') do
      visit new_user_path

      fill_in("user[email]", with: 'craig@example.com')
      fill_in("user[password]", with: 'password')
      click_on "Submit"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Password confirmation must match the password. Password confirmation can't be blank.")
    end

    scenario('password confirmation doesn\'t match password') do
      visit new_user_path

      fill_in("user[email]", with: 'craig@example.com')
      fill_in("user[password]", with: 'password')
      fill_in("user[password_confirmation]", with: 'Password')
      click_on "Submit"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Password confirmation must match the password.")
    end

    scenario('email can\'t be blank') do
      visit new_user_path

      fill_in("user[password]", with: 'password')
      fill_in("user[password_confirmation]", with: 'password')
      click_on "Submit"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("You must enter an email address.")
    end

    scenario('password can\'t be blank') do
      visit new_user_path

      fill_in("user[email]", with: 'craig@example.com')
      fill_in("user[password_confirmation]", with: 'password')
      click_on "Submit"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("You must enter a password.")
    end
  end
end
