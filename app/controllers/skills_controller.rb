class SkillsController < ApplicationController

  before_action :set_skill, only: [:show]
  before_action :render_layout_if_html
  respond_to :json, :html

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

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end