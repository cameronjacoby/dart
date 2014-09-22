class JobsController < ApplicationController

  before_action :set_company, only: [:create, :show]
  before_action :set_job, only: [:show, :update, :destroy]
  before_action :render_layout_if_html
  respond_to :json, :html

  def index
    @jobs = Job.all
    respond_to do |format|
      format.json {render :json => @jobs.to_json(:include => [:company, :skills])}
    end
  end

  def create
    @job = @company.jobs.create(job_params)
    render json: @job
  end

  def show
    if @company.jobs.include? @job
      respond_to do |format|
        format.json {render :json => @job.to_json(:include => [:company, :skills])}
      end
    else
      respond_with ''
    end
  end

  def update
    respond_with @job.update(job_params)
  end

  def destroy
    respond_with @job.destroy
  end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :location, :category, :description, :how_to_apply)
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end