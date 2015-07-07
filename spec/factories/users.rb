FactoryGirl.define do
  factory :user do
    name      Faker::Name.name
    email     Faker::Internet.email
    admin     false
    password  123456789

    factory :admin do
      admin true
    end
  end
end
