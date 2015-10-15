FactoryGirl.define do
  factory :job do
    title Faker::Name.title
    description Faker::Lorem.paragraph
  end
end