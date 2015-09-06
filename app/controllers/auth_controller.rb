class AuthController < ApplicationController

  def signup
    if current_user
      render json: { errors: "Already have a account", status: :bad_request }
    else
      @user = User.new(auth_params)
      if @user.save
        render json: { token: Token.encode(@user.id) }
      else
        render json: { errors: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    end
  end

  def login
    if current_user
      render json: { errors: "Already logged in", status: :bad_request }
    else
      @user = User.find_by(email: auth_params[:email])
      if @user && @user.authenticate(auth_params[:password])
        render json: { token: Token.encode(@user.id) }
      else
        render json: { errors: "Invalid credentials" }, status: :unauthorized
      end
    end
  end

  def authenticate
    provider = params[:provider].titleize
    @oauth = "Oauth::#{provider}".constantize.new(params)     
    if @oauth.authorized?
      @user = User.from_oauth(@oauth)
      if @user
        render json: { token: Token.encode(@user.id) }
      else
        render json: { errors: "#{provider} account is already in use." }, status: :bad_request
      end
    else
      render json: { errors: "There was an error with #{provider}. Please try again." }, status: :internal_server_error
    end
  end

  private
    def auth_params
      params.require(:auth).permit(:email, :password)
    end

end