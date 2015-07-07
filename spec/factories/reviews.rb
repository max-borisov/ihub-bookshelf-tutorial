FactoryGirl.define do
  factory :review do
    user
    book
    text Faker::Lorem.paragraph(2)
  end
end
