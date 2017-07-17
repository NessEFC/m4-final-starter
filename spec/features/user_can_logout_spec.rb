require 'rails_helper'

RSpec.feature('Logout') do
  context('A currently signed-in user') do
    scenario('can logout') do
      user = create(:user)

      visit login_path

      fill_in('session[email]', with: user.email)
      fill_in('session[password]', with: user.password)
      click_button('Submit')

      click_on('Signout')

      expect(page).to have_content('You have successfully logged out!')
      expect(page).to have_content('Login')
      expect(page).to have_content('Register')
      expect(page).to_not have_content('Signout')
      expect(page).to have_content("Don't have an account? Sign Up by clicking here")
    end
  end
end
