FactoryGirl.define do
  factory :job do
    title FFaker::Job.title
    description FFaker::Lorem.paragraph
    guid FFaker::Lorem.word
  end
end