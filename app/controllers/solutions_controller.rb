class SolutionsController < ApplicationController
  before_filter :signed_in_user, 
                only: [:edit, :update, :create, :new, :destroy] 

  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  before_filter :unlocked_item, only: [:show]

  def index
    @solutions = Solution.find_all_by_user_id(current_user.id)
  end

  def show
    @solution = Solution.find(params[:id])

    if(@solution.private)
      redirect_to(root_path , notice: "You are not allowed to view this code!") unless current_user?(@solution.user)
    end
  end

  def new
    @problem = Problem.find(params[:problem_id])
    @solution = Solution.new(user: current_user, problem_id: @problem.id)
    @languages = Language.all
  end

  def create
    @solution = Solution.new(params[:solution])
    @solution.user = current_user
    
    if @solution.save
      current_user.post("Just added a #{@solution.language.name} [[#{solution_path(@solution)}&-*^solution]] for [[#{problem_path(@solution.problem)}&-*^#{@solution.problem.name}]] problem.")
      current_user.add_to_score(50) unless @solution.private
      flash[:success] = "Your Solution was submitted successfully"
      flash[:success] += ", +50 points ;)" unless @solution.private
      flash[:success] += "  ... you may consider explaining the problem (+100), giving hints (+10), adding categories (+5)" if @solution.accepted
      redirect_to solution_path(@solution)
    else
      @problem = @solution.problem
      @languages = Language.all
      render 'new'
    end


  end

  

  def edit
    @problem = @solution.problem
    @languages = Language.all
  end

  def update
    was_private = @solution.private;
    

    if @solution.update_attributes(params[:solution])
      if(was_private && !@solution.private)
        current_user.add_to_score(50)
        flash[:success] = "solution updated, you recieved 50 points for making it public ;)"
      elsif(!was_private && @solution.private)
        current_user.add_to_score(-50)
        flash[:success] = "solution updated, you lost 50 points for making it private :("
      else
        flash[:success] = "solution updated"
      end

      redirect_to @solution
    else
      render 'edit'
    end
  end

  
  def destroy
    flash[:success] = "Your Solution was deleted successfully"
    current_user.add_to_score(-50) unless @solution.private
    flash[:success] += ", -50 points :(" unless @solution.private
    sol_path = solution_path(@solution)
    @solution.destroy
    
    # if request.env['HTTP_REFERER'] and request.env['HTTP_REFERER'] != sol_path
    #   redirect_to :back
    # else
    #   redirect_to root_path
    # end
    redirect_to solutions_user_path(current_user)
    # redirect_to request.env['HTTP_REFERER'] == sol_path ? root_path : :back
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @solution = current_user.solutions.find_by_id(params[:id])
      redirect_to root_path if @solution.nil?
    end

    def unlocked_item
      @unlockable = Solution.find(params[:id])
      unless @unlockable.private or @unlockable.user_id == current_user.id or @unlockable.problem.solved_by?(current_user.id) or @unlockable.unlocked_by?(current_user.id)
        render 'available_times/show'
      end
    end
end
