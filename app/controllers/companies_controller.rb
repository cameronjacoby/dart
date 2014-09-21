class CompaniesController < ApplicationController

  before_action :set_company, only: [:show]

  before_action :render_layout_if_html

  respond_to :json, :html

  def show
    # @company.profile = @company.get_crunchbase_profile
    # @company.save

    respond_to do |format|
      format.json {render :json => @company, :include => [:jobs => {:include => {:skills => {:only => [:id, :name]}}}]}
    end
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end