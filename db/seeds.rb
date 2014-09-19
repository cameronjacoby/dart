# create skills
html = Skill.create({name: "html"})
css = Skill.create({name: "css"})
bootstrap = Skill.create({name: "bootstrap"})
javascript = Skill.create({name: "javascript"})
jquery = Skill.create({name: "jquery"})
ajax = Skill.create({name: "ajax"})
ror = Skill.create({name: "ruby on rails"})
postgres = Skill.create({name: "postgres"})
objective_c = Skill.create({name: "objective-c"})
swift = Skill.create({name: "swift"})
java = Skill.create({name: "java"})
python = Skill.create({name: "python"})
android = Skill.create({name: "android"})
django = Skill.create({name: "django"})
node = Skill.create({name: "node"})
redis = Skill.create({name: "redis"})
backbone = Skill.create({name: "backbone"})
d3 = Skill.create({name: "d3"})


# create seekers
user_cameron = User.create({email: "cameron.jacoby@gmail.com", password: "12341234", is_seeker?: true})
user_cameron.seeker = Seeker.create({first_name: "Cameron", last_name: "Jacoby"})
cameron = user_cameron.seeker

user_mario = User.create({email: "mario.c.delgado@gmail.com", password: "12341234", is_seeker?: true})
user_mario.seeker = Seeker.create({first_name: "Mario", last_name: "Delgado"})
mario = user_mario.seeker


# create company & jobs
user_thumbtack = User.create({email: "hello@thumbtack.com", password: "12341234", is_company?: true})
user_thumbtack.company = Company.create({name: "Thumbtack", crunchbase_path: "/organization/thumbtack"})
thumbtack = user_thumbtack.company

thumbtack_frontend = Job.create({title: "Front-End Developer", location: "San Francisco, CA", category: "Front End",
  description: "Thumbtack's core values are 1) help locally, scale globally, 2) obsess over our customers,
    and 3) improve relentlessly. We look for people who have raw talent and drive, work well with others,
    are motivated to improve, and are personable and intellectually curious. Our engineering team is a lean
    15 people, and supports the larger Thumbtack team of 500. We work in a beautiful office in SoMa, eat
    family-style meals cooked by our in-house chefs, study CS theory together, build robots, brew beer, and
    provide annual stipends for self-improvement. We offer competitive salary and equity along with great
    health insurance and a flexible vacation policy.",
  how_to_apply: "Please contact kthomas @ thumbtack for more information."
})

thumbtack_frontend.skills << [html, css, bootstrap, javascript, jquery, ajax]

thumbtack_backend = Job.create({title: "Back-End Developer", location: "San Francisco, CA", category: "Back End",
  description: "Thumbtack's core values are 1) help locally, scale globally, 2) obsess over our customers,
    and 3) improve relentlessly. We look for people who have raw talent and drive, work well with others,
    are motivated to improve, and are personable and intellectually curious. Our engineering team is a lean
    15 people, and supports the larger Thumbtack team of 500. We work in a beautiful office in SoMa, eat
    family-style meals cooked by our in-house chefs, study CS theory together, build robots, brew beer, and
    provide annual stipends for self-improvement. We offer competitive salary and equity along with great
    health insurance and a flexible vacation policy.",
  how_to_apply: "Please contact kthomas @ thumbtack for more information."
})

thumbtack_backend.skills << [ror, postgres]

thumbtack_ios = Job.create({title: "iOS Developer", location: "San Francisco, CA", category: "Mobile - iOS",
  description: "Thumbtack's core values are 1) help locally, scale globally, 2) obsess over our customers,
    and 3) improve relentlessly. We look for people who have raw talent and drive, work well with others,
    are motivated to improve, and are personable and intellectually curious. Our engineering team is a lean
    15 people, and supports the larger Thumbtack team of 500. We work in a beautiful office in SoMa, eat
    family-style meals cooked by our in-house chefs, study CS theory together, build robots, brew beer, and
    provide annual stipends for self-improvement. We offer competitive salary and equity along with great
    health insurance and a flexible vacation policy.",
  how_to_apply: "Please contact kthomas @ thumbtack for more information."
})

thumbtack_ios.skills << [objective_c, swift]

thumbtack_android = Job.create({title: "Android Developer", location: "San Francisco, CA", category: "Mobile - Android",
  description: "Thumbtack's core values are 1) help locally, scale globally, 2) obsess over our customers,
    and 3) improve relentlessly. We look for people who have raw talent and drive, work well with others,
    are motivated to improve, and are personable and intellectually curious. Our engineering team is a lean
    15 people, and supports the larger Thumbtack team of 500. We work in a beautiful office in SoMa, eat
    family-style meals cooked by our in-house chefs, study CS theory together, build robots, brew beer, and
    provide annual stipends for self-improvement. We offer competitive salary and equity along with great
    health insurance and a flexible vacation policy.",
  how_to_apply: "Please contact kthomas @ thumbtack for more information."
})

thumbtack_android.skills << [java, python]

# associate jobs to company
thumbtack.jobs << [thumbtack_frontend, thumbtack_backend, thumbtack_ios, thumbtack_android]


# create company & jobs
user_ginger_io = User.create({email: "hello@ginger.io", password: "12341234", is_company?: true})
user_ginger_io.company = Company.create({name: "Ginger.io", crunchbase_path: "/organization/ginger-io"})
ginger_io = user_ginger_io.company

ginger_io_android = Job.create({title: "Android Developer", location: "San Francisco, CA", category: "Mobile - Android",
  description: "We come to work each day to revolutionize the way that care is delivered, and we'd love to have you join
    us. Ginger.io is looking for a mobile developer to help drive the consumer and patient experience on Android. Your
    core responsibility would be to work with the rest of the Product team to craft the user experience to enhance the
    patient’s connection with their doctor. Patient experience is at the core of Ginger.io, and you will be working directly
    within the Product team to conceptualize, build, test, release and maintain the Ginger.io Android applications.",
  how_to_apply: "Apply here: http://ginger.io/jobs/signup/15547/mobile-engineer/"
})

ginger_io_android.skills << [android, python, django, javascript]

# associate jobs to company
ginger_io.jobs << [ginger_io_android]


# create company & jobs
user_heap = User.create({email: "hello@heapanalytics.com", password: "12341234", is_company?: true})
user_heap.company = Company.create({name: "Heap", crunchbase_path: "/organization/heap"})
heap = user_heap.company

heap_software_engineer = Job.create({title: "Software Engineer", location: "San Francisco, CA", category: "Full Stack",
  description: "* Data capture. We’re integrating with more clients and frameworks, including Android, AngularJS, and
    Backbone.js, all with virtually no performance overhead or integration cost. * Real-time infrastructure. We support
    an expressive set of queries that allow our users to slice and dice the data in arbitrary ways. The results need to
    come back with sub-second latencies and reflect up-to-the-minute data. * Data visualization. Simple pre-generated
    graphs just don't cut it. There's an enormous number of ways to organize the data. Existing tools only scratch the surface.",
  how_to_apply: "Email us at jobs@heapanalytics.com with reasons as to why you'd make a great fit."
})

heap_software_engineer.skills << [node, redis, postgres, backbone, d3]

# associate jobs to company
heap.jobs << [heap_software_engineer]


# associate (favorite) jobs to seekers
cameron.jobs << [thumbtack_frontend, thumbtack_backend, heap_software_engineer]
mario.jobs << [thumbtack_ios, thumbtack_android, ginger_io_android]