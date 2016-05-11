class UsersController < ApplicationController
  skip_before_action :check_session, :only => [:new, :create, :log_in]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: :destroy
  def new
  	@user = User.new
    @count= User.count
  end

  def index
    @users = User.paginate(page: params[:page]) 
  end


  def show
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] ="Welcome to the Bookshop!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        flash[:danger] ="You are not authorised to view or update this page"
        redirect_to root_url
      end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

    private

      def user_params
       params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
      end

      # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
