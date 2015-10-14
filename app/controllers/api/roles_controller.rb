class Api::RolesController < ApplicationController

  def index
    @roles = Role.all
    render json: @roles, except: [:id]
  end

end