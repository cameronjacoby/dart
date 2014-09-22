class SeekersController < AngularController

  before_action :set_seeker, only: [:show, :update]

  def show
    respond_to do |format|
      format.json {render :json => @seeker, :include => [:user, :jobs => {:include => {:company => {:only => [:id, :name]}}}]}
    end
  end

  def update
    respond_with @seeker.update(seeker_params)
  end

  private

    def seeker_params
      params.require(:seeker).permit(:first_name, :last_name)
    end

    def set_seeker
      @seeker = Seeker.find(params[:id])
    end

end