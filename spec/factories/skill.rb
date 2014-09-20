FactoryGirl.define do
  factory :skill do
    name Faker::Lorem.words(2).join(' ')
  end
end