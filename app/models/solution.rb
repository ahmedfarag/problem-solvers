class Solution < ActiveRecord::Base
  # attr_accessible :private, :code, :accepted

  belongs_to :language
  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable

  
  has_many :category_relations, as: :categorizable
  has_many :categories, through: :category_relations
   # returns the average rating of this solution,

  validates :code, presence: true
  validates :language_id, presence: true
  validates :problem_id, presence: true
  validates :user_id, presence: true

  def average_ratings
  	sum = 0
  	
    reviews.each do |rat|
  		sum += rat.stars.to_i
  	end

  	avg = 0
  	n = reviews.count
  	avg = (sum/n.to_f).round if(n != 0)
  	avg
  end

 
end
# == Schema Information
#
# Table name: solutions
#
#  id          :integer         not null, primary key
#  code        :text
#  language_id :integer
#  problem_id  :integer
#  accepted    :boolean
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  private     :boolean
#

