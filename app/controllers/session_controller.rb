class SessionController < AngularController

  def new
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      respond_to do |format|
        format.json {render :json => @user, :only => [:id, :email, :is_seeker, :is_company], :include => [:seeker, :company]}
      end
    else
      if User.find_by_email(params[:user][:email]) == nil
        render json: 'EMAIL NOT FOUND', status: 400
        # 'Account with that email does not exist.'
      elsif User.find_by_email(params[:user][:email]).password != params[:user][:password]
        render json: 'INVALID PASSWORD', status: 400
        # 'Invalid password.'
      else
        render json: 'ERROR', status: 400
        # 'Could not log you in. Please try again.'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    respond_with nil
  end

end