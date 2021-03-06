# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base


  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  ##############
  has_many :solutions
  has_many :explanations
  has_many :hints
  has_many :reviews
  has_many :comments
  has_many :category_relations
  has_many :unlocks

  has_one :score
  has_one :available_time
  ##############
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def post(post)
    microposts.create(content: post)
  end

  def add_to_score(points)
    if(score)
      s = score
      s.points += points
      s.save 
    else
      Score.create(:points => points, user_id: id)
    end
  end

  def has_points(points)
    if(!score)
      return false
    end

    return score.points >= points
  end

  def points()
    if(!score)
      return 0
    end

    return score.points
  end

  def can_take_action?()
    if !available_time
      return true
    end

    return available_time.time <= Time.now
  end


  def just_made_an_action(penalty_in_minutes)
    if available_time
      t = available_time
      t.time = Time.now + penalty_in_minutes * 60
      t.save
    else
      AvailableTime.create(time: (Time.now + penalty_in_minutes * 60), user_id: id)
    end
  end

  def unlock(unlockable)
    unlocks.create(unlockable: unlockable)
    penalty = unlockable.penalty
    add_to_score(-penalty[:points])
    just_made_an_action(penalty[:time])
  end

  def public_solutions
    solutions.select { |s| !s.private}  
  end
  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
