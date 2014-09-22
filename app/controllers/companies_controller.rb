class CompaniesController < AngularController

  before_action :set_company, only: [:show, :update]

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

end