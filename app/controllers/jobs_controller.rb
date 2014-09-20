class JobsController < ApplicationController

  before_action :render_layout_if_html

  respond_to :json, :html

  def index
    respond_with @jobs = Job.all
  end

  private
    def word_params
      params.require(:word).permit(:name, :description)
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end