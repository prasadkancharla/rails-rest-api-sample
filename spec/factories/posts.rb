FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.word }
    user { Faker::Number.number(10) }
  end
end