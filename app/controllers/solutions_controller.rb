class SolutionsController < ApplicationController
  before_filter :signed_in_user, 
                only: [:edit, :update, :create, :new, :destroy] 
  def index
  end

  def show
    @solution = Solution.find(params[:id])
  end

  def new
    @solution = Solution.new(user: current_user)
    @problems = Problem.all
    @languages = Language.all
  end

  def create
    @sol = Solution.new(params[:solution])
    @sol.user = current_user
    
    if @sol.save
      current_user.post("Just added a #{@sol.language.name} [[#{solution_path(@sol)},solution]] for [[#{problem_path(@sol.problem)},#{@sol.problem.name}]] problem.")
      flash[:success] = "Your Solution was submitted successfully"
      redirect_to @sol
    else
      render 'new'
    end


  end

  def destroy
  end

  def edit
  end

  def update
  end
end
