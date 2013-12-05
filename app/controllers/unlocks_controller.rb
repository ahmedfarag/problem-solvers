class UnlocksController < ApplicationController

  before_filter :signed_in_user, only: [:create]


  def create
  	if current_user.can_take_action?
	  	lock = Unlock.new(params[:unlock])
	  	current_user.unlock(lock.unlockable)
	  	flash[:success] = "You have successfully unlocked it"
	  	redirect_to lock.unlockable
    else
    	flash[:fail] = "You have to wait until you are allowed to perform more actions check '/state' for more details"
    	redirect_to root_path
    end
  end

  private
	  def signed_in_user
		  unless signed_in?
		    store_location
		    redirect_to signin_path, notice: "Please sign in."
		  end
	  end
end
