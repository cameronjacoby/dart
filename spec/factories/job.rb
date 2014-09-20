FactoryGirl.define do
  factory :job do
    title 'Front End Developer'
    location 'San Francisco, CA'
    category 'Front End'
    description Faker::Lorem.words(30).join(' ')
    how_to_apply Faker::Lorem.words(10).join(' ')
  end
end