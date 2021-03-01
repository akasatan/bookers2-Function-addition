class BookCommentsController < ApplicationController
  before_action :ensure_correct_user

  def create
    @book_comment = current_user.book_comments.new(book_comment_params)
    if @book_comment.save
      redirect_to book_path(@book), notice: "You have created comment successfully."
    else
      @newbook = Book.new
      @book_comments = @book.book_comments
      render template: 'books/show'
    end
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id], book_id: @book)
    if @book_comment.destroy
      redirect_to book_path(@book), notice: "You have delete comment successfully."
    else
      render template: 'books/show'
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
