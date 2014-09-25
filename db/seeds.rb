companies = ["Weft", "Benzinga", "Cerego", "FanJam", "Kaggle", "Lyst", "Thumbtack", "Shortcut",
  "Khan Academy", "Believe.in", "Typeform", "PythonAnywhere", "FoundationDB", "Ginger.io",
  "Sencha", "Heap"]

companies.each do |company_name|
  Company.create({name: company_name})
end

cities = ["San Francisco", "Los Angeles", "New York, NY", "Chicago", "London"]
categories = ["Full Stack", "Front End", "Back End", "Mobile - iOS", "Mobile - Android", "Other"]

Company.all.each do |company|
  puts company.inspect
  puts "company path"
  company.get_crunchbase_path
  puts "company profile"
  company.get_crunchbase_profile
  5.times do 
    company.jobs.create({
      title: Faker::HipsterIpsum.words(2).join(' '),
      location: cities.sample,
      category: categories.sample,
      description: Faker::HipsterIpsum.paragraph,
      how_to_apply: Faker::HipsterIpsum.sentence
    })
  end
end

20.times do
  Skill.create({name: Faker::HipsterIpsum.words(1).join(' ')})
end

Job.all.each do |job|
  job.skills << Skill.all.sample(5)
end