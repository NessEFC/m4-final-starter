require 'rails_helper'

RSpec.feature('Create a link', js: true) do
  scenario('an authenticated user can create a new link') do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect('.link-list').to have_content('')

    fill_in('link[url]', with: 'https://github.com/')
    fill_in('link[title]', with: 'GitHub')
    click_link_or_button('Add Link')

    link = Link.last

    expect(link.url).to eq('https://github.com/')
    expect(link.title).to eq('GitHub')
    expect(page).to have_content(link.url)
    expect(page).to have_content(link.title)
  end
end
