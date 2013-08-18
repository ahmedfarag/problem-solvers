class Score < ActiveRecord::Base
  belongs_to :user
end
# == Schema Information
#
# Table name: scores
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  points     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

