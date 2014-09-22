class JobsController < AngularController

  before_action :set_company, only: [:create, :show]
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    @jobs = Job.all
    respond_to do |format|
      format.json {render :json => @jobs.to_json(:include => [:company, :skills])}
    end
  end

  def create
    @job = @company.jobs.create(job_params)
    skill_params = params.require(:job).permit(:skills)[:skills].split(",").map(&:strip).map(&:downcase)
    skill_params.each do |skill_str|
      skill = Skill.find_or_create_by(name: skill_str)
      @job.skills << skill
    end
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
    @job.update(job_params)
    @job.skills.clear
    skill_params = params.require(:job).permit(:skill_names)[:skill_names].split(",").map(&:strip).map(&:downcase)
    skill_params.each do |skill_str|
      skill = Skill.find_or_create_by(name: skill_str)
      @job.skills << skill
    end
    render json: @job
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

end