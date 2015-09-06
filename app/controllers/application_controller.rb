class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies["XSRF-TOKEN"] = form_authenticity_token if protect_against_forgery?
  end

  def current_user
    token = request.headers["Authorization"].to_s.split(" ").last
    return unless token
    payload = Token.new(token)
    @current_user = User.find(payload.user_id) if payload.valid?
  end

  def authorize
    unless current_user
      render json: { errors: "You must be logged in to do that" }, status: :unauthorized
    end
  end

  protected
    def verified_request?
      super || valid_authenticity_token?(session, request.headers["X-XSRF-TOKEN"])
    end

end