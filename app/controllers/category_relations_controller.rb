class CategoryRelationsController < ApplicationController
  def new
    @rel = CategoryRelation.new (params[:categorizable])
    @categories = Category.all
  end

  def create
    @rel = CategoryRelation.new (params[:category_relation])
    @rel.user_id = current_user.id
    if @rel.save
      current_user.post("Just added a category named [[#{category_path(@rel.category)}&-*^#{@rel.category.name}]] for [[#{problem_path(@rel.categorizable)}&-*^#{@rel.categorizable.name}]] problem.")
      current_user.add_to_score(5)
      flash[:success] = "Your category was added successfully, +5 points"
      redirect_to @rel.categorizable
    else
      @categories = Category.all
      render 'new'
    end


  end

  before_filter :correct_user,   only: :destroy

  def destroy
    @rel.destroy
    current_user.add_to_score(-5)
    flash[:success] = "Your Category was deleted successfully, -5 points :("
    redirect_to :back
  end

  private

    def correct_user
      @rel = current_user.category_relations.find_by_id(params[:id])
      redirect_to root_path if @rel.nil?
    end

end
