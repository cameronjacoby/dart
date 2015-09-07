task fill_jobs: :environment do
  include LocationsHelper

  def category_matches
    {
      # web development
      "back-end" => /\bback end\b|\bback-end\b|\bbackend\b/i,
      "front-end" => /\bfront end\b|\bfront-end\b|\bfrontend\b/i,
      "full-stack" => /\bfull stack\b|\bfull-stack\b|\bfullstack\b/i,

      # mobile development
      "android" => /\bandroid\b/i,
      "ios" => /\bios\b/i,

      # design
      "design" => /\bdesigner\b/i
    }
  end

  puts "Before fill: #{Job.count} jobs"

  html = open("https://news.ycombinator.com/item?id=10152809")
  page = Nokogiri::HTML(html.read)
  page.encoding = "utf-8"

  page.css(".athing").each do |comment|
    # only scrape first-level comments
    if comment.css(".ind img[width='0']").present?

      # html/css for one comment
      comment_body = comment.css(".default .comment .c00")
      
      # full text inside one comment
      full_text = comment_body.text

      # reply text (to remove from full text)
      reply = comment_body.css(".reply").text

      # slice out reply from full text
      full_text.slice!(reply)
      
      # initially set title to full text
      # will slice out description paragraphs
      title = full_text

      # initially set description to empty string
      # will build up with description paragraphs
      description = ""

      # iterate through comment's direct child paragraphs
      # remove from title and add to description
      comment_body.css("> p").each do |paragraph|
        title.slice!(paragraph.text)
        description += "<p>" + paragraph.text + "</p>"
      end

      # check if job exists in db before creating
      unless Job.find_by(title: title)
        job = Job.new(title: title, description: description)

        if job.save
          location_matches.each do |slug, matches|
            if matches.match(full_text)
              loc = Location.find_by(slug: slug)
              loc.jobs << job
            end
          end

          category_matches.each do |slug, matches|
            if matches.match(full_text)
              puts slug
            end
          end
        end
      end
    end
  end

  puts "After fill: #{Job.count} jobs"

end