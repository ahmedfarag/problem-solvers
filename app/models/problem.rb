class Problem < ActiveRecord::Base

  belongs_to :online_judge
  has_many :solutions
  has_many :explanations
  has_many :hints

  has_many :category_relations, as: :categorizable
  has_many :categories, through: :category_relations


  validates :link, presence:   true, uniqueness: { case_sensitive: false }

  def self.search(search)
  	if search
    	find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  	else
    	find(:all)
  	end
  end
end
# == Schema Information
#
# Table name: problems
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  link            :string(255)
#  online_judge_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

