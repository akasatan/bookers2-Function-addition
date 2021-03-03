class BookCommentsController < ApplicationController
  before_action :ensure_correct_user
  before_action :authenticate_user!

  def create
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comments = @book.book_comments
    unless @book_comment.save
      @newbook = Book.new
      render 'error'
    end
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id], book_id: @book)
    @book_comments = @book.book_comments
    if @book_comment.destroy
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id)
  end

  def ensure_correct_user
    @book = Book.find(params[:book_id])
  end

end
