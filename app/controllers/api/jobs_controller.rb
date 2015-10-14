class Api::JobsController < ApplicationController

  def index
    @jobs = Job.active.order("created_at DESC")
    render json: @jobs, except: [:id], include: [:roles, :locations]
  end

  def show
    @job = Job.find_by(guid: params[:id])
    render json: @job, except: [:id], include: [:roles, :locations]
  end

end