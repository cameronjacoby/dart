class UsersController < ApplicationController

  before_action :render_layout_if_html
  respond_to :json, :html

  def new
  end

  def create
    render json: User.create(user_params)
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :is_seeker, :is_company)
    end

    def seeker_params
      params.require(:seeker).permit(:first_name, :last_name)
    end

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end