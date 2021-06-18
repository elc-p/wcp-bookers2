class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ownuser, only: [:edit, :update]
  
  def index
    @book = Book.new(book_params)
    @user = current_user
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully'
    else
      render 'edit'
    end
    
  end
  
  private
  
  def book_params
    params.permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def ownuser
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
end
