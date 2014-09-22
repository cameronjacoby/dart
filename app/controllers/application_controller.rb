class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_authenticated?
    # redirect_to login_url unless current_user
    render json: 'ERROR' unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    if @current_user.is_seeker
      @current_seeker = @current_user.seeker
    elsif @current_user.is_company
      @current_company = @current_user.company
    end
  end

end