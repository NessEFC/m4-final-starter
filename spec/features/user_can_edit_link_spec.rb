require 'rails_helper'

RSpec.feature('Edit a link') do
  context('As a logged-in user') do
    scenario('a link can be edited') do
      skip
      user = create(:user)
      link = create(:link, title: 'github')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      
      click_on('Edit')

      expect(current_path).to eq(edit_link_path)
      expect(page).to have_content('Edit Link')

      fill_in('link[url]', with: 'http://facebook.com')
      fill_in('link[title]', with: 'Facebook')
      click_on('Update Link')

      expect(current_path).to eq(root_path)

      link = Link.last

      expect(link.url).to eq('http://facebook.com')
      expect(link.title).to eq('Facebook')
    end
  end
end
