FactoryGirl.define do
  factory :order do
    user
    total_price Faker::Commerce.price
  end
end
