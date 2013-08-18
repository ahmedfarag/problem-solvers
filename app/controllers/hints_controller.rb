class HintsController < ApplicationController
 def new
    @hint = Hint.new(problem_id: params[:problem_id], user_id: current_user.id)
   
  end

  def create
    @hint = Hint.new (params[:hint])
    
    if @hint.save
      current_user.post("Just added a [[#{hint_path(@hint)},hint]] for [[#{problem_path(@hint.problem)},#{@hint.problem.name}]] problem.")
      current_user.add_to_score(10)
      flash[:success] = "Your hint was added successfully, +10 points"
      redirect_to @hint.problem
    else
       render 'new'
    end


  end

  def show
    @hint = Hint.find(params[:id])
  end

  def destroy
  end


  def edit
  end

  def update
  end
end
