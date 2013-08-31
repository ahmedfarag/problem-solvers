class ProblemsController < ApplicationController
  include ProblemsHelper
  require 'will_paginate/array'

  def index
    @problems = Problem.search(params[:search])
    @problems = @problems.paginate(:page => params[:page], :per_page => 25)
    @title = params[:search] == nil ? "All Problems" : "Search results for #{params[:search]}"
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def new
  end

  def create
      link = params[:link]
      link += "&Itemid=" + params[:Itemid] if params[:Itemid] != nil
      link += "&category=" + params[:category] if params[:category] != nil
      link += "&page=" + params[:page] if params[:page] != nil
      link += "&problem=" + params[:problem] if params[:problem] != nil
    @problem = Problem.find_by_link(link);
    if(@problem == nil)

     

      name = get_name_of(link,params[:oj])
      puts name
      oj_id =  OnlineJudge.find_by_name(params[:oj]).id
      # "Itemid"=>"8", "category"=>"286", "page"=>"show_problem", "problem"=>"3270\"
      @problem = Problem.new(link: link, online_judge_id: oj_id, name: name)
      if !@problem.save
        render "problems/problem_save_error", :layout => false
        return
      end
    end
    render "problems/problem_save_success", :layout => false
  end

  def destroy
  end

  def explanations
   
    @problem = Problem.find(params[:id])
     @title = "Explanations for " 
    @data = @problem.explanations.paginate(page: params[:page])
    render 'show_data'
  end

  def hints
    @problem = Problem.find(params[:id])
    @title = "Hints for "
    @data = @problem.hints.paginate(page: params[:page])
    render 'show_data'
  end

  def solutions
    @problem = Problem.find(params[:id])
    @title = "Solutions for "
    @data = @problem.solutions.paginate(page: params[:page])
    render 'show_data'
  end

  def categories
    @problem = Problem.find(params[:id])
    @title = "Categories for "
    @data = @problem.category_relations.paginate(page: params[:page])
    render 'show_data'
  end
end
