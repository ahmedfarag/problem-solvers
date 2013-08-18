class Hint < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable

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
# Table name: hints
#
#  id         :integer         not null, primary key
#  content    :text
#  clarity    :integer
#  problem_id :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  title      :string(255)
#

