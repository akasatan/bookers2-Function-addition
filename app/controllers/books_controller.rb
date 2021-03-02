class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
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

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
