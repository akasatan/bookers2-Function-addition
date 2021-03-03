class FavoritesController < ApplicationController
  before_action :ensure_correct_user, only: [:create, :destroy]
  
  def create
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
  end
  
  
  def ensure_correct_user
    @book = Book.find(params[:book_id])
  end
  
end
