class Api::LocationsController < ApplicationController

  def index
    @locs = Location.all
    render json: @locs
  end

end