require 'rails_helper'

describe('Links API') do
  it 'Creates a new link' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    link_params = { url: 'https://github.com/', title: 'GitHub' }

    post "/api/v1/links", params: { link: link_params }

    link = Link.last

    assert_response :success
    expect(response).to be_success
    expect(Link.count).to eq(1)
    expect(link.url).to eq('https://github.com/')
    expect(link.title).to eq('GitHub')
    expect(link.user_id).to eq(user.id)
  end
end
