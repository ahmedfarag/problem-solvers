class HintsController < ApplicationController
    before_filter :signed_in_user, 
                only: [:edit, :update, :create, :new, :destroy, :show] 

  before_filter :correct_user,   only: [:edit, :update, :destroy]

  before_filter :unlocked_item, only: [:show]
  
 def new
    @hint = Hint.new(problem_id: params[:problem_id], user_id: current_user.id)
   
  end

  def create
    @hint = Hint.new (params[:hint])
    
    if @hint.save
      current_user.post("Just added a [[#{hint_path(@hint)}&-*^hint]] for [[#{problem_path(@hint.problem)}&-*^#{@hint.problem.name}]] problem.")
      current_user.add_to_score(10)
      flash[:success] = "Your hint was added successfully, +10 points :)"
      redirect_to @hint.problem
    else
       render 'new'
    end


  end

  def show
    @clarity = [ "Doesn't expose a lot from the idea", "Exposes a small part of the idea", "Exposes half the idea", "Exposes more than half the idea, but not all of it",  "Exposes the whole idea"]
    @hint = Hint.find(params[:id])
  end


  def edit

  end

  def update
    if @hint.update_attributes(params[:hint])
      flash[:success] = "The hint was updated successfully"
      redirect_to @hint
    else
      render 'edit'
    end
  end

  
  
  def destroy
    @hint.destroy
    current_user.add_to_score(-10)
    flash[:success] = "Your hint was deleted successfully, -10 points :("
    # redirect_to :back
    redirect_to hints_user_path(current_user)
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    
    def correct_user
      @hint = current_user.hints.find_by_id(params[:id])
      redirect_to root_path if @hint.nil?
    end

    def unlocked_item
      @unlockable = Hint.find(params[:id])
      unless @unlockable.user_id == current_user.id or @unlockable.problem.solved_by?(current_user.id) or @unlockable.unlocked_by?(current_user.id)
        render 'available_times/show'
      end
    end
end
