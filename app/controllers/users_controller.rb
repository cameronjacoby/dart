class UsersController < ApplicationController

  before_action :render_layout_if_html
  respond_to :json, :html

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      if User.find_by_email(@user.email)
        render json: 'EMAIL ERROR'
      elsif @user.password.length < 6
        render json: 'PASSWORD LENGTH ERROR'
      elsif @user.password != @user.password_confirmation
       render json: 'PASSWORD CONF ERROR'
      else
        render json: 'ERROR'
      end
    end
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