class Category < ActiveRecord::Base
	has_many :category_relations
	has_many :categorizables, through: :category_relations
end
# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

