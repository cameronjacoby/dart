class JobsController < ApplicationController

  before_action :set_company, :set_job, only: [:show]

  before_action :render_layout_if_html

  respond_to :json, :html

  def index
    respond_with @jobs = Job.all
  end

  def show
    if @company.jobs.include? @job
      respond_with @job
    else
      respond_with ''
    end
  end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_job
      @job = Job.find(params[:id])
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end