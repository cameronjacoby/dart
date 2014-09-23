class UsersController < AngularController

  before_action :is_authenticated?, only: [:update, :destroy]
  before_action :set_user, only: [:update, :destroy]

  def new
  end

  def create
    if session[:user_id] == nil
      @user = User.new(user_params)
      if @user.save
        if @user.is_seeker
          @seeker = Seeker.create(seeker_params)
          @user.seeker = @seeker
          respond_to do |format|
            format.json {render :json => @seeker}
          end

        elsif @user.is_company
          @company = Company.new(company_params)
          if @company.save
            @company.get_crunchbase_path
            @company.get_crunchbase_profile
            @user.company = @company
            respond_to do |format|
              format.json {render :json => @company}
            end

          elsif Company.find_by_name(@company.name)
            respond_to do |format|
              format.json {render :json => {:user_id => @user.id, :error => 'COMPANY NAME ERROR'}, status: 400}
            end
          else
            render json: 'COMPANY ERROR', status: 400
          end
        end

      else
        if User.find_by_email(@user.email)
          render json: 'EMAIL ERROR', status: 400
        elsif @user.password.length < 6
          render json: 'PASSWORD LENGTH ERROR', status: 400
        elsif @user.password != @user.password_confirmation
          render json: 'PASSWORD CONF ERROR', status: 400
        else
          render json: 'ERROR', status: 400
        end
      end
    else
      render json: {}, status: 403
    end
  end


  def update
    if @current_user == @user
      found_user = User.find_by_email(user_params[:email])
      if found_user
        if found_user.id == @user.id
          respond_with @user.update_columns(user_params)
        else
          render json: 'EMAIL ERROR', status: 400
        end
      else
        respond_with @user.update_columns(user_params)
      end
    else
      render json: {}, status: 403
    end
  end


  def destroy
    if @current_user == @user
      respond_with @user.destroy
    else
      render json: {}, status: 403
    end
  end


  def logged_in_user
    respond_to do |format|
      format.json {render :json => current_user, :only => [:id, :email, :is_seeker, :is_company], :include => [:seeker, :company]}
    end
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :is_seeker, :is_company)
    end

    def seeker_params
      params.require(:seeker).permit(:first_name, :last_name)
    end

    def company_params
      params.require(:company).permit(:name)
    end

end