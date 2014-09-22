class SessionController < AngularController

  def new
    # if session[:user_id] != nil
    #   redirect_to root_path
    # end
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      respond_to do |format|
        format.json {render :json => @user, :only => [:id, :email, :is_seeker, :is_company], :include => [:seeker, :company]}
      end

    else
      render json: "NOT LOGGED IN", status: 400
    end
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
    session[:user_id] = nil
    respond_with nil
  end

end