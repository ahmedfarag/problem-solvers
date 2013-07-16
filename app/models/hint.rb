class Hint < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable
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
#

