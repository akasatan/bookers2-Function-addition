class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def Book.search(search, user_or_book, search_option)
    if search_option == "1"
      Book.where(['title LIKE ?', "#{search}"])
    elsif search_option == "2"
      Book.where(['title LIKE ?', "#{search}%"])
    elsif search_option == "3"
      Book.where(['title LIKE ?', "%#{search}"])
    elsif search_option == "4"
      Book.where(['title LIKE ?', "%#{search}%"])
    else    
      Book.all
    end
  end
  
end
