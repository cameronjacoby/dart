task fill_jobs: :environment do
  include LocationsHelper
  include CategoriesHelper

  puts "Before fill: #{Job.count} jobs"

  html = open("https://news.ycombinator.com/item?id=10152809")
  page = Nokogiri::HTML(html.read)
  page.encoding = "utf-8"

  page.css(".athing").each do |comment|
    # only scrape first-level comments
    if comment.css(".ind img[width='0']").present?

      # html/css for one comment
      comment_body = comment.css(".default .comment .c00")

      # initially set title to full text
      # will slice out description paragraphs
      title = comment_body.text

      # reply text (to remove from title)
      reply = comment_body.css(".reply").text

      # slice out reply from title
      title.slice!(reply)

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
            if matches.match(title) || matches.match(description)
              loc = Location.find_by(slug: slug)
              loc.jobs << job
            end
          end

          category_matches.each do |slug, matches|
            if matches.match(title) || matches.match(description)
              cat = Category.find_by(slug: slug)
              cat.jobs << job
            end
          end
        end
      end
    end
  end

  puts "After fill: #{Job.count} jobs"

end