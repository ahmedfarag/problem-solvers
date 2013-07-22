class ProblemsController < ApplicationController
  def index
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def new
  end

  def create
  end

  def destroy
  end
end
