class Api::BookmarksController < ApplicationController
  before_filter :authorize

  def create
    @job = Job.find_by(guid: bookmark_params[:job_guid])
    if @job && !current_user.jobs.include?(@job)
      @bookmark = current_user.bookmarks.new(job_id: @job.id)
      if @bookmark.save
        render json: @bookmark
      else
        render nothing: true
      end
    else
      render nothing: true
    end
  end

  def destroy
    @job = Job.find_by(guid: destroy_bookmark_params[:job_guid])
    if @job && current_user.jobs.include?(@job)
      @bookmark = current_user.bookmarks.find_by(job_id: @job.id)
      @bookmark.destroy
      render json: @bookmark
    else
      render nothing: true
    end
  end

  private
    def bookmark_params
      params.require(:bookmark).permit(:job_guid)
    end

    def destroy_bookmark_params
      JSON.parse(params[:bookmark], symbolize_names: true)
    end

end