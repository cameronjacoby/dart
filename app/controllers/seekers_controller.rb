class SeekersController < AngularController

  before_action :is_authenticated?
  before_action :set_seeker, only: [:show, :update, :favorite]
  before_action :set_job, only: [:favorite]

  def show
    if @current_user.seeker == @seeker
      respond_to do |format|
        format.json {render :json => @seeker, :include => [:user, :jobs => {:include => {:company => {:only => [:id, :name]}}}]}
      end
    else
      render json: {}, status: 403
    end
  end

  def update
    if @current_user.seeker == @seeker
      respond_with @seeker.update(seeker_params)
    else
      render json: {}, status: 403
    end
  end

  def favorite
    if @current_user.seeker == @seeker
      respond_with @seeker.add_favorite @job
    else
      render json: {}, status: 403
    end
  end

  private

    def seeker_params
      params.require(:seeker).permit(:first_name, :last_name)
    end

    def set_seeker
      @seeker = Seeker.find(params[:id])
    end

    def set_job
      @job = Job.find(params[:job_id])
    end

end