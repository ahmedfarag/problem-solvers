class CategoriesController < ApplicationController
  def show
  	@cat = Category.find(params[:id])
  	rel = CategoryRelation.find_all_by_category_id(@cat.id)
  	@categorizables = rel.map{|x| x.categorizable}

  end

  def index
  end

  def create
  	 @cat = Category.new(params[:category])
    
    if @cat.save
      current_user.post("Just added a category named [[#{category_path(@cat)},#{@cat.name}]] ")
      current_user.add_to_score(5)
      flash[:success] = "Your Category was added successfully, +5 points"
      redirect_to @cat
    else
      render 'new'
    end
  end

  def new
  	@category = Category.new
  end
end
