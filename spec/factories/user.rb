FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    username 'foo@bar.com'
    password 'foobar'
  end
end