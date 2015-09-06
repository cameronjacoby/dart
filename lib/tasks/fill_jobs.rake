task fill_jobs: :environment do
  puts "Before fill: #{Job.count} jobs"

  url = "https://news.ycombinator.com/item?id=10152809"
  page = Nokogiri::HTML(open(url))

  page.css(".athing").each do |comment|
    if comment.css(".ind img[width='0']").present?
      
      full_text = comment.css(".default .comment .c00")
      reply = full_text.css(".reply").text
      title = full_text.text
      title.slice!(reply)
      description = ""

      full_text.css("> p").each do |paragraph|
        title.slice!(paragraph.text)
        description += "<p>" + paragraph.text + "</p>"
      end

      unless Job.find_by(title: title)
        Job.create(title: title, description: description)
      end
    end
  end

  puts "After fill: #{Job.count} jobs"

end