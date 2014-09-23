class JobsController < AngularController

  before_action :is_authenticated?, only: [:create, :update, :destroy]
  before_action :set_company, only: [:create, :show, :update, :destroy]
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    @jobs = Job.all
    respond_to do |format|
      format.json {render :json => @jobs, :include => [:company, :skills]}
    end
  end

  def create
    if @current_user.company == @company
      @job = @company.jobs.create(job_params)
      skill_params = params.require(:job).permit(:skills)[:skills].split(",").map(&:strip).map(&:downcase)
      skill_params.each do |skill_str|
        skill = Skill.find_or_create_by(name: skill_str)
        @job.skills << skill
      end
      respond_to do |format|
        format.json {render :json => @job}
      end
    else
      render json: {}, status: 403
    end
  end

  def show
    if @company.jobs.include? @job
      @job.increase_clicks
      respond_to do |format|
        format.json {render :json => @job, :include => [:company, :skills]}
      end
    else
      render json: {}, status: 404
    end
  end

  def update
    if @current_user.company == @company
      @job.update(job_params)
      @job.skills.clear
      skill_params = params.require(:job).permit(:skill_names)[:skill_names].split(",").map(&:strip).map(&:downcase)
      skill_params.each do |skill_str|
        skill = Skill.find_or_create_by(name: skill_str)
        @job.skills << skill
      end
      respond_to do |format|
        format.json {render :json => @job, :include => [:skills]}
      end
    else
      render json: {}, status: 403
    end
  end

  def destroy
    if @current_user.company == @company
      respond_with @job.destroy
    else
      render json: {}, status: 403
    end
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

end