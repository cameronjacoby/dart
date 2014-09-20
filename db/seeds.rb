# create skills
html = Skill.create({name: 'html'})
css = Skill.create({name: 'css'})
bootstrap = Skill.create({name: 'bootstrap'})
javascript = Skill.create({name: 'javascript'})
jquery = Skill.create({name: 'jquery'})
ajax = Skill.create({name: 'ajax'})
ror = Skill.create({name: 'ruby on rails'})
postgres = Skill.create({name: 'postgres'})
objective_c = Skill.create({name: 'objective-c'})
swift = Skill.create({name: 'swift'})
java = Skill.create({name: 'java'})
python = Skill.create({name: 'python'})
android = Skill.create({name: 'android'})
django = Skill.create({name: 'django'})
node = Skill.create({name: 'node'})
redis = Skill.create({name: 'redis'})
backbone = Skill.create({name: 'backbone'})
d3 = Skill.create({name: 'd3'})


# create seekers
user_cameron = User.create({email: 'cameron.jacoby@gmail.com', password: '12341234', is_seeker?: true})
user_cameron.seeker = Seeker.create({first_name: 'Cameron', last_name: 'Jacoby'})
cameron = user_cameron.seeker

user_mario = User.create({email: 'mario.c.delgado@gmail.com', password: '12341234', is_seeker?: true})
user_mario.seeker = Seeker.create({first_name: 'Mario', last_name: 'Delgado'})
mario = user_mario.seeker


# create company & jobs
user_thumbtack = User.create({email: 'hello@thumbtack.com', password: '12341234', is_company?: true})
user_thumbtack.company = Company.create({name: 'Thumbtack', crunchbase_path: 'organization/thumbtack'})
thumbtack = user_thumbtack.company

thumbtack_frontend = Job.create({
  :title => 'Front-End Developer',
  :location => 'San Francisco, CA',
  :category => 'Front End',
  :description => Faker::Lorem.words(30).join(' '),
  :how_to_apply => Faker::Lorem.words(10).join(' ')
})

thumbtack_frontend.skills << [html, css, bootstrap, javascript, jquery, ajax]

thumbtack_backend = Job.create({
  :title => 'Back-End Developer',
  :location => 'San Francisco, CA',
  :category => 'Back End',
  :description => Faker::Lorem.words(30).join(' '),
  :how_to_apply => Faker::Lorem.words(10).join(' ')
})

thumbtack_backend.skills << [ror, postgres]

thumbtack_ios = Job.create({
  :title => 'iOS Developer',
  :location => 'San Francisco, CA',
  :category => 'Mobile - iOS',
  :description => Faker::Lorem.words(30).join(' '),
  :how_to_apply => Faker::Lorem.words(10).join(' ')
})

thumbtack_ios.skills << [objective_c, swift]

thumbtack_android = Job.create({
  :title => 'Android Developer',
  :location => 'San Francisco, CA',
  :category => 'Mobile - Android',
  :description => Faker::Lorem.words(30).join(' '),
  :how_to_apply => Faker::Lorem.words(10).join(' ')
})

thumbtack_android.skills << [java, python]

# associate jobs to company
thumbtack.jobs << [thumbtack_frontend, thumbtack_backend, thumbtack_ios, thumbtack_android]


# create company & jobs
user_ginger = User.create({email: 'hello@ginger.io', password: '12341234', is_company?: true})
user_ginger.company = Company.create({name: 'Ginger.io', crunchbase_path: 'organization/ginger-io'})
ginger = user_ginger.company

ginger_android = Job.create({
  :title => 'Android Developer',
  :location => 'San Francisco, CA',
  :category => 'Mobile - Android',
  :description => Faker::Lorem.words(30).join(' '),
  :how_to_apply => Faker::Lorem.words(10).join(' ')
})

ginger_android.skills << [android, python, django, javascript]

# associate jobs to company
ginger.jobs << [ginger_android]


# create company & jobs
user_heap = User.create({email: 'hello@heapanalytics.com', password: '12341234', is_company?: true})
user_heap.company = Company.create({name: 'Heap', crunchbase_path: 'organization/heap'})
heap = user_heap.company

heap_engineer = Job.create({
  :title => 'Software Engineer',
  :location => 'San Francisco, CA',
  :category => 'Full Stack',
  :description => Faker::Lorem.words(30).join(' '),
  :how_to_apply => Faker::Lorem.words(10).join(' ')
})

heap_engineer.skills << [node, redis, postgres, backbone, d3]

# associate jobs to company
heap.jobs << [heap_engineer]


# associate (favorite) jobs to seekers
cameron.jobs << [thumbtack_frontend, thumbtack_backend, heap_engineer]
mario.jobs << [thumbtack_ios, thumbtack_android, ginger_android]