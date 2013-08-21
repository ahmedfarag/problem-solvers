class ExplanationsController < ApplicationController
 before_filter :signed_in_user, 
                only: [:edit, :update, :create, :new, :destroy] 
  
                
  def index
    @explanations = Explanation.all
  end

  def show
    @explanation = Explanation.find(params[:id])
  end

  def new
    @problem = Problem.find(params[:problem_id])
    @explanation = @problem.explanations.build(user_id: current_user.id)
  end

  def create
    @exp = Explanation.new(params[:explanation])
    @exp.user = current_user
    
    if @exp.save
      current_user.post("Just added an [[#{explanation_path(@exp)},explanation]] for [[#{problem_path(@exp.problem)},#{@exp.problem.name}]] problem.")
      current_user.add_to_score(100)
      flash[:success] = "Your Explanation was submitted successfully, +100 points ;)"
      redirect_to @exp
    else
      render 'new'
    end

  end

  

  def edit
  end

  def update
  end

  before_filter :correct_user,   only: :destroy

  def destroy
    @explanation.destroy
    current_user.add_to_score(-100)
    flash[:success] = "Your Explanation was deleted successfully, -100 points :("
    redirect_to :back
  end

  private

    def correct_user
      @explanation = current_user.explanations.find_by_id(params[:id])
      redirect_to root_path if @explanation.nil?
    end
end
