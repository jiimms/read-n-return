class StaticPagesController < ApplicationController
	skip_before_action :check_session, :only => [:inventory, :home]
  def home
  end

  def inventory
  end

  def page
  end
end
