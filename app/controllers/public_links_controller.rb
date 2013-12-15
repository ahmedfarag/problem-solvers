class PublicLinksController < ApplicationController
  def show
  	pl = PublicLink.find_by_hashed_id(params[:h])
  	if pl.nil?
  		flash[:fail] = "The public link that you provided is invalid"
  		redirect_to root_path
  		return false
  	end
  	unlockable = pl.unlockable
  	@clarity = [ "Doesn't expose a lot from the idea", "Exposes a small part of the idea", "Exposes half the idea", "Exposes more than half the idea, but not all of it",  "Exposes the whole idea"]
  	eval("@#{unlockable.class.to_s.downcase} = unlockable")
  	render "#{unlockable.class.to_s.downcase}s/show"
  end
end
