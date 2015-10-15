FactoryGirl.define do
  name = Faker::Lorem.words(2).join(" ").titleize
  factory :role do
    name name
    slug name.parameterize
  end
end