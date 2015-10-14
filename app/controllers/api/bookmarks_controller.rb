class Api::BookmarksController < ApplicationController
  before_filter :authorize

  def create
    @job = Job.find_by(guid: bookmark_params[:job_guid])
    if @job && !current_user.jobs.include?(@job)
      @bookmark = current_user.bookmarks.new(job_id: @job.id)
      if @bookmark.save
        render json: @bookmark
      else
        render json: {}
      end
    else
      render json: {}
    end
  end

  private
    def bookmark_params
      params.require(:bookmark).permit(:job_guid)
    end

end