FactoryGirl.define do
  factory :link do
    title { Faker::Hipster.word }
    url 'https://github.com/'
    read false
    user
  end
end
