class SessionController < ApplicationController

  before_action :render_layout_if_html
  respond_to :json, :html

  def new
    # if session[:user_id] != nil
    #   redirect_to root_path
    # end
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user 
      respond_with session[:user_id] = @user.id
      # redirect_to user_path(@user.id), :notice => 'Logged in!'
    else
      if User.find_by_email(params[:user][:email]) == nil
        # redirect_to login_path, :alert => 'Account with that email does not exist.'
      elsif User.find_by_email(params[:user][:email]).password != params[:user][:password]
        # redirect_to login_path, :alert => 'Invalid password.'
      else
        # redirect_to login_path, :alert => 'Could not log you in. Please try again.'
      end
    end
  end

  def destroy
    respond_with session[:user_id] = nil
    # redirect_to login_path, :notice => 'Logged out.'
  end


  private

    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end

end