task update_jobs: :environment do

  update_jobs_service = UpdateJobsService.new
  update_jobs_service.clean_data
  
  puts "Before update: #{Job.active.count} active jobs"

  html = open("https://news.ycombinator.com/item?id=#{ENV['HN_POST_ID']}")
  page = Nokogiri::HTML(html.read)
  page.encoding = "utf-8"
  update_jobs_service.process_doc page
  
  puts "After update: #{Job.active.count} active jobs"

  not_tagged = Job.active.select{|job| job.locations.empty? && job.roles.empty?}
  puts "Not tagged: #{not_tagged.count} active jobs"

  not_tagged.each do |job|
    puts "********************"
    puts job.title
    puts job.description
    puts "********************"
  end

end