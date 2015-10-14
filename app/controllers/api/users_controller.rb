class Api::UsersController < ApplicationController

  def current
    render json: current_user, except: [:id, :password_digest], include: [jobs: {except: :id}]
  end

end