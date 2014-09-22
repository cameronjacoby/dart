class SessionController < AngularController

  def new
    # if session[:user_id] != nil
    #   redirect_to root_path
    # end
  end

  def create
    #@session = {}
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      render json: @user, only: [:id, :email]
    else
      render json: 'NOT LOGGED IN', status: 400
    end
    # if @user 
    #   respond_with session[:user_id] = @user.id
    #   # redirect_to user_path(@user.id), :notice => 'Logged in!'
    # else
    #   if User.find_by_email(params[:user][:email]) == nil
    #     # redirect_to login_path, :alert => 'Account with that email does not exist.'
    #   elsif User.find_by_email(params[:user][:email]).password != params[:user][:password]
    #     # redirect_to login_path, :alert => 'Invalid password.'
    #   else
    #     # redirect_to login_path, :alert => 'Could not log you in. Please try again.'
    #   end
    # end
  end

  def destroy
    puts "Destroying Session"
    session[:user_id] = nil
    respond_with nil
    # redirect_to login_path, :notice => 'Logged out.'
  end

end