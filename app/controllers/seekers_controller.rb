class SeekersController < ApplicationController

  before_action :set_seeker, only: [:show]
  before_action :render_layout_if_html
  respond_to :json, :html

  def show
    respond_to do |format|
      format.json {render :json => @seeker, :include => [:jobs => {:include => {:company => {:only => [:id, :name]}}}]}
    end
  end

  private

    def set_seeker
      @seeker = Seeker.find(params[:id])
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end