FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end

    password_digest 'password'
    password_confirmation 'password'
  end
end
