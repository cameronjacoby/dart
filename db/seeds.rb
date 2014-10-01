4.times do
  Company.create({name: Faker::Company.name})
end

cities = ["San Francisco", "Los Angeles", "New York, NY", "Chicago", "London"]
categories = ["Full Stack", "Front End", "Back End", "Mobile - iOS", "Mobile - Android", "Other"]

Company.all.each do |company|
  company.get_crunchbase_path
  company.get_crunchbase_profile
  5.times do 
    company.jobs.create({
      title: Faker::Lorem.words(2).join(' '),
      location: cities.sample,
      category: categories.sample,
      description: Faker::Lorem.paragraph,
      how_to_apply: Faker::Lorem.sentence
    })
  end
end

20.times do
  Skill.create({name: Faker::Lorem.word})
end

Job.all.each do |job|
  job.skills << Skill.all.sample(5)
end