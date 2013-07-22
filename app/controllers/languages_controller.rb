class LanguagesController < ApplicationController
  def index
  	@languages = Language.all
  end

  def new
  end

  def create
  end

  def destroy
  end
end
