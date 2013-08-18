class CategoryRelationsController < ApplicationController
  def new
    @rel = CategoryRelation.new (params[:categorizable])
    @categories = Category.all
  end

  def create
    @rel = CategoryRelation.new (params[:category_relation])
    
    if @rel.save
      current_user.post("Just added a category named [[#{category_path(@rel.category)},#{@rel.category.name}]] for [[#{problem_path(@rel.categorizable)},#{@rel.categorizable.name}]] problem.")
      current_user.add_to_score(5)
      flash[:success] = "Your category was added successfully, +5 points"
      redirect_to @rel.categorizable
    else
      @categories = Category.all
      render 'new'
    end


  end

end
