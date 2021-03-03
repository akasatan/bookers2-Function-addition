class SearchsController < ApplicationController
      
  def search
    @search = params[:search]
    @user_or_book = params[:model_choose]
    @search_option = params[:option]
    if @user_or_book == "1"
      @users = User.search(@search, @user_or_book, @search_option)
    else
      #titleだけヒットするようにしているよ
      @books = Book.search(@search, @user_or_book, @search_option)
    end
  end
  
end
