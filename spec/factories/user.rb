FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    pswrd = Faker::Lorem.words(4).join('')
    password pswrd
    password_confirmation pswrd
    is_seeker? true
  end
end