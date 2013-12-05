class Unlock < ActiveRecord::Base
  belongs_to :user
  belongs_to :unlockable, polymorphic: true
end
# == Schema Information
#
# Table name: unlocks
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  unlockable_id   :integer
#  unlockable_type :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

