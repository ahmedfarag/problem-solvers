class PublicLink < ActiveRecord::Base
  belongs_to :unlockable, polymorphic: true

  before_save :create_random_hash

  private
  	def create_random_hash
  		rand = SecureRandom.urlsafe_base64
  		
  		while(PublicLink.exists?(hashed_id: rand))
  			rand = SecureRandom.urlsafe_base64
  		end

  		self.hashed_id = rand
  	end
end
# == Schema Information
#
# Table name: public_links
#
#  id              :integer         not null, primary key
#  unlockable_id   :integer
#  unlockable_type :string(255)
#  hashed_id       :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

