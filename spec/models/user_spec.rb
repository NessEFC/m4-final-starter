require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe 'validations' do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }
    it { expect(user).to validate_presence_of(:password_digest) }
    it { expect(user).to validate_presence_of(:password_confirmation) }
    it { expect(user).to validate_confirmation_of(:password) }
  end

  describe 'attributes' do
    it { expect(user).to respond_to(:email) }
    it { expect(user).to respond_to(:password_digest) }
    it { expect(user).to respond_to(:password_confirmation) }
    it { expect(user).to respond_to(:password) }
  end

  describe 'associations' do
    it { expect(user).to have_many(:links) }
  end
end
