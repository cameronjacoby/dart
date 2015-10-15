FactoryGirl.define do
  factory :user do
    email Faker::Internet.safe_email
    password Faker::Internet.password(6)
  end
end