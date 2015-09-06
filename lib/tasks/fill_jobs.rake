task fill_jobs: :environment do
  puts "Before fill: #{Job.count} jobs"

  html = open("https://news.ycombinator.com/item?id=10152809")
  page = Nokogiri::HTML(html.read)
  page.encoding = "utf-8"

  page.css(".athing").each do |comment|
    if comment.css(".ind img[width='0']").present?
      
      full_text = comment.css(".default .comment .c00")
      title = full_text.text
      reply = full_text.css(".reply").text
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