class ExplanationsController < ApplicationController
 before_filter :signed_in_user, 
                only: [:edit, :update, :create, :new, :destroy] 

  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  before_filter :unlocked_item, only: [:show]
                
  def index
    @explanations = Explanation.all
  end

  def show
    @explanation = Explanation.find(params[:id])
  end

  def new
    @problem = Problem.find(params[:problem_id])
    @explanation = @problem.unsorted_explanations.build(user_id: current_user.id)
  end

  def create
    @explanation = Explanation.new(params[:explanation])
    @explanation.user = current_user
    
    if @explanation.save
      current_user.post("Just added an [[#{explanation_path(@explanation)}&-*^explanation]] for [[#{problem_path(@explanation.problem)}&-*^#{@explanation.problem.name}]] problem.")
      current_user.add_to_score(100)
      flash[:success] = "Your Explanation was submitted successfully, +100 points ;)"
      redirect_to @explanation
    else
      @problem = @explanation.problem
      render 'new'
    end

  end

  

  def edit
    @problem = @explanation.problem
  end

  def update
    if @explanation.update_attributes(params[:explanation])
      flash[:success] = "The explanation was updated successfully"
      redirect_to @explanation
    else
      render 'edit'
    end
  end

  def destroy
    @explanation.destroy
    current_user.add_to_score(-100)
    flash[:success] = "Your explanation was deleted successfully, -100 points :("
    # redirect_to :back
    redirect_to explanations_user_path(current_user)
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @explanation = current_user.explanations.find_by_id(params[:id])
      redirect_to root_path if @explanation.nil?
    end

    def unlocked_item
      @unlockable = Explanation.find(params[:id])
      unless @unlockable.user_id == current_user.id or @unlockable.problem.solved_by?(current_user.id) or @unlockable.unlocked_by?(current_user.id)
        render 'available_times/show'
      end
    end
end
