class Explanation < ActiveRecord::Base
  # attr_accessible :content

  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable

  has_many :unlocks, as: :unlockable
  has_many :unlockers, through: :unlocks, source: :user

  validates :content, presence: true
  validates :problem_id, presence: true
  validates :user_id, presence: true
  
   @cannot_unlock_message = ""

  def average_ratings
  	sum = 0
  	reviews.each do |rat|
  		sum += rat.stars.to_i
  	end

  	avg = 0
  	n = reviews.count
  	avg = (sum/n.to_f).round if(n != 0)
  	avg
  end

  
  def unlocked_by?(user_id)
    unlockers.exists?(id: user_id)
  end

  def can_be_unlocked_by?(user_id)
    @cannot_unlock_message = ""

    unlocked_all_hints = true
    cur_user = User.find(user_id)
    cur_user.hints.each do |hint|
      unlocked_all_hints = (unlocked_all_hints and (hint.unlocked_by?(user_id) or hint.problem.solved_by?(user_id)))
      break if not unlocked_all_hints
    end

    if not unlocked_all_hints
      @cannot_unlock_message = "You have to unlock all hints before you can unlock any " + self.class.to_s.downcase
    end

    if(User.find(user_id).points < penalty[:points])
      @cannot_unlock_message += ", and y" if not @cannot_unlock_message.empty?
      @cannot_unlock_message += (@cannot_unlock_message.empty? ? "Y" : "") + "ou don't have enough points (#{penalty[:points]} points) to unlock this #{self.class.to_s.downcase}."
      return false
    end
    unlocked_all_hints
  end

  def cannot_unlock_message
    @cannot_unlock_message
  end

  def penalty
    {time: 20, points: 100}
  end

  def available_for?(user_id)
      unless self.user_id == user_id or self.problem.solved_by?(user_id) or self.unlocked_by?(user_id)
        return false
      end
      true
  end
  
end
# == Schema Information
#
# Table name: explanations
#
#  id         :integer         not null, primary key
#  content    :text
#  problem_id :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

