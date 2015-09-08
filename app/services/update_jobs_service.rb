class UpdateJobsService

  def process_doc html_doc
    html_doc.css(".athing").each do |comment|
      process_comment comment
    end
  end

  private
    def process_comment comment_html
      # only scrape first-level comments
      if comment_html.css(".ind img[width='0']").present?

        # main content for one comment
        comment_content = comment_html.css(".default .comment .c00")

        # initially set title to entire comment content
        # will slice out paragraph text
        title = comment_content.text

        # reply text (to remove from title)
        reply = comment_content.css(".reply").text

        # slice out reply text from title
        title.slice!(reply)

        # initially set description to empty string
        # will build up with paragraph text
        description = ""

        job_attrs = set_job_attrs comment_content, title, description
        find_or_create_job job_attrs
      end
    end

    def set_job_attrs comment_content, title, description
      # iterate through comment's direct child paragraphs
      # remove paragraph text from title and add to description
      comment_content.css("> p").each do |paragraph|
        title.slice!(paragraph.text)
        description += "<p>" + paragraph.text + "</p>"
      end
      { title: title, description: description }
    end

    def find_or_create_job job_attrs
      unless Job.find_by(title: job_attrs[:title])
        job = Job.new(job_attrs)
        if job.save
          find_roles job
          find_locations job
        end
      end
    end

    def find_roles job
      role_matches.each do |slug, matches|
        if matches.match(job.title) || matches.match(job.description)
          role = Role.find_by(slug: slug)
          role.jobs << job
        end
      end
    end

    def find_locations job
      location_matches.each do |slug, matches|
        if matches.match(job.title) || matches.match(job.description)
          loc = Location.find_by(slug: slug)
          loc.jobs << job
        end
      end
    end

end