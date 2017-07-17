require 'rails_helper'

RSpec.feature('Link form') do
  context('as an authenticated user') do
    scenario('they can see a link form on the index page') do
      user = create(:user)
      link = create(:link, user_id: user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_content('URL:')
      expect(page).to have_content('Title:')
      expect(page).to have_button('Add Link')
      expect(page).to have_css('#link-url-input')
      expect(page).to have_css('#link-title-input')
    end
  end
end
