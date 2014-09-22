class CompaniesController < ApplicationController

  before_action :set_company, only: [:show, :update]
  before_action :render_layout_if_html
  respond_to :json, :html

  def show
    respond_to do |format|
      format.json {render :json => @company, :include => [:user, :jobs => {:include => {:skills => {:only => [:id, :name]}}}]}
    end
  end

  def update
    found_company = Company.find_by_name(company_params[:name])
    if found_company
      if found_company.id == @company.id
        respond_with @company.update(company_params)
      else
        render json: 'NAME ERROR'
      end
    else
      respond_with @company.update(company_params)
    end
  end

  private

    def company_params
      params.require(:company).permit(:name)
    end

    def set_company
      @company = Company.find(params[:id])
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end