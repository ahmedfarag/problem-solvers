class OnlineJudge < ActiveRecord::Base
	has_many :problems
end
# == Schema Information
#
# Table name: online_judges
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  link       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  logo       :string(255)
#

