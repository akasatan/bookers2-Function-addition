class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #userﾃｰﾌﾞﾙ→relationﾃｰﾌﾞﾙ、follower_idをviewに送る（参照）
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #relationﾃｰﾌﾞﾙ→followedﾃｰﾌﾞﾙ、followed_idを送る（受け渡し）
  has_many :followings, through: :relationships, source: :followed
  
  #followerﾃｰﾌﾞﾙ(本当はuser)→re_relationﾃｰﾌﾞﾙ(本当relation)へfollowed_idを送る(参照）
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #re_relationﾃｰﾌﾞﾙ→userﾃｰﾌﾞﾙへfollower_idを送る（受け渡し）
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
  
  attachment :profile_image, destroy: false
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
    
  def User.search(content, method)
    if method == "perfect"
      User.where(['name LIKE ?', "#{content}"])
    elsif method == "forward"
      User.where(['name LIKE ?', "#{content}%"])
    elsif method == "backward"
      User.where(['name LIKE ?', "%#{content}"])
    elsif method == "part"
      User.where(['name LIKE ?', "%#{content}%"])
    else    
      User.all
    end
  end
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
end
