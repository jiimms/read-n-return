class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :check_session 
  
  def check_session
  	if session[:user_id].blank?
  		flash[:danger] ="Please Login or Sign up to access this page"
  		
  		redirect_to login_path
  	end
  end

end
