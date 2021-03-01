class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #followerが自分がしてるfollowedがされてる
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  has_many :reverse_relationships, class_name: "relationships", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, through: :reverse_relationships, source: :followed
  
  
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def follow(other_user)
    unless self == other_user
    relationships.find_by(follower: other_user)
    end
  end

  def following?(user)
    followers.include?(user)
  end

  def unfollow(other_user)
    relationships.find(follower_id).destroy
  end
end
