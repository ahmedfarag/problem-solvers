class CategoryRelation < ActiveRecord::Base
	belongs_to :user
  	belongs_to :category
  	belongs_to :categorizable, polymorphic: true

  	validates_uniqueness_of :category_id, scope: [:categorizable_id, :categorizable_type ]

end
# == Schema Information
#
# Table name: category_relations
#
#  id                 :integer         not null, primary key
#  category_id        :integer
#  categorizable_id   :integer
#  categorizable_type :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

