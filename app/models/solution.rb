class Solution < ActiveRecord::Base
  # attr_accessible :private, :code, :accepted

  belongs_to :language
  belongs_to :problem
  belongs_to :user

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable

  
  has_many :category_relations, as: :categorizable
  has_many :categories, through: :category_relations
   # returns the average rating of this solution,

  validates :code, presence: true
  validates :language_id, presence: true
  validates :problem_id, presence: true
  validates :user_id, presence: true

  has_many :unlocks, as: :unlockable
  has_many :unlockers, through: :unlocks, source: :user

  has_one :public_link, as: :unlockable
  after_commit :create_public_link

  def create_public_link
    PublicLink.create(unlockable: self) if not PublicLink.exists?(unlockable_id: self, unlockable_type: self.class.to_s)
  end

  def public_url
    Rails.application.routes.url_helpers.public_links_path + "?h=#{public_link.hashed_id}"
  end

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

    unlocked_all_explanations = true
    cur_user.explanations.each do |explanation|
      unlocked_all_explanations = (unlocked_all_explanations and (explanation.unlocked_by?(user_id) or explanation.problem.solved_by?(user_id)))
      break if not unlocked_all_explanations
    end

    if not unlocked_all_hints
      @cannot_unlock_message = "You have to unlock all hints before you can unlock any " + self.class.to_s.downcase
    end

    if not unlocked_all_explanations
      @cannot_unlock_message += ", and y" if not @cannot_unlock_message.empty?
      @cannot_unlock_message +=  (@cannot_unlock_message.empty? ? "Y" : "") + "ou have to unlock all explanations before you can unlock any " + self.class.to_s.downcase
    end

    if(User.find(user_id).points < penalty[:points])
      @cannot_unlock_message += ", and y" if not @cannot_unlock_message.empty?
      @cannot_unlock_message += (@cannot_unlock_message.empty? ? "Y" : "") + "ou don't have enough points (#{penalty[:points]} points) to unlock this #{self.class.to_s.downcase}."
      return false
    end
    unlocked_all_hints and unlocked_all_explanations
  end

  def cannot_unlock_message
    @cannot_unlock_message
  end

  def penalty
    {time: 30, points: 150}
  end

 
end
# == Schema Information
#
# Table name: solutions
#
#  id          :integer         not null, primary key
#  code        :text
#  language_id :integer
#  problem_id  :integer
#  accepted    :boolean
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  private     :boolean
#

