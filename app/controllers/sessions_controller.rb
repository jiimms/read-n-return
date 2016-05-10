class SessionsController < ApplicationController
  skip_before_action :check_session, :only => [:new, :create, :log_in]
  def new
  end

  def create
  	user =User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_to user
  	else
      flash[:danger] ="Invalid email or password"
      redirect_to login_path
      #flash disappears after one request but render is not considered 
      #a request so flash persists. solution is flash.now
      #flash.now[:danger] = 'Invalid email/password combination'
  		# render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
