require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'has a valid factory' do
    expect(build(:link)).to be_valid
  end

  let(:link) { build(:link) }

  describe 'validations' do
    it { expect(link).to validate_presence_of(:url).with_message('is not a valid URL') }
    it { expect(link).to validate_presence_of(:title) }
    it { expect(link).to allow_value('https://github.com/').for(:url) }
    it { expect(link).to_not allow_value('github.com').for(:url) }
  end

  describe 'attributes' do
    it { expect(link).to respond_to(:url) }
    it { expect(link).to respond_to(:title) }
    it { expect(link).to respond_to(:read) }
    it { expect(link).to respond_to(:user_id) }
  end

  describe 'associations' do
    it { expect(link).to belong_to(:user) }
  end
end
