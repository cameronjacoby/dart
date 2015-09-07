task update_jobs: :environment do
  include LocationsHelper
  include CategoriesHelper

  puts "Before update: #{Job.count} jobs"

  html = open("https://news.ycombinator.com/item?id=10152809")
  page = Nokogiri::HTML(html.read)
  page.encoding = "utf-8"

  UpdateJobsService.new.process_doc page

  puts "After update: #{Job.count} jobs"

end