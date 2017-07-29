require 'rails_helper'

RSpec.feature('Invalid link', js: true) do
  context('as an authenticated user') do
    scenario('they can\'t submit invalid URL') do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in('link[url]', with: 'github.com')
      fill_in('link[title]', with: 'GitHub')
      click_link_or_button('Add Link')

      expect(Link.count).to eq(0)
    end
  end
end
