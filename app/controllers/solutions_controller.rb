class SolutionsController < ApplicationController
  before_filter :signed_in_user, 
                only: [:edit, :update, :create, :new, :destroy] 
  def index
    @solutions = Solution.find_all_by_user_id(current_user.id)
  end

  def show
    @solution = Solution.find(params[:id])
  end

  def new
    @problem = Problem.find(params[:problem_id])
    @solution = Solution.new(user: current_user, problem_id: @problem.id)
    @languages = Language.all
  end

  def create
    @sol = Solution.new(params[:solution])
    @sol.user = current_user
    
    if @sol.save
      current_user.post("Just added a #{@sol.language.name} [[#{solution_path(@sol)},solution]] for [[#{problem_path(@sol.problem)},#{@sol.problem.name}]] problem.")
      current_user.add_to_score(50)
      flash[:success] = "Your Solution was submitted successfully, +50 points ;)"
      redirect_to @sol
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
    @solution.destroy
    current_user.add_to_score(-50)
    flash[:success] = "Your Solution was deleted successfully, -50 points :("
    redirect_to :back
  end

  private

    def correct_user
      @solution = current_user.solutions.find_by_id(params[:id])
      redirect_to root_path if @solution.nil?
    end
end
