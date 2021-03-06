class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  def self.sort_by_avg_rating(list)
  	list.sort do |a, b|
  		b.average_ratings <=> a.average_ratings
  	end
  end
end
# == Schema Information
#
# Table name: reviews
#
#  id              :integer         not null, primary key
#  stars           :integer
#  user_id         :integer
#  reviewable_id   :integer
#  reviewable_type :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

