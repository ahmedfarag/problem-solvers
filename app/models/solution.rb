class Solution < ActiveRecord::Base
  belongs_to :language
  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable
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
#

