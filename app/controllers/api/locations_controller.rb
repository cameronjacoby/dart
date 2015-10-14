class Api::LocationsController < ApplicationController

  def index
    @locations = Location.all
    render json: @locations, except: [:id]
  end

end