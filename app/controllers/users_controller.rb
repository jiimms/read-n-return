class UsersController < ApplicationController
  skip_before_action :check_session, :only => [:new, :create, :log_in]
  def new
  	@user = User.new
    @count= User.count
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
