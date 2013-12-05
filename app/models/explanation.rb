class Explanation < ActiveRecord::Base
  # attr_accessible :content

  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable

  has_many :unlocks, as: :unlockable
  has_many :unlockers, through: :unlocks, source: :user

  validates :content, presence: true
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

  
  def unlocked_by?(user_id)
    unlockers.exists?(id: user_id)
  end
  
end
# == Schema Information
#
# Table name: explanations
#
#  id         :integer         not null, primary key
#  content    :text
#  problem_id :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

