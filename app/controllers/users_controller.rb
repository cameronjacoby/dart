class UsersController < AngularController

  before_action :set_user, only: [:update, :destroy]

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.is_seeker
        @seeker = Seeker.create(seeker_params)
        @user.seeker = @seeker
        render json: @seeker
      elsif @user.is_company
        @company = Company.new(company_params)
        if @company.save
          @company.get_crunchbase_path
          @company.get_crunchbase_profile
          @user.company = @company
          render json: @company
        elsif Company.find_by_name(@company.name)
          respond_to do |format|
            format.json {render :json => {:user => @user, :error => 'NAME ERROR'}}
          end
        else
          respond_to do |format|
            format.json {render :json => {:user => @user, :error => 'ERROR'}}
          end
        end
      end
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

  def update
    found_user = User.find_by_email(user_params[:email])
    if found_user
      if found_user.id == @user.id
        respond_with @user.update_columns(user_params)
      else
        render json: 'EMAIL ERROR'
      end
    else
      respond_with @user.update_columns(user_params)
    end
  end

  def destroy
    respond_with @user.destroy
  end

  def logged_in_user
    render json: current_user, only: [:id, :email]  
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