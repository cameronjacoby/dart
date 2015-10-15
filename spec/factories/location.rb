FactoryGirl.define do
  city = Faker::Address.city
  factory :location do
    city city
    state Faker::Address.state_abbr
    country Faker::Address.country
    slug city.parameterize
  end
end