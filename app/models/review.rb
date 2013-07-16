class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true
end
# == Schema Information
#
# Table name: reviews
#
#  id              :integer         not null, primary key
#  stars           :integer
#  content         :text
#  user_id         :integer
#  reviewable_id   :integer
#  reviewable_type :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

