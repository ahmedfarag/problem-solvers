class ExplanationsController < ApplicationController
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
      flash[:success] = "Your Explanation was submitted successfully, +100 points"
      redirect_to @exp
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
