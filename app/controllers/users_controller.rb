class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def search
    @search = params[:search]
    @user_or_book = params[:model_choose]
    @search_option = params[:option]
    if @user_or_book == "1"
      @users = User.search(@search, @user_or_book, @search_option)
    else
      @posts = Post.search(@search, @user_or_book, @search_option)
    end
  end
  
  def User.search(search, user_or_book, search_option)
    if search_option == "1"
      User.where(['name LIKE ?', "#{search}"])
    elsif search_option == "2"
      User.where(['name LIKE ?', "#{search}%"])
    elsif search_option == "3"
      User.where(['name LIKE ?', "%#{search}"])
    elsif search_option == "4"
      User.where(['name LIKE ?', "%#{search}%"])
    else    
      User.all
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
