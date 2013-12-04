class Unlock < ActiveRecord::Base
  belongs_to :user
  belongs_to :unlockable, polymorphic: true
end
