class ReviewsController < ApplicationController
  def show
  end

  def new
  end

  def create

    @reviewable = eval(params[:review][:reviewable_type]).find(params[:review][:reviewable_id])
    

    if @reviewable.reviews.exists?(user_id: current_user.id)
      @reviewable.reviews.find_by_user_id(current_user.id).destroy
    end
    
    @reviewable.reviews.create(params[:review])
      # flash[:success] = "Thank you for your review, you just recieved 100 points ;)"
    # else
      # flash[:fail] = "oops, somthing prevented your review from being submitted!, please try again" 
    # end 

    respond_to do |format|
      format.html { redirect_to @reviewable}
      format.js 
    end

  end

  def destroy
  end

  def edit
  end

  def update
  end
end
