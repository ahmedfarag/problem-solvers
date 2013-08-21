class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end

  def hall_of_fame
    @users = User.all
    
    
    @most_solvers = @users.sort_by{|u| -u.solutions.count}.first 5

   
    @most_explainers =  @users.sort_by{|u| -u.explanations.count}.first 5

    
    @most_hinters = @users.sort_by{|u| -u.hints.count}.first 5

    
    @most_points = @users.sort_by{|u| -u.points}.first 5


  end

  def chrome_extension

  end
end
