class AvailableTimesController < ApplicationController

  before_filter :signed_in_user, only: [:show]

  def show
  	# @available_time = @AvailableTime.find(params[:id])
  	# # @unlockable = Unlock
  	
  end


  private
	  def signed_in_user
		  unless signed_in?
		    store_location
		    redirect_to signin_path, notice: "Please sign in."
		  end
	  end
end
