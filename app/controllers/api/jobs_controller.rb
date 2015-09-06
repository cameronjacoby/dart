class Api::JobsController < ApplicationController

  def index
    @jobs = Job.order("created_at DESC")
    render json: @jobs
  end

  def show
    @job = Job.find_by(id: params[:id])
    render json: @job
  end

end