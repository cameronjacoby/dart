class SkillsController < AngularController

  before_action :set_skill, only: [:show]

  def index
    @skills = Skill.all
    respond_to do |format|
      format.json {render :json => @skills.to_json(:include => [:jobs])}
    end
  end

  def show
    respond_to do |format|
      format.json {render :json => @skill, :include => [:jobs => {:include => [:company, :skills]}]}
    end
  end

  private

    def set_skill
      @skill = Skill.find(params[:id])
    end

end