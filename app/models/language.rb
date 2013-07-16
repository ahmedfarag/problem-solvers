class Language < ActiveRecord::Base
	has_many :solutions
end
# == Schema Information
#
# Table name: languages
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  logo       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

