class AvailableTime < ActiveRecord::Base
  belongs_to :user
end
# == Schema Information
#
# Table name: available_times
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  time       :datetime
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

