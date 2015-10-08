task update_jobs: :environment do
  
  puts "Before update: #{Job.count} jobs"

  html = open("https://news.ycombinator.com/item?id=#{ENV['POST_ID']}")
  page = Nokogiri::HTML(html.read)
  page.encoding = "utf-8"

  UpdateJobsService.new.process_doc page
  
  puts "After update: #{Job.count} jobs"

  not_tagged = Job.select{|job| job.locations.empty? && job.roles.empty?}
  puts "Not tagged: #{not_tagged.count} jobs"

  not_tagged.each do |job|
    puts "********************"
    puts job.title
    puts job.description
    puts "********************"
  end

end