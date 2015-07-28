FactoryGirl.define do
  factory :book do
    title         Faker::Name.title
    author        Faker::Name.name
    pub_date      Faker::Date.backward(10)
    price         Faker::Commerce.price
    sequence(:isbn) { |n| Faker::Number.number(5) + n.to_s }
    sequence(:amazon_id) { |n| Faker::Number.number(6) + n.to_s }
    description   Faker::Lorem.paragraph(2)
  end
end
