class UnlocksController < ApplicationController
  def create
  	lock = Unlock.new(params[:unlock])
  	current_user.unlock(lock.unlockable)
  	flash[:success] = "You have successfully unlocked it"
  	redirect_to lock.unlockable
  end
end
